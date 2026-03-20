import SwiftUI
import PhotosUI
import FaceXiangCore

#if os(iOS)
import UIKit
#endif

struct ContentView: View {
    @StateObject private var vm = ContentViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    configSection
                    imageSection
                    analysisSection
                    qaSection
                    disclaimerSection
                }
                .padding(16)
            }
            .navigationTitle("面相MVP")
        }
        .task(id: vm.selectedPickerItem) {
            await vm.loadFromPicker()
        }
        .sheet(isPresented: $vm.showCamera) {
            #if os(iOS)
            CameraPicker { image in
                vm.setCapturedImage(image)
            }
            #else
            Text("当前平台不支持摄像头。")
                .padding()
            #endif
        }
    }

    private var configSection: some View {
        GroupBox("OpenRouter 设置") {
            VStack(alignment: .leading, spacing: 10) {
                TextField("OpenRouter API Key (留空走 mock)", text: $vm.apiKey)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                TextField("VLM 模型（示例：openai/gpt-4.1-mini）", text: $vm.model)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                    .textFieldStyle(.roundedBorder)
                Text("说明：API key 为空时，会使用本地 mock 识别器走完整闭环。")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
        }
    }

    private var imageSection: some View {
        GroupBox("拍照或选择照片") {
            VStack(alignment: .leading, spacing: 10) {
                HStack(spacing: 12) {
                    PhotosPicker(selection: $vm.selectedPickerItem, matching: .images) {
                        Text("从相册选择")
                            .frame(maxWidth: .infinity)
                    }
                    .buttonStyle(.borderedProminent)

                    #if os(iOS)
                    Button("拍照") {
                        vm.showCamera = true
                    }
                    .frame(maxWidth: .infinity)
                    .buttonStyle(.bordered)
                    #endif
                }

                if let image = vm.selectedImage {
                    #if os(iOS)
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    #elseif os(macOS)
                    Image(nsImage: image)
                        .resizable()
                        .scaledToFit()
                        .frame(maxHeight: 220)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    #endif
                } else {
                    RoundedRectangle(cornerRadius: 10)
                        .fill(Color.gray.opacity(0.15))
                        .frame(height: 180)
                        .overlay(
                            Text("尚未选择图片")
                                .foregroundColor(.secondary)
                        )
                }

                Button(vm.isRunning ? "识别中..." : "识别面相并生成基础分析") {
                    Task { await vm.analyzeFace() }
                }
                .disabled(vm.isRunning)
                .buttonStyle(.borderedProminent)

                if !vm.errorText.isEmpty {
                    Text(vm.errorText)
                        .font(.footnote)
                        .foregroundColor(.red)
                }
            }
        }
    }

    private var analysisSection: some View {
        GroupBox("基础分析结果") {
            VStack(alignment: .leading, spacing: 10) {
                if let report = vm.report {
                    Text(report.overallSummary)
                        .font(.body)
                    ForEach(report.orderedScoreItems, id: \.0) { item in
                        Text("\(item.0.title)：\(item.1) 分")
                            .font(.subheadline)
                    }
                    if !report.keySignals.isEmpty {
                        Divider()
                        ForEach(report.keySignals, id: \.self) { line in
                            Text("• \(line)")
                                .font(.subheadline)
                        }
                    }
                    Divider()
                    Text(report.caution)
                        .font(.footnote)
                        .foregroundColor(.secondary)
                } else {
                    Text("完成识别后会显示整体分析。")
                        .foregroundColor(.secondary)
                }
            }
        }
    }

    private var qaSection: some View {
        GroupBox("输入问题并获取解答") {
            VStack(alignment: .leading, spacing: 10) {
                TextField("示例：我最近适合换工作吗？", text: $vm.question, axis: .vertical)
                    .textFieldStyle(.roundedBorder)
                Button("生成解答") {
                    vm.answerQuestion()
                }
                .buttonStyle(.borderedProminent)

                if !vm.answer.isEmpty {
                    Divider()
                    Text(vm.answer)
                        .font(.body)
                }
            }
        }
    }

    private var disclaimerSection: some View {
        GroupBox("免责声明") {
            Text("本应用结果仅用于相学文化研究与娱乐参考，不构成医疗、法律、投资等专业建议。")
                .font(.footnote)
                .foregroundColor(.secondary)
        }
    }
}
