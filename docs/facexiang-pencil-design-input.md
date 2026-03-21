# FaceXiang Pencil 设计稿生成材料

## 1. 使用方式

本文件是给 `Pencil` 这类 AI 设计生成工具直接使用的材料。

建议使用方式：

1. 先使用 `全局主 Prompt` 生成整体视觉方向和页面框架
2. 再按 `批次 Prompt` 分批生成页面
3. 最后用 `页面文案素材包` 替换或校正文案

建议：

- 主提示词优先使用英文，生成稳定性通常更好
- 页面内文案保留中文
- 每次生成控制在 `4-6 个 screen`，避免模型丢失信息层级

---

## 2. 全局主 Prompt

下面这段可直接复制给 `Pencil`：

```text
Design an iOS mobile app UI for a product called FaceXiang.

Product definition:
FaceXiang is not a face recognition tool and not a generic astrology app. It is an Eastern AI advisor that starts from a selfie, uses physiognomy-inspired structured reasoning, and explains why the user is currently stuck in a certain emotional or life tension.

Core product feeling:
- private
- calm
- trustworthy
- intimate
- slightly ritualistic
- contemporary Eastern aesthetic
- not mystical in a cheap way
- not purple galaxy astrology style

Design style:
- iOS native feeling
- editorial, elegant, quiet
- large white space
- strong information hierarchy
- warm paper-like light background
- deep charcoal text
- accent color should be deep teal or dark jade
- secondary accent can be muted bronze
- avoid purple, neon, cyber, tarot, crystal ball aesthetics
- do not use starry space backgrounds

Typography:
- title style should feel refined and slightly Eastern, similar to New York serif
- body text should feel highly readable, like SF Pro / PingFang SC

Important product rule:
The UI must make users feel:
1. this is not a photo analysis gadget
2. this is a thoughtful advisor observing them
3. the app explains “why you are like this now,” not “what your face looks like”

Layout principles:
- one clear primary CTA per screen
- secondary CTA only for fallback or skip
- the Read Me screen must first hit emotionally, then explain
- all empty, loading, and failure states must still feel warm and productized

Navigation:
- first-time flow before tabs:
  Home -> Capture / Upload -> Quality Fail or Analyzing -> Read Me -> Context Onboarding -> Today First Ready
- after first aha, show 4-tab navigation:
  Read Me / Today / Ask / My Story

Core screens that need to exist:
- Home
- Capture
- Photo Preview
- Camera Permission Denied Sheet
- Quality Fail
- Analyzing
- Analyzing Timeout
- Analyzing Failed
- Partial Read Me
- Full Read Me
- Context Onboarding
- Today First Ready
- Today Ready
- Today Loading
- Today Locked
- Ask Ready
- Ask Bootstrapping
- Ask Awaiting Response
- Ask Locked
- My Story Ready
- My Story Empty
- My Story Locked
- Memory
- Settings
- Delete Confirmation

Screen-specific product requirements:
- Home should feel like a calm premium advisor entry page, not an upload tool
- Capture should make the photo action feel simple and guided
- Quality Fail should explain one clear reason and how to fix it
- Analyzing should feel like a thoughtful observation ritual, not a spinner page
- Read Me should feel like a deeply personal interpretation, not a report
- Why section on Read Me must be expandable and readable
- Context Onboarding should feel light, progressive, not like a long form
- Today should feel like a private daily reflection, not a horoscope card
- Ask should feel threaded and contextual, not like a generic AI chat
- My Story should feel like an evolving private record of the relationship
- Memory should feel editable and trustworthy

Please generate a coherent design system and screen set for this iOS app.
Use Chinese text in the UI.
```

---

## 3. 批次 Prompt

## 3.1 批次 A：先出 First Session 高保真稿

```text
Generate high-fidelity iOS screens for the first-time core flow of FaceXiang.

Use the style defined earlier:
- contemporary Eastern advisor
- light warm background
- dark charcoal typography
- deep teal accent
- refined serif headings + modern sans-serif body
- calm, private, elegant

Generate these screens:
1. Home
2. Capture
3. Photo Preview
4. Camera Permission Denied Bottom Sheet
5. Quality Fail
6. Analyzing
7. Analyzing Timeout
8. Full Read Me
9. Partial Read Me
10. Context Onboarding
11. Today First Ready

Critical layout rules:
- one primary CTA per screen
- no crowded UI
- Read Me must start with an emotionally strong hook
- Why card must be visible and expandable
- Context Onboarding must feel light and progressive

Use Chinese copy.
Show realistic mobile layouts with native iOS spacing and components.
```

## 3.2 批次 B：再出 Tab 壳层和核心状态稿

```text
Generate the main app shell and core state screens for FaceXiang after the user has completed the first Read Me flow.

Create these iOS screens:
1. Main Tab Shell
2. Today Ready
3. Today Loading
4. Today Locked
5. Ask Ready
6. Ask Bootstrapping
7. Ask Awaiting Response
8. Ask Locked
9. My Story Ready
10. My Story Empty
11. My Story Locked

Important rules:
- tab bar labels: Read Me / Today / Ask / My Story
- Today should feel like a private daily reflection, not a horoscope card
- Ask should feel like a threaded advisory conversation, not a generic AI chat
- My Story should feel like a personal evolving story archive
- locked states should gently route users back to Read Me, not feel like hard blocks

Use Chinese copy.
Maintain the same design system and tone as the first flow.
```

## 3.3 批次 C：补 Settings、Memory 和危险操作

```text
Generate the support screens and component-oriented pages for FaceXiang.

Create these iOS screens:
1. Memory
2. Memory item states (normal / suppressed)
3. Settings
4. Delete photo confirmation
5. Delete memory confirmation
6. Delete account confirmation

Design goals:
- Memory must feel editable, trustworthy, and structured
- Settings must feel clean and privacy-conscious
- Destructive actions must be clear, calm, and not aggressive

Use Chinese copy.
Keep the visual system consistent with the previous screens.
```

---

## 4. 页面文案素材包

以下文案可直接提供给 `Pencil` 作为页面内容参考。

## 4.1 Home

### 标题

从你的脸开始，看你现在真正卡住的那根线

### 说明

它会先观察你的整体格局、五官功能、三停与重点宫位，再给你一版更像“在解释你为什么会这样”的画像。

### 主按钮

开始看我现在的状态

### 次按钮

从相册选择

### 信任区

图片仅用于生成画像，可删除  
内容为文化解读与方向参考，不替代专业意见

### 轻量示意

它会怎么看你

- 整体格局
- 当前更容易失衡的模式
- 为什么会落到这个 tension

## 4.2 Capture / Photo Preview

### 指引文案

请使用正脸、自然光、单人、无遮挡的照片

### 主按钮

使用这张照片

### 次按钮

重新拍照  
重新选择

## 4.3 Camera Permission Denied

### 标题

需要相机权限才能直接拍照

### 说明

如果你暂时不想开启，也可以直接从相册选择一张照片。

### 按钮

去相册选择  
打开系统设置

## 4.4 Quality Fail

### 通用按钮

重新拍照  
从相册选择另一张

### 失败文案 1

标题：没有检测到清晰正脸  
建议：请正对镜头，保证脸部完整进入画面

### 失败文案 2

标题：这张照片里有多人  
建议：请换成只有你一个人的正脸照片

### 失败文案 3

标题：光线太暗，额头和五官不够清楚  
建议：请在自然光下重拍，避免逆光

### 失败文案 4

标题：遮挡过多，无法判断关键部位  
建议：请移开头发、口罩或墨镜后再试

### 失败文案 5

标题：角度偏侧，无法进入完整分析  
建议：请正对镜头，避免侧脸和低头

### 失败文案 6

标题：照片偏糊，关键细节不够清楚  
建议：请换一张更清晰的照片

## 4.5 Analyzing

### 阶段文案

正在检查照片质量  
正在观察你的整体格局与关键部位  
正在整理你的第一版画像

### 超时文案

还差一点，我们正在把观察结果整理成更像你的表达

### 超时按钮

继续等待  
重新尝试

### 失败文案

标题：这次没能顺利整理出完整画像  
说明：不是你的问题，可能是网络或分析过程被打断了

### 失败按钮

再试一次  
换一张照片

### 降级入口

先给你一个简版观察  
完整版本还在整理，但这部分已经足够开始判断

按钮：先看简版结果

## 4.6 Full Read Me

### Hook 示例

你现在最累的地方，可能不是事情太多，而是你一直在替所有后果做提前防守。

### 整体格局示例

你给人的感觉更像稳住局面的人，不轻易把波动放在表面，但这种稳里其实包着很强的自我保护。

### 内在结构示例

你更像是先判断、先收住自己，再决定要不要往前走。你对关系和现实都不迟钝，但真正让你疲惫的不是看不见，而是你总在心里先把代价算了一遍。

### Why 收起态示例

我更明显地看到了你在眉眼和中庭这一组信号上的紧绷感，这通常会让一个人看起来稳，但内里并不轻松。  
它不是简单的敏感，而更像一种习惯性的提前防守。  
所以你现在的 tension，更像卡在“怕选错之后没人接住后果”。

### Why 展开态标题

我看到了什么  
这些位置通常指向什么  
为什么会落到你现在的 tension

### 下一步问题

如果这句有点像，你最近更卡在关系、工作，还是自己心里的拉扯？

### 底部按钮

继续，让它更贴近我现在的处境  
换一张照片重看

## 4.7 Partial Read Me

### 标题建议

先给你一个简版观察

### 结构

- 第一印象
- 一个主 tension
- 一个简短 why
- 一个下一步问题

## 4.8 Context Onboarding

### 顶部说明

只需要一点点现实处境，我才能把刚才那段判断说得更贴近你

### 问题 1

你现在最担心失去的是什么？

选项示例：

- 关系里的位置
- 做决定的主动权
- 工作上的稳定感
- 自己的节奏

### 问题 2

你最想推进的一件事是什么？

选项示例：

- 一段关系
- 一个决定
- 工作变化
- 内在状态

### 问题 3

最近最牵动你情绪的是谁？

选项示例：

- 伴侣 / 喜欢的人
- 前任
- 家人
- 同事 / 上级
- 我自己

### 问题 4

你希望我先更关注关系、工作，还是内在状态？

选项示例：

- 关系
- 工作
- 内在状态

### 按钮

继续  
跳过

## 4.9 Today First Ready

### 承接文案

我会先沿着你刚才提到的这条主线陪你看下去

### 今日主线示例

今天你最容易失衡的，不是事情本身，而是你会下意识想先把所有风险都扛在自己心里。

### 小行动示例

先别急着做最后决定，先把你真正怕失去的那一项写清楚。

### 跟进问题示例

如果你愿意，我们可以继续沿着“为什么你总会先防守”往下看一层。

### 按钮

围绕这件事继续问  
先收下今天这条提醒

## 4.10 Today Ready

### 模块标题

今日主线  
今天最容易失衡的点  
一个小行动  
一个跟进问题

## 4.11 Today Loading

### 文案

今天的内容还在整理中

### 按钮

刷新

## 4.12 Today Locked

### 文案

先完成第一次画像，Today 才会开始真正围绕你生成。

### 按钮

去完成 Read Me

## 4.13 Ask Ready

### 线程标题示例

你在关系里的提前防守

### 历史摘要示例

我们刚刚提到，你不是不想往前走，而是很怕选错之后没有人接住后果。

### 输入框占位

把你现在最想继续问的一句写下来

### 下一步问题示例

你更怕的是被拒绝，还是怕关系失控之后自己撑不住？

## 4.14 Ask Bootstrapping

### 文案

正在沿着你现在最明显的主线，整理第一个问题入口

## 4.15 Ask Awaiting Response

### 文案

正在沿着这个主题继续整理

## 4.16 Ask Locked

### 文案

先完成第一次画像，Ask 才会沿着你的主线继续。

### 按钮

去完成 Read Me

## 4.17 My Story Ready

### 模块标题

当前主 tension  
当前主线程  
最近 7 天  
Memory  
Weekly Recap

## 4.18 My Story Empty

### 文案

你的故事刚开始，随着你继续使用，这里会越来越像你。

## 4.19 My Story Locked

### 文案

先完成第一次画像，My Story 才会开始形成你的连续记录。

### 按钮

去完成 Read Me

## 4.20 Memory

### 模块标题

关键人物  
当前关注主题  
已确认记忆

### 条目操作

修改  
不要再提  
删除

### 已压制状态

这条记忆已被压制，之后不会再主动提起。

## 4.21 Settings

### 模块标题

图片管理  
记忆管理  
账号与数据

### 操作文案

删除图片  
删除记忆  
删除账号

## 4.22 Delete Confirmation

### 删除图片

删除这张图片后，它将不再用于你的画像记录。

### 删除记忆

删除这条记忆后，后续内容将不再引用它。

### 删除账号

删除账号后，你的画像、线程、记忆和摘要都会被清除。

### 按钮

取消  
确认删除

---

## 5. 组件与布局要求

以下要求也建议直接提供给 `Pencil`：

```text
Component requirements:
- Use a refined card system, not identical generic cards everywhere
- Primary CTA buttons must have a strong consistent style
- Secondary buttons should feel lighter and quieter
- The expandable Why card is a core component and should feel special but not flashy
- Use chips for onboarding options
- Use gentle dividers and spacing instead of heavy borders
- Tab bar should be calm, clear, and premium

Layout requirements:
- mobile iPhone screen ratio
- generous spacing
- clear vertical rhythm
- content-first design
- avoid overcrowding
- each screen should have one visual focal point
- preserve strong readability for Chinese text
```

---

## 6. 状态稿清单

如果 `Pencil` 支持批量 frame 输出，请确保至少生成这些状态：

- Home `first_open`
- Home `returning_with_readme`
- Capture `camera_ready`
- Photo Preview
- Camera Permission Denied
- Quality Fail
- Analyzing `normal`
- Analyzing `timeout`
- Analyzing `failed`
- Read Me `full`
- Read Me `partial`
- Why `collapsed`
- Why `expanded`
- Context Onboarding `question_active`
- Today `first_ready`
- Today `ready`
- Today `loading`
- Today `locked`
- Ask `ready`
- Ask `bootstrapping`
- Ask `awaiting_response`
- Ask `locked`
- My Story `ready`
- My Story `empty`
- My Story `locked`
- Memory `normal`
- Memory `suppressed`
- Settings
- Delete Confirmation

---

## 7. 生成后的人工检查清单

生成后请人工检查：

- 有没有被做成紫色宇宙星座风
- Home 看起来是不是像上传工具
- Read Me 首屏是不是先展示了命中感而不是知识点
- Why 卡片是不是既可见又不喧宾夺主
- Today 看起来是不是像 horoscope
- Ask 看起来是不是像普通聊天机器人
- My Story 看起来是不是像数据后台
- 所有错误态是不是仍然有产品感

---

## 8. 最终建议

如果只生成一轮，优先生成：

1. `批次 A`
2. `批次 B`
3. `组件稿`

如果生成效果一般，不要继续扩大页面数量，先在 `Home / Read Me / Why / Today First Ready` 这 4 个关键画面上迭代，直到产品气质对为止。
