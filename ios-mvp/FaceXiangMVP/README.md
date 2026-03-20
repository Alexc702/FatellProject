# FaceXiangMVP (iOS)

基于 `docs/product-plan.md` 与 `知识库/xiangxue_knowledge_complete_149p.json` 的最小闭环实现：

- 拍照或选图
- OpenRouter VLM 输出结构化面相结果
- 基础相学分析（五官/三停/宫位信号映射）
- 输入一个问题并给出方向性解答
- 使用 50 条结构化识别数据自动化验证

## 目录

- `Sources/FaceXiangApp`：SwiftUI iOS 界面（拍照、识别、分析、问答）
- `Sources/FaceXiangCore`：识别模型数据结构、分析引擎、问答器、OpenRouter 客户端
- `Sources/FaceXiangValidator`：功能验证程序（跑 50 条测试数据）
- `Tests/FaceXiangCoreTests/fixtures/face_profiles_50.json`：50 条结构化测试数据

## 运行功能验证

在工程目录执行：

```bash
cd /Users/xavier/FatellProject/ios-mvp/FaceXiangMVP
swift run FaceXiangValidator
```

预期输出包含：

- `VALIDATION_OK total_profiles=50`
- `AVERAGE_SCORES ...`
- `FLOW_CHECK ...`

## 运行 iOS App

当前环境未安装完整 Xcode，无法直接在命令行构建 iOS target。  
在安装并启用完整 Xcode 后，直接在 Xcode 中打开：

`/Users/xavier/FatellProject/ios-mvp/FaceXiangMVP/Package.swift`

选择 iOS Simulator 运行 `FaceXiangApp` 即可。

## OpenRouter 配置

App 首页包含：

- `OpenRouter API Key`
- `VLM 模型名`

API key 为空时自动走 `MockFaceRecognizer`，用于离线验证流程。  
有 key 时调用 OpenRouter 接口进行真实图片识别。

## 免责声明

结果仅用于相学文化研究与娱乐参考，不构成医疗、法律、投资等专业建议。
