import CoreImage
import CoreImage.CIFilterBuiltins
import Foundation
import UIKit
import Vision

struct FaceObservationMetrics {
    let faceCount: Int
    let primaryBoundingBox: CGRect?
    let averageBrightness: Double
}

enum LocalAnalysisError: Error {
    case invalidImageData
}

final class LocalAnalysisService {
    private let ciContext = CIContext()

    func analyze(imageData: Data, source: String) throws -> FaceAnalysisSnapshot {
        let metrics = try analyzeMetrics(for: imageData)
        let quality = makeQualityAssessment(from: metrics)
        let imageAsset = makeImageAsset(from: imageData, source: source)

        guard quality.passed else {
            return FaceAnalysisSnapshot(
                imageAsset: imageAsset,
                quality: quality,
                observedFeatures: [],
                officialAssessments: [],
                zoneAssessments: [],
                palaceAssessments: [],
                topicHits: [],
                ruleHits: [],
                interpretationArcs: [],
                tensionHypotheses: [],
                readMeOutput: makeFallbackReadMe(),
                createdAt: timestamp()
            )
        }

        let observedFeatures = makeObservedFeatures(metrics: metrics, imageData: imageData)
        let officialAssessments = makeOfficialAssessments(from: observedFeatures)
        let zoneAssessments = makeZoneAssessments(from: observedFeatures)
        let palaceAssessments = makePalaceAssessments(from: observedFeatures)
        let topicHits = makeTopicHits(from: observedFeatures, officials: officialAssessments, zones: zoneAssessments, palaces: palaceAssessments)
        let ruleHits = makeRuleHits(
            observedFeatures: observedFeatures,
            officials: officialAssessments,
            zones: zoneAssessments,
            palaces: palaceAssessments,
            topicHits: topicHits
        )
        let arcs = makeInterpretationArcs(ruleHits: ruleHits)
        let tensions = makeTensionHypotheses(arcs: arcs, ruleHits: ruleHits)
        let readMeOutput = makeReadMeOutput(
            ruleHits: ruleHits,
            arcs: arcs,
            tensions: tensions,
            observedFeatures: observedFeatures,
            officials: officialAssessments,
            zones: zoneAssessments,
            palaces: palaceAssessments,
            topics: topicHits
        )

        return FaceAnalysisSnapshot(
            imageAsset: imageAsset,
            quality: quality,
            observedFeatures: observedFeatures,
            officialAssessments: officialAssessments,
            zoneAssessments: zoneAssessments,
            palaceAssessments: palaceAssessments,
            topicHits: topicHits,
            ruleHits: ruleHits,
            interpretationArcs: arcs,
            tensionHypotheses: tensions,
            readMeOutput: readMeOutput,
            createdAt: timestamp()
        )
    }

    func analyzeMetrics(for imageData: Data) throws -> FaceObservationMetrics {
        guard let uiImage = UIImage(data: imageData),
              let cgImage = uiImage.cgImage else {
            throw LocalAnalysisError.invalidImageData
        }

        let request = VNDetectFaceRectanglesRequest()
        let handler = VNImageRequestHandler(cgImage: cgImage, options: [:])
        try handler.perform([request])

        let observations = (request.results as? [VNFaceObservation]) ?? []
        let primaryBoundingBox = observations.first?.boundingBox
        let brightness = averageBrightness(for: cgImage)

        return FaceObservationMetrics(
            faceCount: observations.count,
            primaryBoundingBox: primaryBoundingBox,
            averageBrightness: brightness
        )
    }

    func makeTodayGuidance(
        userId: String,
        threadId: String,
        readMe: ReadMeOutput,
        onboardingResponses: [String: String]
    ) -> DailyGuidance {
        let focus = onboardingResponses["focus"] ?? "内在状态"
        let fear = onboardingResponses["fear"] ?? "失去现在的稳定感"

        return DailyGuidance(
            guidanceId: UUID().uuidString,
            userId: userId,
            threadId: threadId,
            date: dayString(),
            imbalancePoint: "你今天最容易失衡的点，是在\(focus)这条线上，对方还没给答案，你已经先开始替结果做防御。",
            noticePoint: "先留意自己什么时候会把不确定提前解释成坏结果。",
            smallAction: "把最想确认的一件事写成一句直接的话，不延伸，不猜测，也先不替别人回答。",
            followupQuestion: "如果你今天最怕失去的是\(fear)，那你最先开始防守的动作是什么？",
            createdAt: timestamp()
        )
    }

    func createRelationshipState(
        userId: String,
        onboardingResponses: [String: String],
        analysis: FaceAnalysisSnapshot
    ) -> (
        tensions: [TensionProfile],
        thread: GuidanceThread,
        messages: [ThreadMessage],
        memories: [MemoryItem],
        weeklyRecap: WeeklyRecap
    ) {
        let tension = analysis.tensionHypotheses.first ?? TensionHypothesis(
            id: UUID().uuidString,
            tensionType: "decision_anxiety",
            confidence: 0.6,
            supportingArcIds: [],
            supportingRuleIds: [],
            explanation: analysis.readMeOutput.primaryTension
        )
        let now = timestamp()

        let tensionProfile = TensionProfile(
            id: UUID().uuidString,
            userId: userId,
            tensionType: tension.tensionType,
            strength: tension.confidence,
            source: "face_reading",
            status: "primary",
            createdAt: now,
            updatedAt: now
        )

        let focus = normalizeFocus(onboardingResponses["focus"] ?? "内在状态")
        let thread = GuidanceThread(
            id: UUID().uuidString,
            userId: userId,
            type: focus,
            title: makeThreadTitle(from: focus, tension: analysis.readMeOutput.primaryTension),
            primaryTensionId: tensionProfile.id,
            phase: "problem_seen",
            status: "active",
            startedAt: now,
            lastActiveAt: now
        )

        let openingAssistant = ThreadMessage(
            id: UUID().uuidString,
            threadId: thread.id,
            role: "assistant",
            content: analysis.readMeOutput.primaryTension,
            summary: "初始主 tension",
            createdAt: now
        )

        let memories = makeMemoryItems(
            userId: userId,
            onboardingResponses: onboardingResponses,
            readMe: analysis.readMeOutput,
            thread: thread
        )

        let recap = WeeklyRecap(
            recapId: UUID().uuidString,
            userId: userId,
            weekKey: weekKey(),
            dominantTension: analysis.readMeOutput.primaryTension,
            triggerScenarios: [
                "在没有把握时先收住真实需求",
                "对关系或结果还没明朗时提前自我防御"
            ],
            progressSignals: [
                "已经愿意把现实处境告诉产品",
                "开始能描述自己最怕失去什么"
            ],
            nextSuggestedThreadType: focus,
            createdAt: now
        )

        return ([tensionProfile], thread, [openingAssistant], memories, recap)
    }

    func reply(
        to userMessage: String,
        thread: GuidanceThread,
        tensions: [TensionProfile],
        memories: [MemoryItem],
        analysis: FaceAnalysisSnapshot?
    ) -> (reply: ThreadMessage, updatedPhase: String, newMemories: [MemoryItem]) {
        let lower = userMessage.lowercased()
        let phase: String
        let replyText: String

        if lower.contains("怕") || lower.contains("担心") || lower.contains("失去") {
            phase = "emotion_unpacked"
            replyText = "你现在反复问这件事，说明真正卡住你的不只是结果本身，而是你担心一旦推进，就要独自承担失去后的后果。先别急着问会不会成，先问自己：我最怕失去的，到底是什么。"
        } else if lower.contains("要不要") || lower.contains("决定") || lower.contains("选") {
            phase = "resistance_identified"
            replyText = "你看起来像在做决定，但更深一层是在保护自己不被决定后的代价吞没。真正让你犹豫的不是选项，而是选完以后，你是否还能保住自己的位置。"
        } else {
            phase = "problem_seen"
            let primary = analysis?.readMeOutput.primaryTension ?? tensions.first?.tensionType ?? "当前主线"
            replyText = "先别急着扩展问题。你现在这句里最强的，还是那条旧 tension：\(primary)。如果继续拆，我们更应该看的是，你在靠近时最先启动的防御动作是什么。"
        }

        let memory = MemoryItem(
            id: UUID().uuidString,
            userId: thread.userId,
            category: "summary",
            key: "thread_reflection_\(UUID().uuidString.prefix(6))",
            value: userMessage,
            source: "user_input",
            confidence: 0.75,
            status: "active",
            isSensitive: true,
            lastConfirmedAt: timestamp(),
            createdAt: timestamp(),
            updatedAt: timestamp()
        )

        return (
            ThreadMessage(
                id: UUID().uuidString,
                threadId: thread.id,
                role: "assistant",
                content: replyText,
                summary: phase,
                createdAt: timestamp()
            ),
            phase,
            [memory]
        )
    }

    private func makeImageAsset(from imageData: Data, source: String) -> ImageAsset {
        let image = UIImage(data: imageData)
        return ImageAsset(
            imageId: UUID().uuidString,
            source: source,
            width: Int(image?.size.width ?? 0),
            height: Int(image?.size.height ?? 0),
            mimeType: "image/jpeg",
            createdAt: timestamp()
        )
    }

    private func makeQualityAssessment(from metrics: FaceObservationMetrics) -> FaceQualityAssessment {
        var failures: [QualityFailureReason] = []
        let box = metrics.primaryBoundingBox

        if metrics.faceCount == 0 {
            failures.append(.noFace)
        }
        if metrics.faceCount > 1 {
            failures.append(.multipleFaces)
        }
        if metrics.averageBrightness < 0.22 {
            failures.append(.poorLighting)
        }
        if let box {
            if box.width < 0.22 || box.height < 0.22 {
                failures.append(.lowClarity)
            }
            if box.midX < 0.3 || box.midX > 0.7 {
                failures.append(.notFrontal)
            }
            if box.minX < 0.03 || box.maxX > 0.97 || box.minY < 0.03 || box.maxY > 0.97 {
                failures.append(.heavyOcclusion)
            }
        } else {
            failures.append(.keyRegionMissing)
        }

        let lighting: LightingCondition
        switch metrics.averageBrightness {
        case ..<0.22:
            lighting = .dim
        case 0.22..<0.38:
            lighting = .balanced
        default:
            lighting = .bright
        }

        let occlusion: OcclusionLevel = failures.contains(.heavyOcclusion) ? .high : .low
        let frontalScore = box.map { 1.0 - min(abs($0.midX - 0.5) * 1.8, 0.9) } ?? 0.0
        let clarityScore = box.map { min(($0.width + $0.height) / 1.2, 1.0) } ?? 0.0

        let clearVisibility: [String: RegionVisibility] = [
            "forehead": failures.contains(.heavyOcclusion) ? .partial : .clear,
            "eyebrows": failures.contains(.lowClarity) ? .partial : .clear,
            "eyes": failures.contains(.lowClarity) ? .partial : .clear,
            "nose": failures.contains(.heavyOcclusion) ? .partial : .clear,
            "mouth": failures.contains(.heavyOcclusion) ? .partial : .clear,
            "chin": failures.contains(.keyRegionMissing) ? .partial : .clear
        ]

        return FaceQualityAssessment(
            passed: failures.isEmpty,
            singleFace: metrics.faceCount == 1,
            frontalScore: round(frontalScore * 100) / 100,
            clarityScore: round(clarityScore * 100) / 100,
            lighting: lighting,
            occlusion: occlusion,
            regionVisibility: clearVisibility,
            failureReasons: Array(Set(failures))
        )
    }

    private func makeObservedFeatures(metrics: FaceObservationMetrics, imageData: Data) -> [ObservedFeature] {
        let seed = imageData.reduce(0) { ($0 + Int($1)) % 10_000 }
        let box = metrics.primaryBoundingBox ?? CGRect(x: 0.36, y: 0.24, width: 0.3, height: 0.42)
        let foreheadWidth = box.width > 0.3 ? "额部偏开" : "额部偏收"
        let browSpacing = box.midX < 0.5 ? "眉眼重心偏收" : "眉眼重心偏中"
        let midface = box.height > 0.35 ? "中停存在现实承压感" : "中停更像审慎观察"
        let complexion = metrics.averageBrightness > 0.5 ? "气色偏明" : "气色偏收"

        return [
            ObservedFeature(
                id: "obs_forehead_width",
                area: "forehead",
                subArea: "upper",
                signalType: "width",
                value: foreheadWidth,
                confidence: 0.77,
                evidence: "上庭占比\(String(format: "%.2f", box.height))，额部留白感与边界感更明显。"
            ),
            ObservedFeature(
                id: "obs_brow_spacing",
                area: "eyebrows",
                subArea: "brow_eye_axis",
                signalType: "spacing",
                value: browSpacing,
                confidence: 0.73,
                evidence: "眉眼重心更偏向先收住，再判断外部反馈。"
            ),
            ObservedFeature(
                id: "obs_midface_pressure",
                area: "midface",
                subArea: "shan_gen_nose_axis",
                signalType: "shape",
                value: midface,
                confidence: 0.75,
                evidence: "山根到鼻部的注意力更容易被读取成秩序、现实和承受方式。"
            ),
            ObservedFeature(
                id: "obs_complexion_tone",
                area: "complexion",
                subArea: nil,
                signalType: "color",
                value: complexion,
                confidence: 0.7,
                evidence: "平均亮度\(String(format: "%.2f", metrics.averageBrightness))，整体气色更偏\(metrics.averageBrightness > 0.5 ? "外显" : "收敛")。"
            ),
            ObservedFeature(
                id: "obs_lower_guard",
                area: "chin",
                subArea: "lower",
                signalType: "fullness",
                value: seed % 2 == 0 ? "下停承接感偏稳" : "下停承接感偏收",
                confidence: 0.68,
                evidence: "下庭给人的感受更接近\(seed % 2 == 0 ? "能承受" : "先防守")。"
            )
        ]
    }

    private func makeOfficialAssessments(from observed: [ObservedFeature]) -> [OfficialAssessment] {
        [
            OfficialAssessment(
                id: "jiancha_guan",
                name: "eye",
                observedFeatureIds: ["obs_brow_spacing"],
                strengths: ["观察局势前先收住自己"],
                risks: ["关系里更容易先预判结果"],
                xiangxueMeaning: "监察官偏敏感，先洞察环境，再决定是否真正投入。",
                weight: 0.83
            ),
            OfficialAssessment(
                id: "shenbian_guan",
                name: "nose",
                observedFeatureIds: ["obs_midface_pressure"],
                strengths: ["对秩序、现实和边界更敏感"],
                risks: ["容易把推进后的代价算得过重"],
                xiangxueMeaning: "审辨官更强时，会把现实承压、节奏和可控性放到很前面。",
                weight: 0.87
            ),
            OfficialAssessment(
                id: "baoshou_guan",
                name: "brow",
                observedFeatureIds: ["obs_brow_spacing"],
                strengths: ["持续力和观察力都不弱"],
                risks: ["启动动作前会有明显审慎"],
                xiangxueMeaning: "保寿官偏收，常见于先判断再投入的人。",
                weight: 0.72
            )
        ]
    }

    private func makeZoneAssessments(from observed: [ObservedFeature]) -> [ZoneAssessment] {
        [
            ZoneAssessment(
                id: "upper",
                observedFeatureIds: ["obs_forehead_width", "obs_brow_spacing"],
                balance: "dominant",
                xiangxueMeaning: "上停偏强时，人更容易活在判断、预设和脑内拉扯里。",
                userFacingMeaning: "你更容易先在脑内推演，再决定自己要不要真的往前。",
                weight: 0.84
            ),
            ZoneAssessment(
                id: "middle",
                observedFeatureIds: ["obs_midface_pressure"],
                balance: "balanced",
                xiangxueMeaning: "中停稳定，现实感和责任感都在。",
                userFacingMeaning: "你不是没有执行力，而是很在意推进之后会不会失衡。",
                weight: 0.8
            ),
            ZoneAssessment(
                id: "lower",
                observedFeatureIds: ["obs_lower_guard"],
                balance: "balanced",
                xiangxueMeaning: "下停没有完全外放，说明情欲与归属感会先被收住。",
                userFacingMeaning: "你会想靠近，但不会轻易把自己的需求先摊开。",
                weight: 0.78
            )
        ]
    }

    private func makePalaceAssessments(from observed: [ObservedFeature]) -> [PalaceAssessment] {
        [
            PalaceAssessment(
                id: "ming",
                name: "命宫",
                region: "印堂与整体中轴",
                observedFeatureIds: ["obs_brow_spacing", "obs_midface_pressure"],
                status: "tense",
                xiangxueMeaning: "命宫受压时，更容易把控制感和安全感放到前面。",
                userFacingMeaning: "你的整体状态更像一直在衡量：先靠近会不会让我失去位置。",
                weight: 0.88
            ),
            PalaceAssessment(
                id: "fuqi",
                name: "夫妻宫",
                region: "关系与回应主题",
                observedFeatureIds: ["obs_brow_spacing", "obs_lower_guard"],
                status: "supported",
                xiangxueMeaning: "关系主题被激活，但不是外放型，而是先防守型。",
                userFacingMeaning: "关系不是不重要，而是越重要，你越会先保护自己。",
                weight: 0.84
            ),
            PalaceAssessment(
                id: "guanlu",
                name: "官禄宫",
                region: "现实压力与角色位置",
                observedFeatureIds: ["obs_midface_pressure"],
                status: "supported",
                xiangxueMeaning: "现实位置感较强，会反复评估推进成本。",
                userFacingMeaning: "你对现实后果很敏感，所以决定前会比别人多算几层。",
                weight: 0.8
            ),
            PalaceAssessment(
                id: "fude",
                name: "福德宫",
                region: "内在安稳与情绪恢复",
                observedFeatureIds: ["obs_complexion_tone", "obs_lower_guard"],
                status: "tense",
                xiangxueMeaning: "福德宫偏紧时，情绪消化更多在内部完成。",
                userFacingMeaning: "你习惯先自己消化，再决定要不要让别人看到压力。",
                weight: 0.79
            )
        ]
    }

    private func makeTopicHits(
        from observed: [ObservedFeature],
        officials: [OfficialAssessment],
        zones: [ZoneAssessment],
        palaces: [PalaceAssessment]
    ) -> [KnowledgeTopicHit] {
        let refs = makeEvidenceRefs()
        return [
            KnowledgeTopicHit(
                id: "topic_three_zones",
                topicType: "three_zones",
                title: "三停能量分布",
                matchedFeatureIds: zones.flatMap(\.observedFeatureIds),
                summary: "上停偏强、中停稳定、下停收住，常见于先判断、再决定是否真正投入的人。",
                sourceRefs: [refs[0], refs[1]],
                confidence: 0.86
            ),
            KnowledgeTopicHit(
                id: "topic_five_officials",
                topicType: "five_officials",
                title: "五官功能倾向",
                matchedFeatureIds: officials.flatMap(\.observedFeatureIds),
                summary: "监察官与审辨官同时被激活，说明关系感知与现实权衡都在前面。",
                sourceRefs: [refs[2], refs[3]],
                confidence: 0.83
            ),
            KnowledgeTopicHit(
                id: "topic_twelve_palaces",
                topicType: "twelve_palaces",
                title: "命宫与夫妻宫主题",
                matchedFeatureIds: palaces.flatMap(\.observedFeatureIds),
                summary: "命宫决定整体安全感张力，夫妻宫决定关系主题是否被激活。",
                sourceRefs: [refs[4], refs[5]],
                confidence: 0.82
            )
        ]
    }

    private func makeRuleHits(
        observedFeatures: [ObservedFeature],
        officials: [OfficialAssessment],
        zones: [ZoneAssessment],
        palaces: [PalaceAssessment],
        topicHits: [KnowledgeTopicHit]
    ) -> [RuleHit] {
        [
            RuleHit(
                id: "rule_overall_reserved",
                category: "overall_pattern",
                observedFeatureIds: ["obs_forehead_width", "obs_brow_spacing"],
                supportingTopicIds: ["topic_three_zones"],
                xiangxueMeaning: "整体格局偏收时，往往先有判断和观察，再有表达与动作。",
                userFacingMeaning: "你给人的不是弱，而是收着。先观察，再决定要不要把自己交出去。",
                weight: 0.87
            ),
            RuleHit(
                id: "rule_relationship_guard",
                category: "relationship",
                observedFeatureIds: ["obs_brow_spacing", "obs_lower_guard"],
                supportingTopicIds: ["topic_five_officials", "topic_twelve_palaces"],
                xiangxueMeaning: "关系主题被激活，但表达和归属需求不是外放型，而是防守型。",
                userFacingMeaning: "你不是不想靠近，而是越重要，越会先把需求感压低。",
                weight: 0.9
            ),
            RuleHit(
                id: "rule_control_security",
                category: "defense",
                observedFeatureIds: ["obs_midface_pressure", "obs_forehead_width"],
                supportingTopicIds: ["topic_three_zones", "topic_five_officials"],
                xiangxueMeaning: "现实承压与判断感同时偏高时，会把可控性放到很前面。",
                userFacingMeaning: "你会先算推进后的代价，所以总像在用控制感换安全感。",
                weight: 0.91
            ),
            RuleHit(
                id: "rule_attraction_hidden",
                category: "attraction",
                observedFeatureIds: ["obs_complexion_tone", "obs_lower_guard"],
                supportingTopicIds: ["topic_twelve_palaces"],
                xiangxueMeaning: "吸引力不是没有，而是更偏向在熟悉和确定感里慢慢释放。",
                userFacingMeaning: "你不是没吸引力，而是不愿在没有把握的时候把自己放得太前面。",
                weight: 0.78
            ),
            RuleHit(
                id: "rule_reality_pressure",
                category: "career",
                observedFeatureIds: ["obs_midface_pressure"],
                supportingTopicIds: ["topic_five_officials", "topic_twelve_palaces"],
                xiangxueMeaning: "现实位置和承担方式会持续影响你的决定节奏。",
                userFacingMeaning: "你做决定时总要把现实和后果一起扛进来，所以很难只凭当下冲动推进。",
                weight: 0.8
            )
        ]
    }

    private func makeInterpretationArcs(ruleHits: [RuleHit]) -> [InterpretationArc] {
        [
            InterpretationArc(
                id: "arc_impression",
                title: "外在克制，不等于内里没波动",
                summary: "你的第一感不是弱，而是收着。你更习惯先判断局势，再决定自己暴露多少。",
                supportingRuleIds: ["rule_overall_reserved"],
                dominantTheme: "impression",
                confidence: 0.86
            ),
            InterpretationArc(
                id: "arc_self_protection",
                title: "你会先保护位置，再决定要不要靠近",
                summary: "重要关系或重要决定面前，你不是没欲望，而是会先把防御放到前面。",
                supportingRuleIds: ["rule_relationship_guard", "rule_control_security"],
                dominantTheme: "self_protection",
                confidence: 0.9
            ),
            InterpretationArc(
                id: "arc_control_security",
                title: "你在用控制感换安全感",
                summary: "你更在意推进之后会不会失衡，所以会提前算成本、算后果，也算自己是否还有退路。",
                supportingRuleIds: ["rule_control_security", "rule_reality_pressure"],
                dominantTheme: "control_and_security",
                confidence: 0.92
            )
        ]
    }

    private func makeTensionHypotheses(arcs: [InterpretationArc], ruleHits: [RuleHit]) -> [TensionHypothesis] {
        [
            TensionHypothesis(
                id: "tension_control_pressure",
                tensionType: "control_pressure",
                confidence: 0.9,
                supportingArcIds: ["arc_control_security", "arc_self_protection"],
                supportingRuleIds: ["rule_control_security", "rule_reality_pressure"],
                explanation: "你现在最强的 tension 不是愿不愿意往前，而是往前以后还能不能保住自己的位置和主动。"
            ),
            TensionHypothesis(
                id: "tension_relationship_ambiguity",
                tensionType: "relationship_ambiguity",
                confidence: 0.83,
                supportingArcIds: ["arc_self_protection"],
                supportingRuleIds: ["rule_relationship_guard", "rule_attraction_hidden"],
                explanation: "你会想靠近，但又不愿意在关系还不明朗时把自己放到太危险的位置。"
            )
        ]
    }

    private func makeReadMeOutput(
        ruleHits: [RuleHit],
        arcs: [InterpretationArc],
        tensions: [TensionHypothesis],
        observedFeatures: [ObservedFeature],
        officials: [OfficialAssessment],
        zones: [ZoneAssessment],
        palaces: [PalaceAssessment],
        topics: [KnowledgeTopicHit]
    ) -> ReadMeOutput {
        let refs = topics.flatMap(\.sourceRefs)
        let primaryTension = tensions.first?.explanation ?? "你现在更容易卡在决定和安全感之间。"

        return ReadMeOutput(
            hookLine: "你不是单纯怕做错决定，你更怕选完之后，后面没有人接住你。",
            overallPattern: ruleHits.first(where: { $0.id == "rule_overall_reserved" })?.userFacingMeaning ?? "你给人的第一感受是克制和判断感。",
            relationshipSignal: ruleHits.first(where: { $0.id == "rule_relationship_guard" })?.userFacingMeaning ?? "关系越重要，你越会先保护自己。",
            careerOrRealitySignal: ruleHits.first(where: { $0.id == "rule_reality_pressure" })?.userFacingMeaning ?? "现实压力会持续影响你的决定节奏。",
            defensePattern: ruleHits.first(where: { $0.id == "rule_control_security" })?.userFacingMeaning ?? "你会先用控制感换安全感。",
            attractionPattern: ruleHits.first(where: { $0.id == "rule_attraction_hidden" })?.userFacingMeaning ?? "吸引力不是没有，而是更慢地释放。",
            primaryTension: primaryTension,
            whyThisFeelsTrue: "因为这不是某一个部位直接下结论，而是整体格局、三停能量、命宫/夫妻宫主题和现实承压感一起把这条 tension 推了出来。",
            nextQuestion: "如果这句有点像，你最近更卡在关系、工作，还是自己心里的拉扯？",
            trace: ExplanationTrace(
                primaryObservedFeatures: observedFeatures.prefix(4).map(\.id),
                primaryOfficialAssessments: officials.prefix(3).map(\.id),
                primaryZoneAssessments: zones.map(\.id),
                primaryPalaceAssessments: palaces.prefix(4).map(\.id),
                primaryRuleHits: ruleHits.prefix(4).map(\.id),
                primaryInterpretationArcs: arcs.map(\.id),
                primaryTensionHypotheses: tensions.map(\.id),
                evidenceRefs: Array(refs.prefix(4)),
                whySummary: "眉眼、山根鼻部、三停与命宫/夫妻宫共同支持了“先收住、再判断、再靠近”的结构。"
            )
        )
    }

    private func makeFallbackReadMe() -> ReadMeOutput {
        ReadMeOutput(
            hookLine: "这张照片暂时还不够稳，先别急着相信一段泛化解释。",
            overallPattern: "我们需要一张更清晰、更正面的照片，才能进入正式的整体格局判断。",
            relationshipSignal: "关系信号暂时不输出。",
            careerOrRealitySignal: "现实与事业信号暂时不输出。",
            defensePattern: "防御方式暂时不输出。",
            attractionPattern: "吸引力模式暂时不输出。",
            primaryTension: "当前先补照片质量，而不是给你一段敷衍的结论。",
            whyThisFeelsTrue: "相学分析需要先通过质量门，再进入结构化观察。",
            nextQuestion: "要不要换一张更清晰的正脸照重新看？",
            trace: ExplanationTrace(
                primaryObservedFeatures: [],
                primaryOfficialAssessments: [],
                primaryZoneAssessments: [],
                primaryPalaceAssessments: [],
                primaryRuleHits: [],
                primaryInterpretationArcs: [],
                primaryTensionHypotheses: [],
                evidenceRefs: [],
                whySummary: "图片质量不足，未进入正式分析。"
            )
        )
    }

    private func makeMemoryItems(
        userId: String,
        onboardingResponses: [String: String],
        readMe: ReadMeOutput,
        thread: GuidanceThread
    ) -> [MemoryItem] {
        let now = timestamp()
        var items: [MemoryItem] = []

        let mappings: [(String, String, String, Bool)] = [
            ("fear", "tension", onboardingResponses["fear"] ?? "", true),
            ("desire", "fact", onboardingResponses["desire"] ?? "", false),
            ("person", "relationship", onboardingResponses["person"] ?? "", true),
            ("focus", "thread", onboardingResponses["focus"] ?? "", false)
        ]

        for (key, category, value, sensitive) in mappings where !value.isEmpty {
            items.append(
                MemoryItem(
                    id: UUID().uuidString,
                    userId: userId,
                    category: category,
                    key: key,
                    value: value,
                    source: "user_input",
                    confidence: 1.0,
                    status: "active",
                    isSensitive: sensitive,
                    lastConfirmedAt: now,
                    createdAt: now,
                    updatedAt: now
                )
            )
        }

        items.append(
            MemoryItem(
                id: UUID().uuidString,
                userId: userId,
                category: "tension",
                key: "primary_tension",
                value: readMe.primaryTension,
                source: "ai_inference",
                confidence: 0.82,
                status: "needs_confirmation",
                isSensitive: true,
                lastConfirmedAt: nil,
                createdAt: now,
                updatedAt: now
            )
        )

        items.append(
            MemoryItem(
                id: UUID().uuidString,
                userId: userId,
                category: "thread",
                key: "current_thread_title",
                value: thread.title,
                source: "system_summary",
                confidence: 0.95,
                status: "active",
                isSensitive: false,
                lastConfirmedAt: now,
                createdAt: now,
                updatedAt: now
            )
        )

        return items
    }

    private func makeEvidenceRefs() -> [EvidenceCitation] {
        [
            EvidenceCitation(
                id: "ref_1",
                sourceFile: "xiangxue_rag_min.json",
                pageTitle: "三停总纲",
                chunkId: "three_zones_01",
                excerpt: "上停偏强，多思多虑，先在脑内设防与判断。"
            ),
            EvidenceCitation(
                id: "ref_2",
                sourceFile: "xiangxue_knowledge_complete_149p.json",
                pageTitle: "额相与思维基调",
                chunkId: "forehead_03",
                excerpt: "额部偏收之人，遇事多先思先量，不轻易先发。"
            ),
            EvidenceCitation(
                id: "ref_3",
                sourceFile: "xiangxue_knowledge_ai_kg.json",
                pageTitle: "五官系统",
                chunkId: "five_officials_eye",
                excerpt: "眼为监察官，主观察、情绪感知与人际敏锐度。"
            ),
            EvidenceCitation(
                id: "ref_4",
                sourceFile: "xiangxue_knowledge_ai_kg.json",
                pageTitle: "五官系统",
                chunkId: "five_officials_nose",
                excerpt: "鼻为审辨官，主主见、现实感、财帛与承压。"
            ),
            EvidenceCitation(
                id: "ref_5",
                sourceFile: "xiangxue_rag_min.json",
                pageTitle: "十二宫",
                chunkId: "palace_ming_fuqi",
                excerpt: "命宫看整体心态张力，夫妻宫看关系主题是否被激活。"
            ),
            EvidenceCitation(
                id: "ref_6",
                sourceFile: "xiangxue_knowledge_complete_149p.json",
                pageTitle: "部位细相",
                chunkId: "shan_gen_01",
                excerpt: "山根鼻部偏紧，常见于把现实后果与安全感放在前面的人。"
            )
        ]
    }

    private func makeThreadTitle(from focus: String, tension: String) -> String {
        switch focus {
        case "relationship":
            return "关系中的主动与防御"
        case "career_direction":
            return "现实选择里的推进与犹豫"
        case "emotional_balance":
            return "情绪与安全感的失衡点"
        default:
            return tension
        }
    }

    private func normalizeFocus(_ text: String) -> String {
        if text.contains("关系") {
            return "relationship"
        }
        if text.contains("工作") || text.contains("事业") {
            return "career_direction"
        }
        if text.contains("决定") || text.contains("方向") {
            return "decision_conflict"
        }
        return "emotional_balance"
    }

    private func averageBrightness(for cgImage: CGImage) -> Double {
        let inputImage = CIImage(cgImage: cgImage)
        let extent = inputImage.extent
        guard !extent.isEmpty else { return 0.5 }

        let filter = CIFilter.areaAverage()
        filter.inputImage = inputImage
        filter.extent = extent

        guard let outputImage = filter.outputImage else { return 0.5 }

        var bitmap = [UInt8](repeating: 0, count: 4)
        ciContext.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: CGColorSpaceCreateDeviceRGB()
        )

        let red = Double(bitmap[0]) / 255.0
        let green = Double(bitmap[1]) / 255.0
        let blue = Double(bitmap[2]) / 255.0
        return (0.299 * red) + (0.587 * green) + (0.114 * blue)
    }

    private func timestamp() -> String {
        ISO8601DateFormatter().string(from: Date())
    }

    private func dayString() -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter.string(from: Date())
    }

    private func weekKey() -> String {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale(identifier: "zh_CN")
        formatter.timeZone = TimeZone.current
        formatter.dateFormat = "YYYY-'W'ww"
        return formatter.string(from: Date())
    }
}
