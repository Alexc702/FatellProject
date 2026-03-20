import Foundation
import SwiftUI
import PhotosUI
import FaceXiangCore

#if os(iOS)
import UIKit
typealias PlatformImage = UIImage
#elseif os(macOS)
import AppKit
typealias PlatformImage = NSImage
#endif

@MainActor
final class ContentViewModel: ObservableObject {
    @Published var apiKey: String
    @Published var model: String
    @Published var question: String = ""
    @Published var answer: String = ""
    @Published var report: AnalysisReport?
    @Published var profile: FaceProfile?
    @Published var imageData: Data?
    @Published var selectedImage: PlatformImage?
    @Published var isRunning: Bool = false
    @Published var errorText: String = ""
    @Published var selectedPickerItem: PhotosPickerItem? = nil
    @Published var showCamera: Bool = false

    private let analysisEngine = FaceAnalysisEngine()
    private let advisor = QuestionAdvisor()

    init() {
        self.apiKey = UserDefaults.standard.string(forKey: "openrouter_api_key") ?? ""
        self.model = UserDefaults.standard.string(forKey: "openrouter_model") ?? "openai/gpt-4.1-mini"
    }

    func saveConfig() {
        UserDefaults.standard.set(apiKey, forKey: "openrouter_api_key")
        UserDefaults.standard.set(model, forKey: "openrouter_model")
    }

    func loadFromPicker() async {
        guard let item = selectedPickerItem else { return }
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let image = PlatformImage(data: data) {
                imageData = data
                selectedImage = image
                clearResults()
            }
        } catch {
            errorText = "读取图片失败: \(error.localizedDescription)"
        }
    }

    #if os(iOS)
    func setCapturedImage(_ image: UIImage) {
        selectedImage = image
        imageData = image.jpegData(compressionQuality: 0.9)
        clearResults()
    }
    #endif

    func analyzeFace() async {
        guard let imageData, !imageData.isEmpty else {
            errorText = "请先拍照或选择一张照片。"
            return
        }

        isRunning = true
        errorText = ""
        defer { isRunning = false }

        let recognizer: FaceRecognizer
        if apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            recognizer = MockFaceRecognizer()
        } else {
            recognizer = OpenRouterFaceRecognizer(
                apiKey: apiKey.trimmingCharacters(in: .whitespacesAndNewlines),
                model: model.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ? "openai/gpt-4.1-mini" : model
            )
        }

        do {
            let detected = try await recognizer.recognize(imageData: imageData)
            let analyzed = analysisEngine.analyze(detected)
            profile = detected
            report = analyzed
            answer = ""
            saveConfig()
        } catch {
            errorText = "识别失败: \(error.localizedDescription)"
        }
    }

    func answerQuestion() {
        guard let report else {
            errorText = "请先完成面相识别与基础分析。"
            return
        }
        guard !question.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            errorText = "请输入一个问题。"
            return
        }
        answer = advisor.answer(question: question, report: report)
    }

    private func clearResults() {
        report = nil
        profile = nil
        answer = ""
        errorText = ""
    }
}
