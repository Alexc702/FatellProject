import Foundation

public protocol FaceRecognizer {
    func recognize(imageData: Data) async throws -> FaceProfile
}

public enum WorkflowError: LocalizedError {
    case invalidImage
    case missingQuestion

    public var errorDescription: String? {
        switch self {
        case .invalidImage:
            return "无效图片，无法识别。"
        case .missingQuestion:
            return "请输入一个问题后再获取解答。"
        }
    }
}

public final class WorkflowService {
    private let recognizer: FaceRecognizer
    private let analysisEngine: FaceAnalysisEngine
    private let advisor: QuestionAdvisor

    public init(
        recognizer: FaceRecognizer,
        analysisEngine: FaceAnalysisEngine = FaceAnalysisEngine(),
        advisor: QuestionAdvisor = QuestionAdvisor()
    ) {
        self.recognizer = recognizer
        self.analysisEngine = analysisEngine
        self.advisor = advisor
    }

    public func run(imageData: Data, question: String) async throws -> WorkflowResult {
        guard !imageData.isEmpty else {
            throw WorkflowError.invalidImage
        }
        guard !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw WorkflowError.missingQuestion
        }

        let profile = try await recognizer.recognize(imageData: imageData)
        let report = analysisEngine.analyze(profile)
        let answer = advisor.answer(question: question, report: report)
        return WorkflowResult(profile: profile, report: report, answer: answer)
    }

    public func runWithoutQuestion(imageData: Data) async throws -> (FaceProfile, AnalysisReport) {
        guard !imageData.isEmpty else {
            throw WorkflowError.invalidImage
        }
        let profile = try await recognizer.recognize(imageData: imageData)
        return (profile, analysisEngine.analyze(profile))
    }

    public func answerQuestion(_ question: String, with report: AnalysisReport) throws -> String {
        guard !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            throw WorkflowError.missingQuestion
        }
        return advisor.answer(question: question, report: report)
    }
}
