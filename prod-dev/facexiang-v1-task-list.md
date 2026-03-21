# FaceXiang v1 工程 Task List

## 1. 说明

本任务清单基于以下文档：

- [facexiang-ios-detailed-prd.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-detailed-prd.md)
- [facexiang-page-interaction-design.md](/Users/lulu/Codex/FatellProject/docs/facexiang-page-interaction-design.md)
- [facexiang-ios-implementation-tasks.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-implementation-tasks.md)

工程实现口径以 `PRD` 为准。  
如果当前 `facexiang-mvp-v1.pen` 与 PRD 有冲突，优先按 PRD 实现。

当前已知需要按 PRD 收口的点：

- `Read Me` 主 CTA 进入 `Context Onboarding`，不是直接 `Today`
- `Context Onboarding` 需要覆盖 `fear / desire / important person / focus area`
- `Today First Ready` 的 CTA 应为：
  - `围绕这件事继续问`
  - `先收下今天这条提醒`
- Tab 命名按 PRD 的稳定命名实现，不沿用临时英文壳

## 2. Epic 划分

## Epic A：宿主与基础设施

### FX-A01 新建正式 iOS App 宿主

范围：

- 创建 `FaceXiangiOS` 工程或主 target
- 接入本地 `FaceXiangCore` package
- 配置 Bundle ID、Info.plist、Assets、相机/相册权限

依赖：

- 无

产出：

- 可运行的 iOS `.app`

完成标准：

- iPhone Simulator 可运行
- 相机/相册权限弹窗正常

### FX-A02 建立根路由与 App 壳

范围：

- `RootView`
- `AppRoute`
- `FirstSessionFlow`
- `MainTabShell`

依赖：

- `FX-A01`

产出：

- 可根据会话状态切换首次流与主 tab

完成标准：

- 未完成 first session 时进入首次流
- 完成后进入 tab 壳

### FX-A03 建立 `SessionStore`

范围：

- 管理匿名身份
- 管理是否已有 `Read Me`
- 管理 onboarding 完成状态
- 管理当前主 tension / 当前主线程

依赖：

- `FX-A02`

产出：

- App 根状态单一来源

完成标准：

- 重启后可恢复路由状态

### FX-A04 建立 service protocol 层

范围：

- `AnalysisServiceProtocol`
- `SessionServiceProtocol`
- `TodayServiceProtocol`
- `ThreadServiceProtocol`
- `MemoryServiceProtocol`

依赖：

- `FX-A01`

产出：

- 页面层不直接依赖 `FaceXiangCore` 具体实现

完成标准：

- mock service 可替换真实 service

### FX-A05 建立 shared design system 组件

范围：

- `PrimaryCTAButton`
- `SecondaryTextButton`
- `ShellEmptyStateCard`
- `ProgressStageList`
- `ReadMeSectionCard`
- `ExpandableWhyCard`
- `OnboardingQuestionCard`
- `MemoryItemCard`

依赖：

- `FX-A02`

产出：

- 首版页面共享组件

完成标准：

- First session 页面不再重复写按钮和状态布局

## Epic B：First Session 关键路径

### FX-B01 Home 页面

范围：

- `first_open`
- `returning_without_readme`
- `returning_with_readme`

依赖：

- `FX-A03`
- `FX-A05`

产出：

- 顾问型首页

完成标准：

- 主 CTA 进入拍照
- 回访态能显示主 tension 摘要

### FX-B02 Capture 页面

范围：

- 相机取景
- 相册选择
- 权限处理

依赖：

- `FX-A01`
- `FX-A05`

产出：

- 可用的图片输入页

完成标准：

- 拍照、选图、重拍、重选可用

### FX-B03 Photo Preview 页面

范围：

- 照片预览
- `使用这张照片`
- `重新拍照`
- `重新选择`

依赖：

- `FX-B02`

产出：

- 图片确认态

完成标准：

- 点击确认后进入 `quality_checking`

### FX-B04 Camera Permission Denied Sheet

范围：

- 权限解释
- 去相册
- 打开设置

依赖：

- `FX-B02`

完成标准：

- 权限拒绝不阻断首次流程

### FX-B05 Quality Fail 页面

范围：

- 单一失败原因
- 单一修复建议
- 重拍 / 重选

依赖：

- `FaceQualityAssessment`
- `FX-A05`

完成标准：

- 用户看完知道怎么修复

### FX-B06 Analyzing 页面

范围：

- `quality_checking`
- `uploading`
- `analyzing`
- `timeout`
- `failed`
- `partial_ready`

依赖：

- `FX-A03`
- `FX-A04`

完成标准：

- 超时不假死
- 失败可重试
- 降级态可进入简版结果

### FX-B07 Full Read Me 页面

范围：

- `Hook`
- `整体格局`
- `内在结构`
- `为什么这么判断`
- `下一步问题`

依赖：

- `ReadMeOutput`
- `ExplanationTrace`
- `FX-A05`

完成标准：

- 主 CTA 进入 `Context Onboarding`
- 不出现“保存这次解释”

### FX-B08 Partial Read Me 页面

范围：

- 第一印象
- 一个主 tension
- 最短版 why
- 下一步问题

依赖：

- `partial ReadMeOutput`

完成标准：

- 降级页仍有解释感

### FX-B09 Why 展开交互

范围：

- 收起态摘要
- 展开态 3 段结构

依赖：

- `FX-B07`

完成标准：

- 不暴露规则 ID / JSON

## Epic C：Onboarding 与首次承接

### FX-C01 Context Onboarding 页面框架

范围：

- 单题分步卡片
- 进度显示
- 跳过逻辑

依赖：

- `FX-B07`
- `FX-A05`

完成标准：

- 不卡在长表单

### FX-C02 Onboarding 问题配置

范围：

- fear
- desire
- important person
- focus area

依赖：

- `FX-C01`

完成标准：

- 覆盖 4 个必要维度

### FX-C03 Onboarding 本地草稿持久化

范围：

- 中途退出恢复
- 本地状态缓存

依赖：

- `FX-C01`
- `FX-A03`

完成标准：

- 中途退出回来不丢进度

### FX-C04 `Read Me -> Onboarding -> Today First Ready` 转场

范围：

- `Read Me` 主 CTA -> onboarding
- onboarding 完成 -> `Today First Ready`

依赖：

- `FX-B07`
- `FX-C01`

完成标准：

- 用户不回首页
- 首次连续感成立

### FX-C05 Today First Ready 页面

范围：

- 承接文案
- 今日主线首卡
- CTA：
  - `围绕这件事继续问`
  - `先收下今天这条提醒`

依赖：

- `FX-C04`
- `DailyGuidance`

完成标准：

- 看起来像 onboarding 承接页，不像普通 Today 首页

## Epic D：主 Tab 壳与页面壳层

### FX-D01 Main Tab Shell

范围：

- 4 个 tab
- 首次完成后进入主壳

依赖：

- `FX-A02`
- `FX-C04`

完成标准：

- tab 结构稳定可复用

### FX-D02 Today 页面

范围：

- `locked`
- `loading`
- `first_ready`
- `ready`

依赖：

- `FX-D01`

完成标准：

- Today 各状态可独立访问和预览

### FX-D03 Ask 页面

范围：

- `locked`
- `bootstrapping`
- `ready`
- `awaiting_response`

依赖：

- `FX-D01`

完成标准：

- 首线程建立逻辑清晰
- 等待回复时保留用户输入

### FX-D04 My Story 页面

范围：

- `locked`
- `empty`
- `ready`

页面结构实现优先级：

1. 当前主 tension
2. 当前主线程
3. 最近 7 天摘要
4. `Memory` 入口
5. 历史流

依赖：

- `FX-D01`

完成标准：

- 不做成纯时间线页

### FX-D05 Memory 页面

范围：

- 列表
- 编辑
- 压制
- 删除

依赖：

- `FX-D04`

完成标准：

- 用户能纠正至少一条关键记忆

### FX-D06 Settings 页面

范围：

- 隐私说明
- 删除图片
- 删除记忆
- 删除账号

依赖：

- `FX-D01`

完成标准：

- 数据删除入口清楚

### FX-D07 Delete Confirmation 流程

范围：

- 删除图片确认
- 删除记忆确认
- 删除账号确认

依赖：

- `FX-D05`
- `FX-D06`

完成标准：

- 危险操作表达清楚、不惊悚

## Epic E：真实数据与接口接入

### FX-E01 匿名身份接入

范围：

- `bootstrapAnonymousSession`
- `Keychain` 恢复

依赖：

- `FX-A03`
- `FX-A04`

完成标准：

- 首次无登录进入
- 重启后恢复

### FX-E02 分析链接入

范围：

- 质量门结果
- 完整 `Read Me`
- 简版 `Read Me`
- 失败态

依赖：

- `FX-B05`
- `FX-B06`
- `FX-B07`
- `FX-B08`

完成标准：

- 页面消费真实分析输出

### FX-E03 Today mock / fixture 接入

范围：

- `DailyGuidance` fixture

依赖：

- `FX-D02`

完成标准：

- Today 不依赖后端也可联调

### FX-E04 Ask mock / fixture 接入

范围：

- `GuidanceThread`
- `ThreadMessage`

依赖：

- `FX-D03`

完成标准：

- Ask 结构联调可用

### FX-E05 Memory mock / fixture 接入

范围：

- `MemoryItem`

依赖：

- `FX-D05`

完成标准：

- My Story / Memory 可联调

## Epic F：埋点、QA、可用性

### FX-F01 页面埋点

范围：

- Home CTA
- 图片提交
- 质量门失败原因
- Analyzing 超时
- `Why` 展开
- Onboarding 完成
- Today 打开
- Ask 首次进入
- Memory 编辑/压制/删除

依赖：

- 各页面完成

完成标准：

- 首会话关键行为均可观测

### FX-F02 手工 QA 清单执行

范围：

- 首次成功路径
- 权限拒绝
- 质量门失败各类型
- 超时
- 降级
- Onboarding
- Today First Ready
- tab 锁定态

完成标准：

- 无阻断问题

### FX-F03 可访问性与基础适配

范围：

- 动态字体
- VoiceOver 基本可读
- 小屏适配
- 弱网输入不丢

完成标准：

- 无明显可用性硬伤

## 3. 最小可交付集

如果只做第一轮可联调版本，先完成：

- `FX-A01` ~ `FX-A05`
- `FX-B01` ~ `FX-B09`
- `FX-C01` ~ `FX-C05`
- `FX-D01`
- `FX-D02`

到这里可以完成：

- first session 完整链路
- onboarding 承接
- Today 首次 ready
- 主壳初步可用

## 4. 第二轮可交付集

第二轮完成：

- `FX-D03` ~ `FX-D07`
- `FX-E01` ~ `FX-E05`
- `FX-F01` ~ `FX-F03`

到这里可以完成：

- 壳层页面联调
- 匿名身份恢复
- mock 驱动的 Today / Ask / Memory
- QA 与埋点闭环
