import Foundation

public final class FaceAnalysisEngine {
    public init() {}

    public func analyze(_ profile: FaceProfile) -> AnalysisReport {
        var scores = baselineScores()
        var signals: [String] = []

        applyQuality(profile.quality, to: &scores, signals: &signals)
        applyFeatures(profile.features, to: &scores, signals: &signals)
        applyPalaceSignals(profile.palaceSignals, to: &scores, signals: &signals)
        scores = clampScores(scores)

        let ordered = scores.sorted { $0.value > $1.value }
        let top = ordered.prefix(2).map { "\($0.key.title)\($0.value)分" }.joined(separator: "、")
        let low = ordered.last.map { "\($0.key.title)\($0.value)分" } ?? "无"

        let summary = "整体趋势偏\(overallTone(from: scores))，优势集中在\(top)，当前需要重点关注\(low)。"
        let caution = cautionLine(from: profile.quality, scores: scores)

        return AnalysisReport(
            overallSummary: summary,
            keySignals: Array(signals.prefix(6)),
            caution: caution,
            domainScores: scores
        )
    }

    private func baselineScores() -> [LifeDomain: Int] {
        var scores: [LifeDomain: Int] = [:]
        LifeDomain.allCases.forEach { scores[$0] = 50 }
        return scores
    }

    private func clampScores(_ input: [LifeDomain: Int]) -> [LifeDomain: Int] {
        var output: [LifeDomain: Int] = [:]
        for (domain, value) in input {
            output[domain] = max(20, min(90, value))
        }
        return output
    }

    private func adjust(_ domain: LifeDomain, _ delta: Int, in scores: inout [LifeDomain: Int]) {
        scores[domain, default: 50] += delta
    }

    private func applyQuality(
        _ quality: FaceQuality,
        to scores: inout [LifeDomain: Int],
        signals: inout [String]
    ) {
        if quality.singleFace && quality.frontalScore >= 0.75 && quality.clarityScore >= 0.75 {
            signals.append("图像质量较好，面部结构信号可信度较高。")
            adjust(.vitality, 2, in: &scores)
        } else {
            signals.append("图像质量一般，建议正脸且光线均匀时再次拍摄。")
            adjust(.vitality, -2, in: &scores)
        }

        switch quality.lighting {
        case .bright, .balanced:
            adjust(.social, 2, in: &scores)
        case .dim, .backlit:
            adjust(.social, -2, in: &scores)
            signals.append("光线偏弱或逆光，部分气色特征可能被低估。")
        }

        switch quality.occlusion {
        case .none, .low:
            break
        case .medium:
            adjust(.career, -2, in: &scores)
            adjust(.relationship, -2, in: &scores)
            signals.append("有中度遮挡，影响五官细节判断。")
        case .high:
            adjust(.career, -4, in: &scores)
            adjust(.relationship, -4, in: &scores)
            adjust(.wealth, -3, in: &scores)
            signals.append("遮挡较高，建议重拍后再做关键决策参考。")
        }
    }

    private func applyFeatures(
        _ features: FaceFeatures,
        to scores: inout [LifeDomain: Int],
        signals: inout [String]
    ) {
        switch features.forehead {
        case .broad, .high:
            adjust(.career, 6, in: &scores)
            adjust(.social, 3, in: &scores)
            signals.append("额部偏开阔，上停信息偏积极，利于思考与规划。")
        case .balanced:
            adjust(.career, 2, in: &scores)
        case .narrow, .low:
            adjust(.career, -4, in: &scores)
            signals.append("额部空间偏紧，近期更适合稳扎稳打。")
        }

        switch features.eyebrows {
        case .longRising, .crescent:
            adjust(.relationship, 4, in: &scores)
            adjust(.social, 4, in: &scores)
            signals.append("眉形顺势且延展，人际协作与表达优势更明显。")
        case .straight, .thickDense:
            adjust(.career, 3, in: &scores)
            adjust(.social, 2, in: &scores)
        case .sparse:
            adjust(.social, -4, in: &scores)
            signals.append("眉势偏散，建议在沟通中增加明确性。")
        case .shortBroken:
            adjust(.relationship, -5, in: &scores)
            adjust(.social, -3, in: &scores)
            signals.append("眉段有断续信号，关系推进宜慢不宜急。")
        }

        switch features.eyes {
        case .clearBright:
            adjust(.social, 6, in: &scores)
            adjust(.relationship, 5, in: &scores)
            signals.append("眼神清亮，互动与信任建立能力较强。")
        case .peachBlossom:
            adjust(.relationship, 6, in: &scores)
            adjust(.social, 3, in: &scores)
            signals.append("桃花特征较明显，吸引力与关系机会偏多。")
        case .triangle:
            adjust(.career, 2, in: &scores)
            adjust(.relationship, -4, in: &scores)
            signals.append("眼型偏锋利，决策果断但关系中需避免强压。")
        case .threeWhite:
            adjust(.career, -3, in: &scores)
            adjust(.relationship, -6, in: &scores)
            adjust(.social, -5, in: &scores)
            signals.append("三白特征明显，建议先稳情绪再做外部判断。")
        case .fishLike:
            adjust(.vitality, -5, in: &scores)
            adjust(.social, -3, in: &scores)
            signals.append("眼部神采偏弱，阶段性精力管理更关键。")
        case .deepSet:
            adjust(.career, 2, in: &scores)
            adjust(.social, -1, in: &scores)
        }

        switch features.nose {
        case .fullRound:
            adjust(.wealth, 7, in: &scores)
            adjust(.career, 3, in: &scores)
            signals.append("鼻部偏丰，财帛与执行力倾向较稳。")
        case .straightBridge:
            adjust(.career, 4, in: &scores)
            adjust(.wealth, 3, in: &scores)
        case .broadWing:
            adjust(.wealth, 5, in: &scores)
        case .thinPointed:
            adjust(.wealth, -5, in: &scores)
            signals.append("鼻势偏尖细，财务上宜重预算与留存。")
        case .hooked:
            adjust(.career, 2, in: &scores)
            adjust(.relationship, -3, in: &scores)
        case .flatWeak:
            adjust(.wealth, -6, in: &scores)
            adjust(.career, -2, in: &scores)
            signals.append("鼻势偏弱，资源掌控与节奏管理需加强。")
        }

        switch features.mouth {
        case .balanced, .upturned:
            adjust(.relationship, 4, in: &scores)
            adjust(.social, 3, in: &scores)
        case .thick:
            adjust(.relationship, 2, in: &scores)
            adjust(.vitality, 2, in: &scores)
        case .thin, .blurryEdges:
            adjust(.relationship, -4, in: &scores)
            signals.append("口部边界偏弱，建议表达需求时更直接。")
        case .downturned:
            adjust(.vitality, -4, in: &scores)
            adjust(.social, -3, in: &scores)
        }

        switch features.ears {
        case .highSet, .thickLobe:
            adjust(.career, 3, in: &scores)
            adjust(.vitality, 4, in: &scores)
        case .closeFit:
            adjust(.social, 2, in: &scores)
        case .protruding:
            adjust(.social, 1, in: &scores)
            adjust(.career, 1, in: &scores)
        case .lowSet, .smallThin:
            adjust(.vitality, -3, in: &scores)
        }

        switch features.chin {
        case .roundFull, .squareFirm:
            adjust(.relationship, 3, in: &scores)
            adjust(.vitality, 3, in: &scores)
        case .long:
            adjust(.career, 2, in: &scores)
            adjust(.vitality, 1, in: &scores)
        case .pointed:
            adjust(.relationship, -3, in: &scores)
        case .receding:
            adjust(.vitality, -4, in: &scores)
            adjust(.relationship, -2, in: &scores)
            signals.append("下停承载力偏弱，长期节奏建议降速。")
        }

        switch features.complexion {
        case .bright:
            adjust(.vitality, 6, in: &scores)
            adjust(.social, 2, in: &scores)
            signals.append("气色偏明，阶段状态有上行趋势。")
        case .yellowish:
            adjust(.vitality, -2, in: &scores)
        case .pale:
            adjust(.vitality, -4, in: &scores)
        case .dark:
            adjust(.vitality, -5, in: &scores)
            adjust(.career, -2, in: &scores)
        case .mixed:
            adjust(.vitality, -1, in: &scores)
        }
    }

    private func applyPalaceSignals(
        _ palaceSignals: [PalaceSignal],
        to scores: inout [LifeDomain: Int],
        signals: inout [String]
    ) {
        for item in palaceSignals {
            let targetDomain: LifeDomain
            switch item.palace {
            case .career:
                targetDomain = .career
            case .wealth:
                targetDomain = .wealth
            case .relationship:
                targetDomain = .relationship
            case .health, .life:
                targetDomain = .vitality
            case .travel, .support:
                targetDomain = .social
            }

            switch item.status {
            case .strong:
                adjust(targetDomain, 6, in: &scores)
            case .stable:
                adjust(targetDomain, 2, in: &scores)
            case .weak:
                adjust(targetDomain, -4, in: &scores)
            case .blocked:
                adjust(targetDomain, -7, in: &scores)
            }
        }

        let strongCount = palaceSignals.filter { $0.status == .strong }.count
        if strongCount >= 2 {
            signals.append("十二宫中的重点宫位出现多处强势信号。")
        }
    }

    private func overallTone(from scores: [LifeDomain: Int]) -> String {
        let avg = Double(scores.values.reduce(0, +)) / Double(max(scores.count, 1))
        switch avg {
        case 67...:
            return "上行"
        case 52..<67:
            return "稳中有升"
        case 42..<52:
            return "中性平稳"
        default:
            return "保守"
        }
    }

    private func cautionLine(from quality: FaceQuality, scores: [LifeDomain: Int]) -> String {
        let lowScore = scores.values.min() ?? 50
        if !quality.singleFace || quality.occlusion == .high || quality.clarityScore < 0.55 {
            return "当前图片质量不足，结论仅作娱乐参考，建议在自然光正脸重测。"
        }
        if lowScore < 40 {
            return "存在偏弱维度，建议先做节奏与沟通调整，再观察后续变化。"
        }
        return "本结果用于方向性参考，不构成医疗、法律、投资等专业建议。"
    }
}
