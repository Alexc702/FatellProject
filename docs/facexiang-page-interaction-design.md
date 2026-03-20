# FaceXiang v1 页面与交互设计

## 1. 文档目标

本文件将 [analysis-trace-spec.md](/Users/lulu/Codex/FatellProject/docs/analysis-trace-spec.md) 的分析链路，落实为首版 iOS 产品页面与交互设计。

本轮范围采用：

- `关键路径做透`
  - `Home -> Capture/Upload -> Quality Fail -> Analyzing -> Read Me -> Context Onboarding -> Today`
- `壳层先定义`
  - `Today / Ask / My Story` 先定义导航、首屏结构、空状态和入口逻辑

本文件不包含：

- 高保真视觉稿
- 视觉品牌系统
- UI 动效细节实现

对应的工程拆解见：

- [facexiang-ios-implementation-tasks.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-implementation-tasks.md)

对应的详细产品说明见：

- [facexiang-ios-detailed-prd.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-detailed-prd.md)

## 2. 设计原则

### 2.1 先解释“为什么会这样”，再给建议

`Read Me` 的第一任务不是列面部特征，而是把用户带到一个感觉：

- 它不是在识别我长什么样
- 它是在解释我现在为什么会这样

### 2.2 先命中，再解释

核心页面必须遵循：

`Hook -> 整体格局 -> 内在结构 -> 为什么这么判断 -> 下一步`

不要一上来展示知识点或长报告。

### 2.3 先一个主动作，再给次选择

first session 每个页面只允许一个清晰主 CTA。  
次 CTA 只承担回退和纠错，不参与主流程竞争。

### 2.4 术语留在系统里，用户看到的是解释

系统内部使用：

- `ObservedFeature`
- `OfficialAssessment`
- `ZoneAssessment`
- `PalaceAssessment`
- `InterpretationArc`
- `TensionHypothesis`

用户界面只看到：

- 整体格局
- 当前更容易出现的模式
- 为什么会落到这个 tension

### 2.5 失败必须具体

不允许出现：

- 识别失败
- 系统错误
- 图片不合法

必须说清：

- 为什么失败
- 怎么修复
- 可以马上做什么

## 3. 信息架构与导航

## 3.1 顶层结构

首版正式信息架构采用 4 个主 tab：

1. `Read Me`
2. `Today`
3. `Ask`
4. `My Story`

## 3.2 首次使用导航规则

首次进入时，不直接展示完整 tab 结构，而是进入 `Read Me First Session Flow`：

1. `Home`
2. `Capture / Upload`
3. `Quality Fail` 或 `Analyzing`
4. `Read Me`
5. `Context Onboarding`
6. `Today First Ready`

在以下条件成立前，不开放完整 tab 导航：

- 用户已得到首个 `Read Me`
- 用户已完成或跳过 `Context Onboarding`

完成后进入正式 App 壳，展示底部 tab bar。

## 3.3 首次后导航规则

### Read Me

- 展示当前画像
- 支持重新上传照片更新画像

### Today

- 默认打开今日 guidance
- 若尚未生成，展示 loading

### Ask

- 默认打开当前主 tension 对应线程
- 如果没有线程，则用 `Read Me` 的主 tension 自动建一个线程

### My Story

- 展示当前主线、最近 7 天摘要、记忆管理入口

## 3.4 页面分组

### A. First Session Flow

- `Home`
- `Capture / Upload`
- `Quality Fail`
- `Analyzing`
- `Read Me`
- `Context Onboarding`
- `Today First Ready`

### B. Core Tabs

- `Read Me`
- `Today`
- `Ask`
- `My Story`

### C. Secondary Pages

- `Memory`
- `Settings`
- `Delete Data Flow`

## 4. 数据到页面的映射

## 4.1 Read Me 页面使用的数据对象

页面必须消费：

- `ReadMeOutput`
- `ExplanationTrace`

必要字段映射：

- `hookLine` -> `Hook`
- `overallPattern` -> `整体格局`
- `defensePattern` + `relationshipSignal` + `careerOrRealitySignal` -> `内在结构`
- `primaryTension` -> `当前主线`
- `trace.whySummary` -> `为什么这么判断` 收起态摘要

展开态解释的来源：

- `primaryObservedFeatures` -> `我看到了什么`
- `primaryOfficialAssessments / primaryZoneAssessments / primaryPalaceAssessments / primaryRuleHits` -> `这些位置通常指向什么`
- `primaryInterpretationArcs / primaryTensionHypotheses` -> `为什么会落到你现在的 tension`

## 4.2 异常状态使用的数据对象

- `FaceQualityAssessment.failureReasons` -> `Quality Fail`
- `async state` -> `Analyzing`
- `partial ReadMeOutput` -> `简版 Read Me`

## 4.3 后续壳层页面使用的数据对象

- `DailyGuidance` -> `Today`
- `GuidanceThread / ThreadMessage` -> `Ask`
- `TensionProfile / MemoryItem / WeeklyRecap` -> `My Story`

## 5. 页面规格

## 5.1 Home

### 目标

- 用户在 5 秒内理解：这不是“面部识别功能”，而是“从脸开始认识你、解释你为什么会这样”的顾问型 AI。

### 页面结构

1. 顶部品牌区
   - 产品名
   - 一句价值主张
2. Hero 区
   - 主标题：从你的脸开始，看你现在真正卡住的那根线
   - 一段短说明：系统会观察整体格局、五官功能、三停与重点宫位，再生成第一版画像
3. 主 CTA
   - `开始看我现在的状态`
4. 次 CTA
   - `从相册选择`
5. 信任区
   - 图片仅用于生成画像，可删除
   - 内容为文化解读与方向参考，不替代专业意见
6. 轻量示意区
   - `它会怎么看你`
   - 只用 3 个短点说明：
     - 整体格局
     - 当前更容易失衡的模式
     - 为什么会落到这个 tension

### 交互规则

- 主按钮固定最显眼，首屏不出现多个同级入口
- 首屏不出现长术语解释
- 点击主 CTA 默认进入相机
- 点击次 CTA 直接进入系统相册

### 页面状态

- `first_open`
- `returning_without_readme`
- `returning_with_readme`

对于 `returning_with_readme`：

- 首屏 CTA 改为 `更新我的画像`
- 可显示最近一次主 tension 摘要

## 5.2 Capture / Upload

### 目标

- 让用户快速提交一张适合进入完整相学分析的照片

### 页面结构

1. 顶部返回
2. 取景区或图片预览区
3. 一句拍摄指引
   - 正脸
   - 自然光
   - 单人
   - 无遮挡
4. 主 CTA
   - `使用这张照片`
5. 次 CTA
   - `重新拍照`
   - `重新选择`

### 交互规则

- 用户一旦拍完或选完，默认展示确认页而不是直接提交
- 点击 `使用这张照片` 后立即进入 `quality_checking`
- 相机权限拒绝时出现底部弹层：
  - `去相册选择`
  - `打开系统设置`

### 页面状态

- `camera_ready`
- `photo_preview`
- `camera_permission_denied`

## 5.3 Quality Fail

### 目标

- 让失败是可理解、可修复、可立即继续的

### 页面结构

1. 顶部标题
   - 不用“识别失败”
   - 直接说主要原因
2. 中部说明
   - 1 句具体原因
   - 1 句重拍建议
3. 底部操作
   - 主 CTA：`重新拍照`
   - 次 CTA：`从相册选择另一张`

### 失败文案映射

#### `no_face`

- 标题：没有检测到清晰正脸
- 建议：请正对镜头，保证脸部完整进入画面

#### `multiple_faces`

- 标题：这张照片里有多人
- 建议：请换成只有你一个人的正脸照片

#### `poor_lighting`

- 标题：光线太暗，额头和五官不够清楚
- 建议：请在自然光下重拍，避免逆光

#### `heavy_occlusion`

- 标题：遮挡过多，无法判断关键部位
- 建议：请移开头发、口罩或墨镜后再试

#### `not_frontal`

- 标题：角度偏侧，无法进入完整分析
- 建议：请正对镜头，避免侧脸和低头

#### `low_clarity`

- 标题：照片偏糊，关键细节不够清楚
- 建议：请换一张更清晰的照片

### 交互规则

- 每次只展示一个最主要原因
- 页面必须保留前一步的操作感，不让用户被踢回首页

## 5.4 Analyzing

### 目标

- 把等待变成“被认真观察”的过程

### 页面结构

1. 顶部可选返回
   - 默认不鼓励返回
2. 中部进度展示
   - 三段式进度
3. 底部说明
   - 为什么需要一点时间

### 标准进度文案

1. `正在检查照片质量`
2. `正在观察你的整体格局与关键部位`
3. `正在整理你的第一版画像`

### 超时状态

当等待超过 8 秒：

- 主文案切换为：
  - `还差一点，我们正在把观察结果整理成更像你的表达`
- 出现两个操作：
  - 主 CTA：`继续等待`
  - 次 CTA：`重新尝试`

### 失败状态

如果进入失败：

- 标题：这次没能顺利整理出完整画像
- 说明：不是你的问题，可能是网络或分析过程被打断了
- 操作：
  - `再试一次`
  - `换一张照片`

### 降级状态

若可返回简版结果：

- 标题：先给你一个简版观察
- 说明：完整版本还在整理，但这部分已经足够开始判断
- CTA：`先看简版结果`

## 5.5 Read Me

### 目标

- 完成 `first aha`

### 页面结构

首屏固定按以下顺序出现：

1. `Hook`
2. `整体格局`
3. `内在结构`
4. `为什么这么判断`
5. `下一步问题`

### 区块 1：Hook

内容要求：

- 只放 1 句话
- 直接命中 tension
- 不使用绝对断言

示例方向：

- 你现在最累的地方，可能不是事情太多，而是你一直在替所有后果做提前防守。

### 区块 2：整体格局

内容要求：

- 解释这张脸先给人的感觉
- 重点是“整体结构”，不是局部标签

示例表达方向：

- 你给人的感觉更像稳住局面的人，不轻易把波动放在表面，但这种稳里其实包着很强的自我保护。

### 区块 3：内在结构

内容组成：

- `五官功能倾向`
- `三停能量分布`
- `重点宫位提示`

用户看到的不是术语，而是解释：

- 你更偏先判断再行动，还是先承压再消化
- 你更容易在关系里先收，还是在现实里先扛
- 当前更被激活的是关系、选择、安全感还是自我价值

### 区块 4：为什么这么判断

交互形式：

- 默认半展开
- 点开后完整展开

收起态：

- 2-3 句压缩摘要

展开态固定顺序：

1. `我看到了什么`
2. `这些位置通常指向什么`
3. `为什么会落到你现在的 tension`

内容约束：

- 不展示规则 ID
- 不展示内部 JSON
- 允许轻量提到：
  - 眉眼这一组
  - 山根/印堂这一组
  - 鼻部/中庭这一组
- 不做百科式知识铺陈

### 区块 5：下一步问题

目标：

- 把面相推理自然接到现实处境

示例方向：

- 如果这句有点像，你最近更卡在关系、工作，还是自己心里的拉扯？

### 页面底部操作

- 主 CTA：`继续，让它更贴近我现在的处境`
- 次 CTA：`换一张照片重看`

### 页面状态

- `partial_readme`
- `full_readme`
- `readme_refresh`

对 `partial_readme`：

- 仍保留 `为什么这么判断`
- 但只展示：
  - 第一印象
  - 一个主 tension
  - 一个后续问题

## 5.6 Context Onboarding

### 目标

- 用最少输入把刚刚的分析接到现实处境

### 结构

- 单题分步卡片
- 共 4 题以内
- 每题可跳过

### 顶部说明

- `只需要一点点现实处境，我才能把刚才那段判断说得更贴近你`

### 问题顺序

1. `你现在最担心失去的是什么？`
2. `你最想推进的一件事是什么？`
3. `最近最牵动你情绪的是谁？`
4. `你希望我先更关注关系、工作，还是内在状态？`

### 每题交互

- 3-5 个快捷选项
- 1 个自由输入
- `跳过`
- `继续`

### 完成态

- 不回首页
- 直接进入 `Today First Ready`

## 5.7 Today

### 目标

- 成为回访主入口

### 首屏结构

1. 今日主线
2. 今天最容易失衡的点
3. 一个小行动
4. 一个跟进问题

### 页面状态

#### `locked`

- 文案：先完成第一次画像，Today 才会开始真正围绕你生成
- CTA：`去完成 Read Me`

#### `loading`

- 文案：今天的内容还在整理中
- 操作：`刷新`

#### `ready`

- 展示完整内容

#### `first_ready`

- 这是 `Context Onboarding` 完成后的首次进入态
- 顶部增加一条承接说明：
  - `我会先沿着你刚才提到的这条主线陪你看下去`
- 页面底部增加 CTA：
  - 主 CTA：`围绕这件事继续问`
  - 次 CTA：`先收下今天这条提醒`

## 5.8 Ask

### 目标

- 预留线程式对话入口

### 首屏结构

1. 当前线程标题
2. 历史摘要
3. 输入框
4. 最新回答区
5. 下一步问题建议

### 页面状态

#### `locked`

- 文案：先完成第一次画像，Ask 才会沿着你的主线继续
- CTA：`去完成 Read Me`

#### `bootstrapping`

- 文案：正在沿着你现在最明显的主线，整理第一个问题入口

#### `ready`

- 显示线程

#### `awaiting_response`

- 文案：正在沿着这个主题继续整理
- 用户输入必须保留在页面中

## 5.9 My Story

### 目标

- 让用户感到“它真的在记得我”

### 首屏结构

1. 当前主 tension
2. 当前主线程
3. 最近 7 天摘要
4. `Memory` 入口
5. `Weekly Recap` 占位区

### 页面状态

#### `locked`

- 文案：先完成第一次画像，My Story 才会开始形成你的连续记录
- CTA：`去完成 Read Me`

#### `empty`

- 文案：你的故事刚开始，随着你继续使用，这里会越来越像你

#### `ready`

- 展示摘要与入口

## 5.10 Memory

### 目标

- 提供首版最小 `Memory Review`

### 页面结构

1. 关键人物
2. 当前关注主题
3. 已确认记忆
4. 每条记忆的操作
   - `修改`
   - `不要再提`
   - `删除`

### 交互规则

- 被标记 `不要再提` 的记忆在 UI 上保留但显示为已压制
- 被删除的记忆从主列表移除

## 6. 关键交互流

## 6.1 首次关键路径

`Home -> Capture/Upload -> Quality Check -> Analyzing -> Read Me -> Context Onboarding -> Today`

规则：

- 每一步都只有一个主 CTA
- 每一步都告诉用户“为什么要做这一步”
- 第一次价值感必须出现在 `Read Me`

## 6.2 Read Me 内部顺序

`Hook -> 整体格局 -> 内在结构 -> 为什么这么判断 -> 下一步问题`

规则：

- 先命中，再解释
- 解释服务“为什么我会这样”
- 不做“部位百科”

## 6.3 异常路径

### 图片质量失败

`Capture / Upload -> Quality Fail -> Retry`

### 超时

`Analyzing -> Timeout -> Continue Waiting / Retry`

### 降级

`Analyzing -> Partial Result -> 简版 Read Me`

规则：

- 异常路径也必须保持被认真对待的语气
- 不能回到纯技术提示

## 6.4 首次后回访路径

### 次日

`App Launch -> Today`

### 围绕主题继续追问

`Today -> Ask`

### 回看主线与记忆

`Today / Ask -> My Story -> Memory`

## 7. 组件建议

首版建议提炼以下通用组件：

- `HeroHeader`
- `PrimaryCTAButton`
- `SecondaryTextButton`
- `PhotoGuidanceCard`
- `ProgressStageList`
- `ReadMeSectionCard`
- `ExpandableWhyCard`
- `OnboardingQuestionCard`
- `ShellEmptyStateCard`
- `MemoryItemRow`

组件要求：

- 所有主 CTA 样式统一
- 所有空状态统一使用“当前不可用 + 原因 + 去哪继续”的结构
- `ExpandableWhyCard` 是首版核心组件，必须可复用于：
  - `Read Me`
  - 简版 `Read Me`
  - 后续 `Weekly Recap` 的 explain 区

## 8. 埋点与验收

## 8.1 页面埋点

必须记录：

- Home 主 CTA 点击率
- 图片提交率
- 质量门失败原因分布
- Analyzing 超时率
- Read Me 完成率
- `为什么这么判断` 展开率
- Context Onboarding 完成率
- Today 首次打开率
- Ask 首次进入率

## 8.2 页面验收标准

- 用户首屏能理解这不是面部识别功能
- `Read Me` 首屏先打到 tension，而不是先展示知识点
- `为什么这么判断` 能被普通用户读懂
- 首次路径中每个状态都只有一个清晰主动作
- 失败回退足够具体
- `Today / Ask / My Story` 的壳层已经明确，不影响后续版本接入

## 9. 实施顺序

按工程实现顺序，页面应这样落地：

1. `Home`
2. `Capture / Upload`
3. `Quality Fail`
4. `Analyzing`
5. `Read Me`
6. `Context Onboarding`
7. `Today` 壳层
8. `Ask` 壳层
9. `My Story` + `Memory` 壳层

原因：

- 前 6 个页面直接服务 `first aha`
- 后 3 个页面先作为导航壳和空状态，避免后续重做导航结构
