import Foundation

public final class QuestionAdvisor {
    public init() {}

    public func answer(question: String, report: AnalysisReport) -> String {
        let category = detectCategory(from: question)
        let domain = domain(for: category)
        let score = report.score(for: domain)
        let tone = toneText(score: score)
        let suggestion = suggestionText(category: category, score: score)

        return """
        问题归类：\(category.title)。
        当前信号：\(domain.title)\(score)分，趋势\(tone)。
        建议：\(suggestion)
        """
    }

    private func domain(for category: QuestionCategory) -> LifeDomain {
        switch category {
        case .career:
            return .career
        case .wealth:
            return .wealth
        case .relationship:
            return .relationship
        case .social:
            return .social
        case .health:
            return .vitality
        case .general:
            return .vitality
        }
    }

    private func detectCategory(from question: String) -> QuestionCategory {
        let q = question.lowercased()
        if containsAny(q, keywords: ["事业", "工作", "升职", "跳槽", "创业", "career", "job", "promotion"]) {
            return .career
        }
        if containsAny(q, keywords: ["财", "收入", "投资", "存钱", "花钱", "wealth", "money", "income"]) {
            return .wealth
        }
        if containsAny(q, keywords: ["感情", "恋爱", "婚姻", "对象", "复合", "relationship", "love", "dating"]) {
            return .relationship
        }
        if containsAny(q, keywords: ["人际", "沟通", "同事", "朋友", "team", "social", "network"]) {
            return .social
        }
        if containsAny(q, keywords: ["健康", "状态", "疲惫", "睡眠", "health", "energy", "burnout"]) {
            return .health
        }
        return .general
    }

    private func containsAny(_ text: String, keywords: [String]) -> Bool {
        keywords.contains { text.contains($0) }
    }

    private func toneText(score: Int) -> String {
        switch score {
        case 70...:
            return "偏积极"
        case 55..<70:
            return "稳健"
        case 45..<55:
            return "中性"
        default:
            return "需保守"
        }
    }

    private func suggestionText(category: QuestionCategory, score: Int) -> String {
        switch category {
        case .career:
            if score >= 70 { return "可以推进关键机会，但先做优先级排序与阶段里程碑。" }
            if score >= 55 { return "先稳住现有节奏，再用小步实验验证新方向。" }
            return "暂不建议重决策，先补齐资源与协同关系。"
        case .wealth:
            if score >= 70 { return "可适度进取，但以现金流安全垫为前提。" }
            if score >= 55 { return "保持稳健配置，避免冲动投入。" }
            return "优先做预算、降杠杆和风险隔离。"
        case .relationship:
            if score >= 70 { return "适合主动沟通与推进关系，但保持边界与节奏。" }
            if score >= 55 { return "先增强理解与反馈机制，不急于定论。" }
            return "先修复沟通质量，再谈关系方向。"
        case .social:
            if score >= 70 { return "可主动拓展合作圈，抓住关键连接人。" }
            if score >= 55 { return "保持稳定互动，优先深耕高质量关系。" }
            return "减少无效社交，先提升表达清晰度。"
        case .health:
            if score >= 70 { return "状态可支撑高强度任务，但仍需留恢复窗口。" }
            if score >= 55 { return "维持作息稳定，避免连续熬夜与过载。" }
            return "先把睡眠、运动和压力管理拉回基础线。"
        case .general:
            if score >= 70 { return "总体节奏可进可守，优先做高价值动作。" }
            if score >= 55 { return "保持稳步推进，先积累确定性。" }
            return "先收缩战线，聚焦一个最关键问题。"
        }
    }
}

public enum QuestionCategory: String {
    case career
    case wealth
    case relationship
    case social
    case health
    case general

    var title: String {
        switch self {
        case .career:
            return "事业"
        case .wealth:
            return "财务"
        case .relationship:
            return "感情"
        case .social:
            return "人际"
        case .health:
            return "状态"
        case .general:
            return "综合"
        }
    }
}
