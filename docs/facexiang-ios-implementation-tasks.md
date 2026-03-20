# FaceXiang iOS 实现任务清单

## 1. 文档目标

本文件将 [facexiang-page-interaction-design.md](/Users/lulu/Codex/FatellProject/docs/facexiang-page-interaction-design.md) 的页面方案，拆成 iOS 可执行任务。

目标不是继续扩展当前演示式 `FaceXiangApp`，而是：

- 保留 `FaceXiangCore` 的可复用资产
- 新建正式 iOS App 宿主
- 先完成 `first aha` 路径
- 再接入 `Today / Ask / My Story` 的壳层

## 2. 当前代码基线

当前代码结构判断如下：

- `ios-mvp/FaceXiangMVP/Sources/FaceXiangCore`
  - 可复用：基础模型、识别适配器、规则引擎思路、mock/test
- `ios-mvp/FaceXiangMVP/Sources/FaceXiangApp/ContentView.swift`
  - 不建议继续扩展
- `ios-mvp/FaceXiangMVP/Sources/FaceXiangApp/ViewModel.swift`
  - 只适合作为原型参考，不适合作为正式状态流
- `ios-mvp/FaceXiangMVP/Sources/FaceXiangApp/CameraPicker.swift`
  - 可复用为拍照桥接组件

结论：

- `识别与规则层：保留并重构`
- `App 壳、导航、页面、状态管理：重建`

## 3. iOS 实施原则

### 3.1 先宿主，再页面

必须先有正式 iOS App 宿主与导航结构，再接页面。

### 3.2 先状态机，再 UI

先定义首会话状态机：

- `idle`
- `photo_selected`
- `quality_checking`
- `quality_failed`
- `uploading`
- `analyzing`
- `readme_partial_ready`
- `readme_ready`
- `context_collecting`
- `today_ready`
- `failed`

再实现页面切换。

### 3.3 先 mock 打通，再接真服务

页面开发先用 fixture/mock 跑通，再接 `FaceXiangCore` 与后端接口。

### 3.4 先 first aha，再壳层

`Home / Capture / Quality Fail / Analyzing / Read Me / Context Onboarding` 必须先完成。  
`Today / Ask / My Story` 先做壳层与空状态。

## 4. 目标工程结构

建议 iOS 侧最终结构如下：

```text
FaceXiangiOS/
  App/
    FaceXiangiOSApp.swift
    AppCoordinator.swift
    RootView.swift
  Features/
    FirstSession/
      Home/
      Capture/
      QualityFail/
      Analyzing/
      ReadMe/
      ContextOnboarding/
    Today/
    Ask/
    MyStory/
    Memory/
  Shared/
    Components/
    DesignTokens/
    Extensions/
  State/
    SessionStore.swift
    AppRoute.swift
    FirstSessionState.swift
  Services/
    AnalysisService.swift
    SessionService.swift
    TodayService.swift
    ThreadService.swift
    MemoryService.swift
```

说明：

- `FaceXiangCore` 继续留在 package 中
- `FaceXiangiOS` 作为真正可运行、可上架的宿主

## 5. 必要接口契约

在 iOS 页面实现前，客户端必须依赖以下 DTO 或 service protocol：

- `ReadMeOutput`
- `ExplanationTrace`
- `FaceQualityAssessment`
- `DailyGuidance`
- `GuidanceThread`
- `MemoryItem`

建议先定义以下协议，便于 mock：

- `AnalysisServiceProtocol`
  - `submitPhoto`
  - `pollAnalysisStatus`
  - `fetchReadMe`
- `SessionServiceProtocol`
  - `bootstrapAnonymousSession`
  - `loadCurrentProfile`
- `TodayServiceProtocol`
  - `fetchToday`
- `ThreadServiceProtocol`
  - `bootstrapThread`
  - `sendMessage`
- `MemoryServiceProtocol`
  - `fetchMemory`
  - `updateMemory`
  - `suppressMemory`
  - `deleteMemory`

## 6. 分阶段任务清单

## Stage 0：工程基线与宿主重建

### IOS-001 新建正式 iOS App 宿主

- 创建 `FaceXiangiOS` 工程或 target
- 接入本地 package `FaceXiangCore`
- 配置 Bundle ID、Info.plist、Assets、隐私权限

验收：

- 可在 iPhone Simulator 运行真正的 `.app`
- 相机/相册权限弹窗正常

### IOS-002 建立根导航与路由

- 定义 `AppRoute`
- 定义 `RootView`
- 区分：
  - `FirstSessionFlow`
  - `MainTabShell`

验收：

- App 可根据会话状态进入首次路径或 tab 壳

### IOS-003 建立会话状态存储

- 新建 `SessionStore`
- 管理：
  - 是否已有匿名身份
  - 是否已有 `Read Me`
  - 是否已完成 onboarding
  - 当前主 tension
  - 当前主线程

验收：

- App 重启后仍能恢复根路由状态

### IOS-004 建立 shared UI 基础组件

- `PrimaryCTAButton`
- `SecondaryTextButton`
- `ShellEmptyStateCard`
- `ProgressStageList`
- `ReadMeSectionCard`
- `ExpandableWhyCard`
- `OnboardingQuestionCard`

验收：

- 首批页面不再重复手写按钮和空状态结构

## Stage 1：First Session Flow 页面骨架

### IOS-101 实现 Home 页面

- 落地 Hero 区、CTA、信任区、轻量示意区
- 区分：
  - `first_open`
  - `returning_without_readme`
  - `returning_with_readme`

依赖：

- `SessionStore`

验收：

- 用户 5 秒内能理解产品不是面部识别工具

### IOS-102 实现 Capture / Upload 页面

- 复用 `CameraPicker.swift`
- 接入相册与拍照
- 实现图片预览与确认
- 实现权限拒绝回退

依赖：

- iOS 权限配置

验收：

- 拍照、选图、重拍、重选都可用

### IOS-103 实现质量门失败页

- 按 `failureReasons` 映射到固定文案
- 只展示一个主要失败原因
- 支持：
  - `重新拍照`
  - `从相册选择另一张`

依赖：

- `FaceQualityAssessment`

验收：

- 失败页不会把用户踢回首页

### IOS-104 实现分析中页面

- 三段式进度
- 超时状态
- 失败状态
- 降级状态入口

依赖：

- `FirstSessionState`

验收：

- 超时不会像卡死
- 用户可继续等待或重试

## Stage 2：Read Me 渲染层

### IOS-201 定义 Read Me 页面 view model

- 将 `ReadMeOutput + ExplanationTrace` 转成 UI section model
- 输出：
  - `Hook`
  - `整体格局`
  - `内在结构`
  - `为什么这么判断`
  - `下一步问题`

依赖：

- `ReadMeOutput`

验收：

- 页面不直接依赖底层 DTO 细节

### IOS-202 实现 Read Me 页面

- 按固定顺序渲染 5 个区块
- 首屏先显示 `Hook + 整体格局`
- 底部操作：
  - `继续，让它更贴近我现在的处境`
  - `换一张照片重看`

验收：

- 页面首屏先命中 tension，不先展示知识点

### IOS-203 实现 Why 卡片展开/收起

- `ExpandableWhyCard` 默认半展开
- 收起态显示 `trace.whySummary`
- 展开态显示：
  - `我看到了什么`
  - `这些位置通常指向什么`
  - `为什么会落到你现在的 tension`

验收：

- 不出现规则 ID 或 JSON
- 普通用户能读懂

### IOS-204 支持简版 Read Me

- 处理 `partial_readme`
- 只渲染：
  - 第一印象
  - 一个主 tension
  - 一个下一步问题
- 仍保留 `为什么这么判断`

验收：

- 降级结果仍有解释性

### IOS-205 实现更新画像入口

- `returning_with_readme` 状态下支持重新上传图片
- 更新后替换当前画像与 `Read Me`

验收：

- 老画像可被新结果覆盖

## Stage 3：Context Onboarding 与首次转场

### IOS-301 实现单题分步 onboarding

- 四题以内
- 每题支持快捷选项 + 自由输入 + 跳过
- 问题顺序与页面文档一致

依赖：

- question config fixture

验收：

- 不出现长表单

### IOS-302 实现 onboarding 答案持久化

- 把答案写入本地状态
- 为后续服务端写入预留接口

验收：

- 中途退出再回来可以恢复进度

### IOS-303 完成 `Read Me -> Context Onboarding -> Today First Ready` 转场

- `Read Me` CTA 进入 onboarding
- onboarding 完成后进入 `Today` 首次 ready 状态

验收：

- 用户不回首页
- 首次连续感成立

### IOS-304 实现 Today 首次 ready 状态

- 顶部承接文案
- CTA：
  - `围绕这件事继续问`
  - `先收下今天这条提醒`

验收：

- 能自然引导到 `Ask` 或留在 `Today`

## Stage 4：Main Tab Shell 与壳层页面

### IOS-401 实现底部 Tab Shell

- 4 个 tab：
  - `Read Me`
  - `Today`
  - `Ask`
  - `My Story`

验收：

- 首次完成后自动进入 tab 壳

### IOS-402 实现 Today 壳层

- `locked`
- `loading`
- `ready`
- `first_ready`

验收：

- 未完成 `Read Me` 时给明确锁定说明

### IOS-403 实现 Ask 壳层

- `locked`
- `bootstrapping`
- `ready`
- `awaiting_response`

验收：

- 未完成 `Read Me` 或没有线程时，状态清晰

### IOS-404 实现 My Story 壳层

- `locked`
- `empty`
- `ready`

内容至少包含：

- 当前主 tension
- 当前主线程
- 最近 7 天摘要
- `Memory` 入口

验收：

- 用户能理解这里是“被记得”的地方

### IOS-405 实现 Memory 页面壳层

- 列表展示：
  - 关键人物
  - 当前关注主题
  - 已确认记忆
- 每条记忆操作：
  - `修改`
  - `不要再提`
  - `删除`

验收：

- 记忆 review 入口清晰

## Stage 5：服务接入与替换旧原型

### IOS-501 定义 service adapter 层

- 不让页面直接调用 `OpenRouterFaceRecognizer`
- 在 iOS 宿主中只依赖 protocol

验收：

- 页面可完全使用 mock service 跑通

### IOS-502 替换旧 ContentView 单页入口

- 不再使用当前 `ContentView.swift` 作为主 UI
- 新 root 完全承载首页、流程页和 tab 壳

验收：

- 单页演示结构退出主链路

### IOS-503 接通分析链真实数据

- 质量门结果
- `ReadMeOutput`
- `ExplanationTrace`
- 失败态/降级态

验收：

- 页面能消费真实分析结果

### IOS-504 接通 Today / Ask / My Story mock 数据

- 在后端未就绪前，先用 fixture 驱动页面壳

验收：

- 后续接真接口时无需重写页面结构

## Stage 6：质量、埋点与验收

### IOS-601 页面埋点

- Home 主 CTA 点击
- 图片提交
- 质量门失败原因
- Analyzing 超时
- `为什么这么判断` 展开
- Onboarding 完成
- Today 打开
- Ask 首次进入

验收：

- 首会话关键行为均可观测

### IOS-602 手工 QA 场景

- 首次成功路径
- 相机权限拒绝
- 相册选图
- 质量门失败 5 类以上
- Analyzing 超时
- 简版 Read Me
- Read Me 后进入 onboarding
- onboarding 完成后进入 Today
- tab 壳锁定态

验收：

- 关键路径无阻断

### IOS-603 可访问性与基础可用性

- 动态字体
- VoiceOver 基本可读
- 小屏不溢出
- 弱网时操作不丢

验收：

- 不出现明显可用性硬伤

## 7. 复用与替换清单

建议复用：

- `CameraPicker.swift`
- `FaceXiangCore` 里的基础模型思路
- `OpenRouterFaceRecognizer.swift` 的网络调用逻辑
- `FaceAnalysisEngine.swift` 的部分规则映射思路

建议替换：

- `ContentView.swift`
- `ViewModel.swift`
- 旧 `AnalysisReport` 的展示方式
- 旧 `QuestionAdvisor` 驱动的问答入口

## 8. 最小交付顺序

如果只按最短路径推进，iOS 侧先做这 10 项：

1. `IOS-001`
2. `IOS-002`
3. `IOS-003`
4. `IOS-004`
5. `IOS-101`
6. `IOS-102`
7. `IOS-103`
8. `IOS-104`
9. `IOS-201`
10. `IOS-202`

做到这里，first session 的页面骨架就能开始联调。  
之后再接：

11. `IOS-203`
12. `IOS-301`
13. `IOS-303`
14. `IOS-304`
15. `IOS-401`
16. `IOS-402`
17. `IOS-403`
18. `IOS-404`
