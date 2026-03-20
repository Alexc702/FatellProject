# FaceXiang 里程碑 Backlog 与 MVP 演进建议

## 1. 结论先行

对现有 `ios-mvp/FaceXiangMVP` 的建议不是“直接继续堆功能”，也不是“全部推倒重写”，而是：

`保留核心领域与识别原型，重建 App 宿主、状态流和产品层。`

更具体地说：

- `FaceXiangCore` 里与面相结构化识别、基础规则映射有关的部分，可以保留并重构
- `FaceXiangApp` 这一层更像演示 UI，不适合作为正式 v1 的产品骨架
- 新的 v1 应该建立在：
  - 真正的 iOS App 宿主
  - 新的信息架构
  - 新的身份/记忆/线程模型
  - 新的异步与失败回退流程

所以我的建议是：

- `不重写全部`
- `但需要半重构式重建`

## 2. 对当前 MVP 的总体判断

当前 MVP 已经证明了几件有价值的事情：

- 图片输入链路能跑通
- OpenRouter 结构化输出可用
- 基础相学规则引擎已存在
- 有最小测试与 mock 能力

但它离当前目标产品还有本质差距：

- 现在是“单次分析工具”
- 目标是“强 first aha + 连续关系”

因此，不应把当前代码当作“v1 成品起点”，而应把它当作：

- `识别原型`
- `规则层原型`
- `Prompt / mock / 测试原型`

## 3. 哪些部分建议保留

### 3.1 建议保留并重构

- [Models.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Sources/FaceXiangCore/Models.swift)
  - 可作为 `FaceProfile / FaceQuality / FaceFeatures` 的基础
  - 但需要补 `ObservedFeature / RuleHit / ExplanationTrace / TensionHypothesis`

- [OpenRouterFaceRecognizer.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Sources/FaceXiangCore/OpenRouterFaceRecognizer.swift)
  - 可保留为 v1 的视觉抽取适配器
  - 但要从“直接返回 FaceProfile”升级成“质量门 + 结构化抽取 + 可重试 + 输出校验”

- [FaceAnalysisEngine.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Sources/FaceXiangCore/FaceAnalysisEngine.swift)
  - 可保留其中规则映射思路
  - 但要从“分数导向”改成“rule hit + tension hypothesis 导向”

- [FaceAnalysisEngineTests.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Tests/FaceXiangCoreTests/FaceAnalysisEngineTests.swift)
  - 可保留测试习惯与样本机制
  - 后续应扩展为 trace、prompt regression、memory/threads 的测试

### 3.2 建议保留但位置要变

- `MockFaceRecognizer`
- `FaceXiangValidator`

它们适合作为：

- 内部验证工具
- 回归测试工具

不应继续影响正式 App 的产品结构。

## 4. 哪些部分不建议直接延续

### 4.1 FaceXiangApp UI 层

以下文件不建议作为正式 v1 的骨架继续迭代：

- [ContentView.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Sources/FaceXiangApp/ContentView.swift)
- [ViewModel.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Sources/FaceXiangApp/ViewModel.swift)
- [FaceXiangApp.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Sources/FaceXiangApp/FaceXiangApp.swift)

原因：

- 当前是单页演示式布局
- 状态全在一个 `ViewModel`
- 没有身份、记忆、线程、Today、My Story 的导航与状态分层
- 没有异步状态机与回退设计

### 4.2 QuestionAdvisor

- [QuestionAdvisor.swift](/Users/lulu/Codex/FatellProject/ios-mvp/FaceXiangMVP/Sources/FaceXiangCore/QuestionAdvisor.swift)

不建议继续作为核心问答器扩展。

原因：

- 它本质是“关键词分类 + 按分数返回模板”
- 适合最小演示，不适合“围绕 tension 的连续线程”

建议：

- 保留作为临时 fallback
- 正式版本用 `ThreadResponse` 生成链路替代

## 5. 结构性建议：重构，不重写全部

建议演进策略：

### 阶段 A：保留现有 package 里的可复用核心

- 面相结构化模型
- OpenRouter 抽取适配器
- 基础规则引擎
- mock 与验证工具

### 阶段 B：新增正式 App 宿主与产品层

- `FaceXiangiOS`
- 真正的 iOS App target
- 新导航、新状态流、新页面

### 阶段 C：逐步替换旧逻辑

- 先替换 UI 和状态管理
- 再替换规则输出结构
- 再替换问答器为线程机制

## 6. 里程碑规划

建议拆成 6 个里程碑。

## M0：架构收敛与迁移准备

目标：

- 确认正式工程结构和迁移边界

产出：

- iOS App 宿主方案
- 模块划分
- 页面与交互设计文档
- iOS 实现任务清单
- 旧代码保留/替换清单

任务：

- 新建 `FaceXiangiOS` 宿主工程方案
- 确定 `FaceXiangCore / FaceXiangAI / FaceXiangMemory / FaceXiangFeatures`
- 确定匿名身份策略
- 确定第一阶段不再继续扩展旧 `ContentView`

依赖：

- 现有 PRD 与 5 份执行 spec

验收：

- 团队对“重构，不全重写”的边界一致

## M1：Read Me 基础链路重建

目标：

- 先打透 `first aha`

产出：

- 自拍 -> 质量门 -> 特征 -> rule hit -> tension hypothesis -> Read Me

任务包：

### 1. App 宿主与页面骨架

- 新建 iOS App target
- 首页 / Read Me / 分析中 / 失败回退页面
- 基础导航结构

### 2. 识别链路改造

- 引入 `FaceQualityGate`
- 抽取 `ObservedFeature`
- 规则命中 `RuleHit`
- tension 假设 `TensionHypothesis`
- 解释链路 `ExplanationTrace`

### 3. 文案生成

- 按 `v1-copy-and-prompt-spec.md` 生成 Read Me
- 禁止 generic opening

### 4. 测试

- 固定样本集回归
- first aha 人工评审

建议复用代码：

- `OpenRouterFaceRecognizer`
- `FaceProfile / FaceFeatures`
- `FaceAnalysisEngine` 中的部分规则

建议替换代码：

- `AnalysisReport` 输出结构
- 旧的 summary 逻辑

验收：

- 用户看完能理解“为什么这么判断”
- 样本用户不普遍评价为“模板”

## M2：身份、记忆与 My Story

目标：

- 建立连续关系的最低基础设施

产出：

- 匿名身份
- 云端主存
- Memory Review
- My Story 基础页

任务包：

### 1. 身份层

- 匿名用户创建
- Keychain 持久化
- 会话恢复

### 2. 记忆层

- `MemoryItem`
- `TensionProfile`
- 记忆来源与状态
- suppress / delete / correction

### 3. 页面

- My Story
- Memory Review
- Settings 中的数据删除入口

### 4. 测试

- 重启恢复
- 记忆纠错
- 删除后不可再引用

建议复用代码：

- 无明显现成实现，基本为新增

## M3：线程化 Ask

目标：

- 用线程替代单问单答

产出：

- `GuidanceThread`
- `ThreadMessage`
- Ask About This 页面

任务包：

### 1. 线程模型

- 线程类型
- 线程阶段
- 当前主线程选择逻辑

### 2. Ask 生成链路

- 当前问题
- 历史线程摘要
- 当前主 tension
- 下一步追问

### 3. 测试

- 同主题二次提问
- 跨主题切换
- 历史上下文承接

建议替换代码：

- `QuestionAdvisor` 主逻辑

建议保留：

- 关键词分类可临时作为线程类型 hint

## M4：Today With Me

目标：

- 建立回访理由

产出：

- contextual daily guidance

任务包：

### 1. 生成逻辑

- 绑定当前主线程
- 输出 imbalance point / notice point / small action

### 2. 页面与埋点

- Today 页面
- 打开率、阅读率、追问率埋点

### 3. 测试

- Today 是否与当前主线相关
- 是否明显优于 generic daily card

## M5：Weekly Pattern Recap

目标：

- 把产品从回答器升级成人生镜子

产出：

- Weekly Recap 生成与页面

任务包：

- 线程摘要
- recurring pattern 计算
- next thread suggestion
- recap 页面

测试：

- 用户是否认可 recap 在“观察我的 pattern”

## M6：内测与上架准备

目标：

- 形成可测、可灰度、可审核版本

产出：

- 崩溃监控
- 隐私协议
- 数据删除
- App Store 元数据

## 7. Backlog 分层

建议用 4 个泳道管理 backlog。

### 泳道 A：Product Critical Path

- Read Me first aha
- Context onboarding
- Thread Ask
- Today
- Weekly Recap

### 泳道 B：Core Platform

- App 宿主
- 匿名身份
- 数据同步
- Keychain
- 日志埋点

### 泳道 C：AI & Domain

- Feature extraction
- Rule mapping
- tension hypothesis
- copy / prompt regression

### 泳道 D：Trust & Safety

- 免责声明
- 删除能力
- 边界文案
- 审核风险排查

## 8. 建议的任务拆解顺序

如果团队资源有限，建议严格按这个顺序推进：

1. App 宿主与导航骨架
2. Read Me 结构化链路
3. Read Me 文案打磨
4. 匿名身份与服务端主存
5. 记忆与纠错
6. Ask 线程
7. Today
8. Weekly Recap
9. 上架准备

不要反过来先做：

- Today 页面
- 复杂聊天体验
- 订阅与支付

否则会在核心价值未成立前过早产品化。

## 9. 我对“继续改”还是“重写”的明确建议

### 不建议

- 在现有 `FaceXiangApp` 单页 UI 上继续堆功能
- 直接把 `QuestionAdvisor` 扩展成正式线程系统
- 继续把 OpenRouter config、识别、报告、问答全部塞进一个 `ViewModel`

### 建议

- 新建正式 iOS 宿主
- 复用并重构 `FaceXiangCore`
- 用新规格替换旧输出结构
- 把旧 MVP 视为可迁移资产，而不是正式产品骨架

## 10. 最终建议

一句话：

`推荐基于当前 MVP 重构演进，而不是在现有 UI/状态结构上继续加功能。`

如果要更明确一点：

- `核心识别与规则层：保留并重构`
- `App 壳、页面结构、状态管理、线程系统：建议重建`

这条路径风险最低，因为它兼顾了：

- 不浪费已有原型资产
- 不把未来架构绑死在演示代码上
