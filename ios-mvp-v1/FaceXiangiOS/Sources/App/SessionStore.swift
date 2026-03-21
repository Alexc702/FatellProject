import Foundation
import UIKit

@MainActor
final class SessionStore: ObservableObject {
    @Published var route: AppRoute = .firstSession(.home)
    @Published var selectedTab: MainTabRoute = .today
    @Published var selectedImage: UIImage?
    @Published var selectedImageData: Data?
    @Published var analysisStage: AnalysisProgressStage = .checkingQuality
    @Published var isAnalyzing = false
    @Published var onboardingResponses: [String: String] = [:]
    @Published var appSession: AppSessionSnapshot?
    @Published var currentDraftMessage = ""
    @Published var showingMemorySheet = false
    @Published var showingSettingsSheet = false

    let onboardingQuestions: [ContextQuestion] = [
        .init(
            id: "fear",
            prompt: "你现在最担心失去什么？",
            quickOptions: ["稳定感", "一段关系", "工作机会", "自己的节奏"],
            placeholder: "也可以写得更具体一点"
        ),
        .init(
            id: "desire",
            prompt: "你最想推进的一件事是什么？",
            quickOptions: ["关系更清楚", "工作更有把握", "先把自己稳住", "做一个决定"],
            placeholder: "你最想往前推的那件事"
        ),
        .init(
            id: "person",
            prompt: "最近最牵动你情绪的是谁？",
            quickOptions: ["伴侣或喜欢的人", "上级或同事", "家人", "我自己"],
            placeholder: "可以写名字或关系"
        ),
        .init(
            id: "focus",
            prompt: "你希望我先更关注哪条主线？",
            quickOptions: ["关系", "工作", "内在状态", "决定与方向"],
            placeholder: "也可以自己写"
        )
    ]

    private let analysisService = LocalAnalysisService()
    private let defaults = UserDefaults.standard
    private let readmeVersion = "v1-trace-local"

    init() {
        restore()
    }

    var hasCompletedReadMe: Bool {
        appSession?.latestFaceAnalysis?.quality.passed == true
    }

    var hasCompletedOnboarding: Bool {
        !(appSession?.threads.isEmpty ?? true)
    }

    var currentAnalysis: FaceAnalysisSnapshot? {
        appSession?.latestFaceAnalysis
    }

    var currentReadMeOutput: ReadMeOutput? {
        currentAnalysis?.readMeOutput
    }

    var currentThread: GuidanceThread? {
        guard let appSession else { return nil }
        if let threadId = appSession.profile.currentPrimaryThreadId {
            return appSession.threads.first(where: { $0.id == threadId })
        }
        return appSession.threads.first
    }

    var currentThreadMessages: [ThreadMessage] {
        guard let currentThread, let appSession else { return [] }
        return appSession.messages.filter { $0.threadId == currentThread.id }
    }

    var currentMemories: [MemoryItem] {
        appSession?.memories.filter { $0.status != "deleted" } ?? []
    }

    var currentTension: TensionProfile? {
        appSession?.tensions.first(where: { $0.status == "primary" }) ?? appSession?.tensions.first
    }

    func goHome() {
        route = .firstSession(.home)
    }

    func goToCapture() {
        route = .firstSession(.capture)
    }

    func setSelectedPhoto(_ image: UIImage, data: Data) {
        selectedImage = image
        selectedImageData = data
        route = .firstSession(.photoPreview)
    }

    func clearSelectedPhoto() {
        selectedImage = nil
        selectedImageData = nil
        route = .firstSession(.capture)
    }

    func retryFromQualityFailure() {
        route = .firstSession(.capture)
    }

    func submitSelectedPhoto() {
        guard selectedImageData != nil else { return }
        route = .firstSession(.analyzing)
        isAnalyzing = true
        analysisStage = .checkingQuality

        Task {
            await runAnalysis()
        }
    }

    func proceedToOnboarding() {
        route = .firstSession(.contextOnboarding)
    }

    func saveOnboardingResponse(questionID: String, value: String) {
        onboardingResponses[questionID] = value
        persist()
    }

    func completeOnboarding() {
        guard var session = appSession,
              let analysis = session.latestFaceAnalysis else { return }

        let state = analysisService.createRelationshipState(
            userId: session.user.userId,
            onboardingResponses: onboardingResponses,
            analysis: analysis
        )

        session.profile.preferredFocus = normalizePreferredFocus(onboardingResponses["focus"])
        session.profile.currentPrimaryThreadId = state.thread.id
        session.tensions = state.tensions
        session.threads = [state.thread]
        session.messages = state.messages
        session.memories = state.memories
        session.todayGuidance = analysisService.makeTodayGuidance(
            userId: session.user.userId,
            threadId: state.thread.id,
            readMe: analysis.readMeOutput,
            onboardingResponses: onboardingResponses
        )
        session.weeklyRecap = state.weeklyRecap
        session.user = User(
            userId: session.user.userId,
            identityType: session.user.identityType,
            createdAt: session.user.createdAt,
            lastActiveAt: timestamp(),
            status: session.user.status
        )

        appSession = session
        route = .firstSession(.todayFirstReady)
        persist()
    }

    func enterMainTabs(tab: MainTabRoute = .today) {
        selectedTab = tab
        route = .mainTab(tab)
    }

    func selectTab(_ tab: MainTabRoute) {
        selectedTab = tab
        route = .mainTab(tab)
    }

    func sendCurrentMessage() {
        let trimmed = currentDraftMessage.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty,
              var session = appSession,
              var thread = currentThread else { return }

        let userMessage = ThreadMessage(
            id: UUID().uuidString,
            threadId: thread.id,
            role: "user",
            content: trimmed,
            summary: nil,
            createdAt: timestamp()
        )

        let response = analysisService.reply(
            to: trimmed,
            thread: thread,
            tensions: session.tensions,
            memories: session.memories,
            analysis: session.latestFaceAnalysis
        )

        thread.phase = response.updatedPhase
        thread.lastActiveAt = timestamp()

        if let index = session.threads.firstIndex(where: { $0.id == thread.id }) {
            session.threads[index] = thread
        }

        session.messages.append(userMessage)
        session.messages.append(response.reply)
        session.memories.append(contentsOf: response.newMemories)
        session.todayGuidance = session.todayGuidance.map {
            DailyGuidance(
                guidanceId: $0.guidanceId,
                userId: $0.userId,
                threadId: $0.threadId,
                date: $0.date,
                imbalancePoint: $0.imbalancePoint,
                noticePoint: $0.noticePoint,
                smallAction: $0.smallAction,
                followupQuestion: response.reply.content,
                createdAt: $0.createdAt
            )
        }
        session.user = User(
            userId: session.user.userId,
            identityType: session.user.identityType,
            createdAt: session.user.createdAt,
            lastActiveAt: timestamp(),
            status: session.user.status
        )

        appSession = session
        currentDraftMessage = ""
        persist()
    }

    func suppressMemory(_ memory: MemoryItem) {
        updateMemory(memory.id) { item in
            item.status = "suppressed"
            item.updatedAt = timestamp()
        }
    }

    func confirmMemory(_ memory: MemoryItem) {
        updateMemory(memory.id) { item in
            item.status = "active"
            item.lastConfirmedAt = timestamp()
            item.updatedAt = timestamp()
        }
    }

    func deleteMemory(_ memory: MemoryItem) {
        updateMemory(memory.id) { item in
            item.status = "deleted"
            item.updatedAt = timestamp()
        }
    }

    func resetAllData() {
        selectedImage = nil
        selectedImageData = nil
        analysisStage = .checkingQuality
        isAnalyzing = false
        onboardingResponses = [:]
        appSession = makeEmptySession()
        currentDraftMessage = ""
        showingMemorySheet = false
        showingSettingsSheet = false
        route = .firstSession(.home)
        selectedTab = .today
        persist()
    }

    private func updateMemory(_ memoryID: String, mutate: (inout MemoryItem) -> Void) {
        guard var session = appSession,
              let index = session.memories.firstIndex(where: { $0.id == memoryID }) else { return }
        var item = session.memories[index]
        mutate(&item)
        session.memories[index] = item
        appSession = session
        persist()
    }

    private func runAnalysis() async {
        guard let imageData = selectedImageData else { return }

        do {
            analysisStage = .checkingQuality
            try await Task.sleep(nanoseconds: 500_000_000)

            let analysis = try analysisService.analyze(imageData: imageData, source: "library")
            guard analysis.quality.passed else {
                isAnalyzing = false
                let reason = analysis.quality.failureReasons.first ?? .noFace
                route = .firstSession(.qualityFail(reason))
                return
            }

            analysisStage = .observingStructure
            try await Task.sleep(nanoseconds: 500_000_000)

            analysisStage = .groundingXiangxue
            try await Task.sleep(nanoseconds: 500_000_000)

            analysisStage = .synthesizingTension
            try await Task.sleep(nanoseconds: 500_000_000)

            var session = appSession ?? makeEmptySession()
            session.latestFaceAnalysis = analysis
            session.latestFaceReading = FaceReadingSnapshot(
                snapshotId: UUID().uuidString,
                userId: session.user.userId,
                imageId: analysis.imageAsset.imageId,
                qualityPassed: analysis.quality.passed,
                faceProfileId: analysis.imageAsset.imageId,
                readMeVersion: readmeVersion,
                createdAt: timestamp()
            )
            session.user = User(
                userId: session.user.userId,
                identityType: session.user.identityType,
                createdAt: session.user.createdAt,
                lastActiveAt: timestamp(),
                status: session.user.status
            )
            appSession = session

            isAnalyzing = false
            route = .firstSession(.readMe)
            persist()
        } catch {
            isAnalyzing = false
            route = .firstSession(.qualityFail(.noFace))
        }
    }

    private func restore() {
        if let session = decode(AppSessionSnapshot.self, key: "fx.session") {
            appSession = session
            onboardingResponses = defaults.dictionary(forKey: "fx.onboarding") as? [String: String] ?? [:]

            if session.profile.currentPrimaryThreadId != nil {
                route = .mainTab(.today)
                selectedTab = .today
            } else if session.latestFaceAnalysis?.quality.passed == true {
                route = .firstSession(.readMe)
            } else {
                route = .firstSession(.home)
            }
        } else {
            appSession = makeEmptySession()
            route = .firstSession(.home)
        }
    }

    private func persist() {
        defaults.set(onboardingResponses, forKey: "fx.onboarding")
        encode(appSession, key: "fx.session")
    }

    private func encode<T: Encodable>(_ value: T?, key: String) {
        guard let value else {
            defaults.removeObject(forKey: key)
            return
        }
        defaults.set(try? JSONEncoder().encode(value), forKey: key)
    }

    private func decode<T: Decodable>(_ type: T.Type, key: String) -> T? {
        guard let data = defaults.data(forKey: key) else { return nil }
        return try? JSONDecoder().decode(type, from: data)
    }

    private func makeEmptySession() -> AppSessionSnapshot {
        let userId = defaults.string(forKey: "fx.userId") ?? UUID().uuidString
        defaults.set(userId, forKey: "fx.userId")

        let now = timestamp()
        return AppSessionSnapshot(
            user: User(
                userId: userId,
                identityType: "anonymous",
                createdAt: now,
                lastActiveAt: now,
                status: "active"
            ),
            profile: UserProfile(
                userId: userId,
                displayName: nil,
                locale: Locale.current.identifier,
                timezone: TimeZone.current.identifier,
                preferredFocus: nil,
                currentPrimaryThreadId: nil
            ),
            latestFaceAnalysis: nil,
            latestFaceReading: nil,
            tensions: [],
            threads: [],
            messages: [],
            memories: [],
            todayGuidance: nil,
            weeklyRecap: nil
        )
    }

    private func normalizePreferredFocus(_ text: String?) -> String? {
        guard let text else { return nil }
        if text.contains("关系") { return "relationship" }
        if text.contains("工作") || text.contains("事业") { return "work" }
        if text.contains("内在") { return "inner_state" }
        return text
    }

    private func timestamp() -> String {
        ISO8601DateFormatter().string(from: Date())
    }
}
