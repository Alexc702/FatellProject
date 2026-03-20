import XCTest
@testable import FaceXiangCore

final class FaceAnalysisEngineTests: XCTestCase {
    func testAnalyzeFiftyStructuredProfiles() throws {
        let profiles = try loadProfiles()
        XCTAssertEqual(profiles.count, 50, "测试数据必须为 50 条")

        let engine = FaceAnalysisEngine()
        let advisor = QuestionAdvisor()

        for profile in profiles {
            let report = engine.analyze(profile)
            XCTAssertFalse(report.overallSummary.isEmpty)
            XCTAssertEqual(report.domainScores.count, LifeDomain.allCases.count)
            for domain in LifeDomain.allCases {
                let score = report.score(for: domain)
                XCTAssertGreaterThanOrEqual(score, 20)
                XCTAssertLessThanOrEqual(score, 90)
            }

            let answer = advisor.answer(question: "我最近适合换工作吗？", report: report)
            XCTAssertTrue(answer.contains("建议"))
        }
    }

    func testWorkflowWithMockRecognizer() async throws {
        let service = WorkflowService(recognizer: MockFaceRecognizer())
        let imageData = Data(repeating: 17, count: 512)
        let result = try await service.run(imageData: imageData, question: "我近期感情应该怎么推进？")

        XCTAssertFalse(result.profile.faceID.isEmpty)
        XCTAssertFalse(result.report.overallSummary.isEmpty)
        XCTAssertTrue(result.answer.contains("问题归类"))
    }

    private func loadProfiles() throws -> [FaceProfile] {
        let url = Bundle.module.url(forResource: "face_profiles_50", withExtension: "json")!
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode([FaceProfile].self, from: data)
    }
}
