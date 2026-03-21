import SwiftUI
import UIKit

struct FirstSessionCoordinatorView: View {
    let route: FirstSessionRoute

    var body: some View {
        switch route {
        case .home:
            HomeView()
        case .capture:
            CaptureView()
        case .photoPreview:
            PhotoPreviewView()
        case .qualityFail(let reason):
            QualityFailView(reason: reason)
        case .analyzing:
            AnalyzingView()
        case .readMe:
            ReadMeView()
        case .contextOnboarding:
            ContextOnboardingView()
        case .todayFirstReady:
            TodayFirstReadyView()
        }
    }
}

struct HomeView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            SectionTitle(
                eyebrow: "Read Me",
                title: "从脸开始认识你现在的状态",
                bodyText: "这不是面部识别工具，而是一段从自拍进入的相学顾问体验。它会先看整体格局、五官功能、三停与重点宫位，再给你第一版画像。"
            )

            PageCard {
                VStack(alignment: .leading, spacing: 10) {
                    Text("它会怎么看你")
                        .font(AppFont.title(18))
                    Text("先看整体结构，再解释为什么会落到你现在的 tension，而不是只告诉你五官像什么。")
                        .font(AppFont.body(15))
                        .foregroundStyle(AppTheme.muted)
                }
            }

            VStack(spacing: 12) {
                PrimaryCTAButton(title: "开始看我现在的状态") {
                    sessionStore.goToCapture()
                }
                SecondaryCTAButton(title: "从相册选择") {
                    sessionStore.goToCapture()
                }
            }

            PageCard(title: "说明") {
                Text("照片只用于生成画像，你可以后续删除。输出是文化解读与方向参考，不替代医疗、法律或投资建议。")
                    .font(AppFont.body(14))
                    .foregroundStyle(AppTheme.muted)
            }
        }
    }
}

struct CaptureView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    @State private var showingCamera = false
    @State private var showingCameraUnavailableAlert = false

    var body: some View {
        ScreenContainer {
            SectionTitle(
                eyebrow: "Capture",
                title: "先给我一张清晰正脸",
                bodyText: "正脸、自然光、无遮挡、单人。照片越干净，后面的判断越稳。"
            )

            PageCard {
                RoundedRectangle(cornerRadius: 24, style: .continuous)
                    .fill(Color.white.opacity(0.45))
                    .frame(height: 300)
                    .overlay(
                        VStack(spacing: 10) {
                            Image(systemName: "person.crop.rectangle")
                                .font(.system(size: 40))
                                .foregroundStyle(AppTheme.muted)
                            Text("请选择一张照片，或直接拍一张新的正脸照")
                                .font(AppFont.body(15))
                                .foregroundStyle(AppTheme.muted)
                        }
                    )
            }

            VStack(spacing: 12) {
                PrimaryCTAButton(title: "拍一张照片") {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        showingCamera = true
                    } else {
                        showingCameraUnavailableAlert = true
                    }
                }
                PhotoPickerButton(title: "从相册选择") { image, data in
                    sessionStore.setSelectedPhoto(image, data: data)
                }
            }

            if let session = sessionStore.appSession,
               let snapshot = session.latestFaceReading {
                PageCard(title: "最近一次记录") {
                    Text("最近一次 Read Me 生成于 \(String(snapshot.createdAt.prefix(16)))")
                        .font(AppFont.body(14))
                        .foregroundStyle(AppTheme.muted)
                }
            }
        }
        .sheet(isPresented: $showingCamera) {
            CameraCaptureSheet { image, data in
                sessionStore.setSelectedPhoto(image, data: data)
            }
            .ignoresSafeArea()
        }
        .alert("当前设备不支持摄像头", isPresented: $showingCameraUnavailableAlert) {
            Button("知道了", role: .cancel) {}
        } message: {
            Text("你现在可以先从相册选择一张照片继续。")
        }
    }
}

struct PhotoPreviewView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    @State private var showingCamera = false
    @State private var showingCameraUnavailableAlert = false

    var body: some View {
        ScreenContainer {
            SectionTitle(
                eyebrow: "Preview",
                title: "确认一下这张照片",
                bodyText: "上传后会先做质量检查，再进入相学分析。"
            )

            PageCard {
                if let image = sessionStore.selectedImage {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .clipShape(RoundedRectangle(cornerRadius: 24, style: .continuous))
                } else {
                    RoundedRectangle(cornerRadius: 24, style: .continuous)
                        .fill(Color.white.opacity(0.45))
                        .frame(height: 260)
                }
            }

            PageCard(title: "拍摄指引") {
                Text("正脸、自然光、无遮挡、单人。照片越干净，后面的判断越稳。")
                    .font(AppFont.body(15))
                    .foregroundStyle(AppTheme.muted)
            }

            VStack(spacing: 12) {
                PrimaryCTAButton(title: "使用这张照片") {
                    sessionStore.submitSelectedPhoto()
                }
                SecondaryCTAButton(title: "重新拍照") {
                    if UIImagePickerController.isSourceTypeAvailable(.camera) {
                        showingCamera = true
                    } else {
                        showingCameraUnavailableAlert = true
                    }
                }
                PhotoPickerButton(title: "重新选择") { image, data in
                    sessionStore.setSelectedPhoto(image, data: data)
                }
            }
        }
        .sheet(isPresented: $showingCamera) {
            CameraCaptureSheet { image, data in
                sessionStore.setSelectedPhoto(image, data: data)
            }
            .ignoresSafeArea()
        }
        .alert("当前设备不支持摄像头", isPresented: $showingCameraUnavailableAlert) {
            Button("知道了", role: .cancel) {}
        } message: {
            Text("你现在可以先从相册选择一张照片继续。")
        }
    }
}

struct QualityFailView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    let reason: QualityFailureReason

    var body: some View {
        ScreenContainer {
            SectionTitle(
                eyebrow: "Quality Check",
                title: reason.title,
                bodyText: "这次不是识别失败，而是这张图还不够适合进入完整分析。"
            )

            PageCard(title: "建议") {
                Text(reason.suggestion)
                    .font(AppFont.body(16))
                    .foregroundStyle(AppTheme.muted)
            }

            VStack(spacing: 12) {
                PrimaryCTAButton(title: "重新拍照") {
                    sessionStore.retryFromQualityFailure()
                }
                SecondaryCTAButton(title: "从相册选择另一张") {
                    sessionStore.retryFromQualityFailure()
                }
            }
        }
    }
}

struct AnalyzingView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            SectionTitle(
                eyebrow: "Analyzing",
                title: "正在整理你的第一版画像",
                bodyText: "我们先检查照片质量，再观察整体格局与关键部位，最后把它整理成更像你的表达。"
            )

            PageCard {
                VStack(alignment: .leading, spacing: 14) {
                    stage("正在检查照片质量", active: sessionStore.analysisStage == .checkingQuality)
                    stage("正在观察你的整体格局与关键部位", active: sessionStore.analysisStage == .observingStructure)
                    stage("正在把观察结果落到相学系统里", active: sessionStore.analysisStage == .groundingXiangxue)
                    stage("正在整理你的第一版画像", active: sessionStore.analysisStage == .synthesizingTension)
                }
            }

            PageCard(title: "等待说明") {
                Text("如果等待稍长，不代表失败，而是系统正在把观察结果整理成更像你的表述。")
                    .font(AppFont.body(14))
                    .foregroundStyle(AppTheme.muted)
            }
        }
    }

    private func stage(_ title: String, active: Bool) -> some View {
        HStack(spacing: 12) {
            Circle()
                .fill(active ? AppTheme.accent : AppTheme.softBorder)
                .frame(width: 12, height: 12)
            Text(title)
                .font(AppFont.body(15))
                .foregroundStyle(AppTheme.ink)
        }
    }
}

struct ReadMeView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            if let analysis = sessionStore.currentAnalysis {
                let readMe = analysis.readMeOutput
                SectionTitle(
                    eyebrow: "Read Me",
                    title: "先看见你现在卡在哪里",
                    bodyText: "先给命中感，再解释为什么会这样。"
                )

                PageCard(title: "Hook") {
                    Text(readMe.hookLine)
                        .font(AppFont.title(22))
                        .foregroundStyle(AppTheme.ink)
                }

                ForEach(readMe.sections, id: \.0) { section in
                    PageCard(title: section.0) {
                        Text(section.1)
                            .font(AppFont.body(16))
                            .foregroundStyle(AppTheme.muted)
                    }
                }

                PageCard(title: "为什么这么判断") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("我看到了什么")
                            .font(AppFont.title(16))
                        ForEach(analysis.observedFeatures.prefix(4)) { feature in
                            Text("• \(feature.value)")
                                .font(AppFont.body(15))
                                .foregroundStyle(AppTheme.muted)
                        }

                        Text("这些位置通常在相学里指向什么")
                            .font(AppFont.title(16))
                            .padding(.top, 6)
                        ForEach(analysis.ruleHits.prefix(3)) { rule in
                            Text("• \(rule.userFacingMeaning)")
                                .font(AppFont.body(15))
                                .foregroundStyle(AppTheme.muted)
                        }

                        Text("为什么会落到你现在的 tension")
                            .font(AppFont.title(16))
                            .padding(.top, 6)
                        Text(readMe.whyThisFeelsTrue)
                            .font(AppFont.body(15))
                            .foregroundStyle(AppTheme.muted)
                    }
                }

                PageCard(title: "内部 Trace") {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("主规则")
                            .font(AppFont.title(15))
                        Text(readMe.trace.primaryRuleHits.joined(separator: " · "))
                            .font(AppFont.body(13))
                            .foregroundStyle(AppTheme.muted)
                        Text("解释弧线")
                            .font(AppFont.title(15))
                            .padding(.top, 4)
                        Text(readMe.trace.primaryInterpretationArcs.joined(separator: " · "))
                            .font(AppFont.body(13))
                            .foregroundStyle(AppTheme.muted)
                        Text("证据摘要")
                            .font(AppFont.title(15))
                            .padding(.top, 4)
                        Text(readMe.trace.whySummary)
                            .font(AppFont.body(13))
                            .foregroundStyle(AppTheme.muted)
                    }
                }

                PageCard(title: "下一步问题") {
                    Text(readMe.nextQuestion)
                        .font(AppFont.body(16))
                        .foregroundStyle(AppTheme.ink)
                }

                VStack(spacing: 12) {
                    PrimaryCTAButton(title: "继续，让它更贴近我现在的处境") {
                        sessionStore.proceedToOnboarding()
                    }
                    SecondaryCTAButton(title: "换一张照片重看") {
                        sessionStore.clearSelectedPhoto()
                    }
                }
            }
        }
    }
}

struct ContextOnboardingView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    @State private var currentIndex = 0
    @State private var customInput = ""

    var body: some View {
        let question = sessionStore.onboardingQuestions[currentIndex]

        ScreenContainer {
            SectionTitle(
                eyebrow: "Context",
                title: "只要一点现实处境，我就能把刚才那段判断说得更贴近你",
                bodyText: "这里不是长表单，只是帮我们把面相判断接到你现在的生活主线。"
            )

            PageCard(title: "第 \(currentIndex + 1) / \(sessionStore.onboardingQuestions.count) 题") {
                Text(question.prompt)
                    .font(AppFont.title(20))
                    .foregroundStyle(AppTheme.ink)

                VStack(alignment: .leading, spacing: 10) {
                    ForEach(question.quickOptions, id: \.self) { option in
                        Button {
                            save(option)
                        } label: {
                            Text(option)
                                .font(AppFont.body(15))
                                .foregroundStyle(AppTheme.ink)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(14)
                                .background(Color.white.opacity(0.55))
                                .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                        .buttonStyle(.plain)
                    }
                }

                VStack(alignment: .leading, spacing: 8) {
                    Text("也可以自己写")
                        .font(AppFont.body(14))
                        .foregroundStyle(AppTheme.muted)
                    TextField(question.placeholder, text: $customInput)
                        .textFieldStyle(.roundedBorder)
                    PrimaryCTAButton(title: currentIndex == sessionStore.onboardingQuestions.count - 1 ? "完成" : "保存并继续") {
                        save(customInput.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "暂时跳过" : customInput)
                    }
                }
            }

            SecondaryCTAButton(title: "跳过这题") {
                save("暂时跳过")
            }
        }
    }

    private func save(_ value: String) {
        let question = sessionStore.onboardingQuestions[currentIndex]
        sessionStore.saveOnboardingResponse(questionID: question.id, value: value)
        customInput = ""

        if currentIndex == sessionStore.onboardingQuestions.count - 1 {
            sessionStore.completeOnboarding()
        } else {
            currentIndex += 1
        }
    }
}

struct TodayFirstReadyView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            SectionTitle(
                eyebrow: "Today",
                title: "我会沿着你刚才提到的主线，继续往下看",
                bodyText: "这不是泛泛的今日运势，而是基于你刚才的 tension 和现实处境，给你的第一条今日 guidance。"
            )

            if let today = sessionStore.appSession?.todayGuidance {
                PageCard(title: "今日主线") {
                    Text(today.noticePoint)
                        .font(AppFont.title(22))
                    Text(today.imbalancePoint)
                        .font(AppFont.body(15))
                        .foregroundStyle(AppTheme.muted)
                }

                PageCard(title: "一个小行动") {
                    Text(today.smallAction)
                        .font(AppFont.body(16))
                        .foregroundStyle(AppTheme.ink)
                    Text(today.followupQuestion)
                        .font(AppFont.body(14))
                        .foregroundStyle(AppTheme.muted)
                }
            }

            VStack(spacing: 12) {
                PrimaryCTAButton(title: "围绕这件事继续问") {
                    sessionStore.enterMainTabs(tab: .ask)
                }
                SecondaryCTAButton(title: "先收下今天这条提醒") {
                    sessionStore.enterMainTabs(tab: .today)
                }
            }
        }
    }
}
