import Foundation

enum AppRoute: Equatable {
    case launching
    case firstSession(FirstSessionRoute)
    case mainTab(MainTabRoute)
}

enum FirstSessionRoute: Equatable {
    case home
    case capture
    case photoPreview
    case qualityFail(QualityFailureReason)
    case analyzing
    case readMe
    case contextOnboarding
    case todayFirstReady
}

enum MainTabRoute: Hashable {
    case readMe
    case today
    case ask
    case myStory
}

enum AnalysisProgressStage: String, Codable, Equatable, CaseIterable {
    case checkingQuality
    case observingStructure
    case groundingXiangxue
    case synthesizingTension
}

enum QualityFailureReason: String, Codable, CaseIterable, Equatable {
    case noFace = "no_face"
    case multipleFaces = "multiple_faces"
    case lowClarity = "low_clarity"
    case notFrontal = "not_frontal"
    case poorLighting = "poor_lighting"
    case heavyOcclusion = "heavy_occlusion"
    case keyRegionMissing = "key_region_missing"

    var title: String {
        switch self {
        case .noFace:
            return "没有检测到清晰正脸"
        case .multipleFaces:
            return "这张照片里有多人"
        case .lowClarity:
            return "照片不够清晰，额头和五官不够稳定"
        case .notFrontal:
            return "角度偏侧，无法进入完整分析"
        case .poorLighting:
            return "光线太暗，额头和五官不够清楚"
        case .heavyOcclusion:
            return "遮挡过多，无法判断关键部位"
        case .keyRegionMissing:
            return "关键区域缺失，暂时无法进入完整分析"
        }
    }

    var suggestion: String {
        switch self {
        case .noFace:
            return "请换一张正脸、距离更近、只包含你一个人的照片。"
        case .multipleFaces:
            return "请重新选择只有你一个人的照片。"
        case .lowClarity:
            return "尽量使用更清楚的照片，避免抖动和过度压缩。"
        case .notFrontal:
            return "请使用更接近正面的照片，避免明显侧脸。"
        case .poorLighting:
            return "尽量站到自然光下，让额头、眉眼和鼻部更清楚。"
        case .heavyOcclusion:
            return "请露出额头、眉眼、鼻部和下巴，减少遮挡。"
        case .keyRegionMissing:
            return "请保证额头、眉眼、鼻部、口部和下庭都在画面里。"
        }
    }
}

enum RegionVisibility: String, Codable {
    case clear
    case partial
    case blocked
}

enum LightingCondition: String, Codable {
    case bright
    case balanced
    case dim
    case backlit
}

enum OcclusionLevel: String, Codable {
    case none
    case low
    case medium
    case high
}

struct ImageAsset: Codable, Equatable {
    let imageId: String
    let source: String
    let width: Int
    let height: Int
    let mimeType: String
    let createdAt: String
}

struct FaceQualityAssessment: Codable, Equatable {
    let passed: Bool
    let singleFace: Bool
    let frontalScore: Double
    let clarityScore: Double
    let lighting: LightingCondition
    let occlusion: OcclusionLevel
    let regionVisibility: [String: RegionVisibility]
    let failureReasons: [QualityFailureReason]
}

struct ObservedFeature: Codable, Equatable, Identifiable {
    let id: String
    let area: String
    let subArea: String?
    let signalType: String
    let value: String
    let confidence: Double
    let evidence: String
}

struct OfficialAssessment: Codable, Equatable, Identifiable {
    let id: String
    let name: String
    let observedFeatureIds: [String]
    let strengths: [String]
    let risks: [String]
    let xiangxueMeaning: String
    let weight: Double
}

struct ZoneAssessment: Codable, Equatable, Identifiable {
    let id: String
    let observedFeatureIds: [String]
    let balance: String
    let xiangxueMeaning: String
    let userFacingMeaning: String
    let weight: Double
}

struct PalaceAssessment: Codable, Equatable, Identifiable {
    let id: String
    let name: String
    let region: String
    let observedFeatureIds: [String]
    let status: String
    let xiangxueMeaning: String
    let userFacingMeaning: String
    let weight: Double
}

struct EvidenceCitation: Codable, Equatable, Identifiable {
    let id: String
    let sourceFile: String
    let pageTitle: String?
    let chunkId: String?
    let excerpt: String
}

struct KnowledgeTopicHit: Codable, Equatable, Identifiable {
    let id: String
    let topicType: String
    let title: String
    let matchedFeatureIds: [String]
    let summary: String
    let sourceRefs: [EvidenceCitation]
    let confidence: Double
}

struct RuleHit: Codable, Equatable, Identifiable {
    let id: String
    let category: String
    let observedFeatureIds: [String]
    let supportingTopicIds: [String]
    let xiangxueMeaning: String
    let userFacingMeaning: String
    let weight: Double
}

struct InterpretationArc: Codable, Equatable, Identifiable {
    let id: String
    let title: String
    let summary: String
    let supportingRuleIds: [String]
    let dominantTheme: String
    let confidence: Double
}

struct TensionHypothesis: Codable, Equatable, Identifiable {
    let id: String
    let tensionType: String
    let confidence: Double
    let supportingArcIds: [String]
    let supportingRuleIds: [String]
    let explanation: String
}

struct ExplanationTrace: Codable, Equatable {
    let primaryObservedFeatures: [String]
    let primaryOfficialAssessments: [String]
    let primaryZoneAssessments: [String]
    let primaryPalaceAssessments: [String]
    let primaryRuleHits: [String]
    let primaryInterpretationArcs: [String]
    let primaryTensionHypotheses: [String]
    let evidenceRefs: [EvidenceCitation]
    let whySummary: String
}

struct ReadMeOutput: Codable, Equatable {
    let hookLine: String
    let overallPattern: String
    let relationshipSignal: String
    let careerOrRealitySignal: String
    let defensePattern: String
    let attractionPattern: String
    let primaryTension: String
    let whyThisFeelsTrue: String
    let nextQuestion: String
    let trace: ExplanationTrace
}

struct FaceAnalysisSnapshot: Codable, Equatable {
    let imageAsset: ImageAsset
    let quality: FaceQualityAssessment
    let observedFeatures: [ObservedFeature]
    let officialAssessments: [OfficialAssessment]
    let zoneAssessments: [ZoneAssessment]
    let palaceAssessments: [PalaceAssessment]
    let topicHits: [KnowledgeTopicHit]
    let ruleHits: [RuleHit]
    let interpretationArcs: [InterpretationArc]
    let tensionHypotheses: [TensionHypothesis]
    let readMeOutput: ReadMeOutput
    let createdAt: String
}

struct ContextQuestion: Identifiable, Equatable {
    let id: String
    let prompt: String
    let quickOptions: [String]
    let placeholder: String
}

struct User: Codable, Equatable {
    let userId: String
    let identityType: String
    let createdAt: String
    let lastActiveAt: String
    let status: String
}

struct UserProfile: Codable, Equatable {
    let userId: String
    var displayName: String?
    let locale: String
    let timezone: String
    var preferredFocus: String?
    var currentPrimaryThreadId: String?
}

struct FaceReadingSnapshot: Codable, Equatable {
    let snapshotId: String
    let userId: String
    let imageId: String
    let qualityPassed: Bool
    let faceProfileId: String
    let readMeVersion: String
    let createdAt: String
}

struct MemoryItem: Codable, Equatable, Identifiable {
    let id: String
    let userId: String
    let category: String
    let key: String
    var value: String
    let source: String
    var confidence: Double
    var status: String
    let isSensitive: Bool
    var lastConfirmedAt: String?
    let createdAt: String
    var updatedAt: String
}

struct TensionProfile: Codable, Equatable, Identifiable {
    let id: String
    let userId: String
    let tensionType: String
    var strength: Double
    let source: String
    var status: String
    let createdAt: String
    var updatedAt: String
}

struct GuidanceThread: Codable, Equatable, Identifiable {
    let id: String
    let userId: String
    let type: String
    var title: String
    let primaryTensionId: String
    var phase: String
    var status: String
    let startedAt: String
    var lastActiveAt: String
}

struct ThreadMessage: Codable, Equatable, Identifiable {
    let id: String
    let threadId: String
    let role: String
    let content: String
    let summary: String?
    let createdAt: String
}

struct DailyGuidance: Codable, Equatable {
    let guidanceId: String
    let userId: String
    let threadId: String
    let date: String
    let imbalancePoint: String
    let noticePoint: String
    let smallAction: String
    let followupQuestion: String
    let createdAt: String
}

struct WeeklyRecap: Codable, Equatable {
    let recapId: String
    let userId: String
    let weekKey: String
    let dominantTension: String
    let triggerScenarios: [String]
    let progressSignals: [String]
    let nextSuggestedThreadType: String?
    let createdAt: String
}

struct AppSessionSnapshot: Codable, Equatable {
    var user: User
    var profile: UserProfile
    var latestFaceAnalysis: FaceAnalysisSnapshot?
    var latestFaceReading: FaceReadingSnapshot?
    var tensions: [TensionProfile]
    var threads: [GuidanceThread]
    var messages: [ThreadMessage]
    var memories: [MemoryItem]
    var todayGuidance: DailyGuidance?
    var weeklyRecap: WeeklyRecap?
}

extension ReadMeOutput {
    var sections: [(String, String)] {
        [
            ("整体格局", overallPattern),
            ("关系信号", relationshipSignal),
            ("现实与事业信号", careerOrRealitySignal),
            ("防御方式", defensePattern),
            ("吸引力与靠近方式", attractionPattern),
            ("当前主 tension", primaryTension)
        ]
    }
}
