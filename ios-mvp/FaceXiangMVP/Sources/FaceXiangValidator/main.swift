import Foundation
import FaceXiangCore

enum ValidatorError: Error {
    case fixtureMissing
    case invalidCount(Int)
    case invalidScore(faceID: String, domain: LifeDomain, score: Int)
    case emptySummary(faceID: String)
    case emptyAnswer(faceID: String)
}

@main
struct FaceXiangValidator {
    static func main() async {
        do {
            let profiles = try loadProfiles()
            guard profiles.count == 50 else {
                throw ValidatorError.invalidCount(profiles.count)
            }

            let engine = FaceAnalysisEngine()
            let advisor = QuestionAdvisor()

            var totalScores: [LifeDomain: Int] = {
                var result: [LifeDomain: Int] = [:]
                LifeDomain.allCases.forEach { result[$0] = 0 }
                return result
            }()

            for profile in profiles {
                let report = engine.analyze(profile)
                guard !report.overallSummary.isEmpty else {
                    throw ValidatorError.emptySummary(faceID: profile.faceID)
                }

                for domain in LifeDomain.allCases {
                    let score = report.score(for: domain)
                    if score < 20 || score > 90 {
                        throw ValidatorError.invalidScore(faceID: profile.faceID, domain: domain, score: score)
                    }
                    totalScores[domain, default: 0] += score
                }

                let answer = advisor.answer(question: "我近期适合换工作吗？", report: report)
                guard !answer.isEmpty else {
                    throw ValidatorError.emptyAnswer(faceID: profile.faceID)
                }
            }

            let avgLines = LifeDomain.allCases.map { domain in
                let average = Double(totalScores[domain, default: 0]) / Double(profiles.count)
                return "\(domain.title): \(String(format: "%.1f", average))"
            }.joined(separator: " | ")

            print("VALIDATION_OK total_profiles=\(profiles.count)")
            print("AVERAGE_SCORES \(avgLines)")
            print("FLOW_CHECK 拍照/选图 -> 识别结构化 -> 基础分析 -> 输入问题 -> 输出解答")
        } catch {
            fputs("VALIDATION_FAILED \(error)\n", stderr)
            exit(1)
        }
    }

    private static func loadProfiles() throws -> [FaceProfile] {
        guard let url = Bundle.module.url(forResource: "face_profiles_50", withExtension: "json") else {
            throw ValidatorError.fixtureMissing
        }
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([FaceProfile].self, from: data)
    }
}
