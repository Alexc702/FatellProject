# FaceXiang iOS v1 UI 设计稿说明书

## 1. 文档目标

本文件用于指导 UI 设计师基于 [facexiang-ios-detailed-prd.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-detailed-prd.md) 输出首版 iOS 设计稿。

本文件回答 4 个问题：

- 这套产品在视觉上应该长成什么气质
- 哪些页面和状态必须出稿
- 每个页面的布局重点和信息层级是什么
- 组件、交互和状态稿需要画到什么程度

本文件不是：

- 工程实现文档
- Prompt 文档
- 品牌手册

如需直接用 AI 设计工具生成设计稿，可使用：

- [facexiang-pencil-design-input.md](/Users/lulu/Codex/FatellProject/docs/facexiang-pencil-design-input.md)

## 2. 设计目标

## 2.1 设计要服务的产品感受

用户在打开 App 到看完 `Read Me` 的过程中，界面应该帮助用户形成以下感受：

- 这不是一个拍照识别工具
- 这不是一份长报告
- 这是一个在认真观察我、并试图解释我为什么会这样的人

## 2.2 视觉气质关键词

首版 UI 必须同时满足以下气质：

- 私密
- 克制
- 可信
- 有仪式感
- 有东方语义
- 不神棍
- 不像泛星座 App

## 2.3 明确不要做成什么样

不要做成：

- 蓝紫色宇宙泛滥的 astrology 模板
- 霓虹赛博占卜风
- 廉价塔罗风
- 过度暗黑、压迫感强的神秘学界面
- 大量堆装饰、缺少内容层次的“算命软件”

## 3. 视觉方向

## 3.1 推荐视觉方向

建议首版采用：

`当代东方顾问 + 私密咨询室 + 轻仪式感`

不是：

`星空神婆`

视觉上更像：

- 一间安静、可信、略带仪式感的私人咨询空间
- 现代 iOS app 的清晰结构
- 东方语义通过色彩、排版、细节和留白体现，而不是靠符号堆砌

## 3.2 色彩建议

建议定义一组明确的基础色：

- 主背景：温暖米白 / 纸感白
- 主文字：墨黑 / 深炭灰
- 主强调色：深青 / 墨绿 / 靛青 选其一
- 次强调色：低饱和铜金 / 砂金
- 风险色：克制的朱砂红
- 辅助层：浅灰青 / 暖灰

原则：

- 不以紫色为主
- 不默认深色模式审美
- 用少量强调色建立仪式感，而不是满屏渐变

## 3.3 字体建议

建议采用双字体层级：

- 标题：有东方书卷感的衬线系
- 正文：现代无衬线，清晰易读

iOS 设计稿建议参考：

- 标题：`New York` 或接近宋体气质的 serif
- 正文：`SF Pro` / `PingFang SC`

原则：

- 标题可以更有性格
- 正文必须高度可读
- 不使用花哨装饰字体

## 3.4 质感与图形语言

建议使用：

- 大留白
- 细线分隔
- 层级明确的卡片
- 柔和的光晕或纸感底纹
- 局部几何线条提示“结构化观察”

建议避免：

- 大面积星空图
- 水晶球、塔罗牌、过多符咒符号
- 直接使用 AI 生成美女头像做主视觉

## 4. 布局原则

## 4.1 首屏只保留一个主动作

所有关键页面都应有一个明显主 CTA。  
次 CTA 只承担回退、修正或跳过。

## 4.2 信息层级必须非常清楚

页面必须始终保持：

1. 当前最重要的信息
2. 当前用户应该做的唯一动作
3. 次要解释和辅助信息

不要把说明、状态、CTA、装饰都堆在同一视觉层。

## 4.3 `Read Me` 必须先“命中”，再“解释”

界面布局必须帮助这个顺序成立：

- 先看到一句打到 tension 的话
- 再看到整体格局和内在结构
- 最后看为什么这么判断

不要让“为什么这么判断”抢到首屏主位，但也不能让它太隐蔽。

## 4.4 空状态和错误状态也要有产品感

所有空状态、锁定态、失败态都不能只是灰字提示。  
它们也要维持“顾问在陪你往下走”的产品感。

## 5. 设计稿输出范围

## 5.1 必须出高保真稿的页面

- `Home`
- `Capture`
- `Photo Preview`
- `Camera Permission Denied Sheet`
- `Quality Fail`
- `Analyzing`
- `Analyzing Timeout`
- `Analyzing Failed`
- `Partial Read Me`
- `Read Me Full`
- `Context Onboarding`
- `Today First Ready`

## 5.2 必须出结构稿或中保真稿的页面

- `Today Locked`
- `Today Loading`
- `Today Ready`
- `Ask Locked`
- `Ask Bootstrapping`
- `Ask Ready`
- `Ask Awaiting Response`
- `My Story Locked`
- `My Story Empty`
- `My Story Ready`
- `Memory`
- `Settings`
- `Delete Data Flow`

## 5.3 必须出组件稿的组件

- 主按钮
- 次按钮
- 底部 tab bar
- 拍照指引卡片
- 分析进度组件
- `Read Me` 区块卡片
- `Why` 可展开卡片
- Onboarding 选项 chip
- 文本输入框
- 空状态卡片
- 记忆条目卡片
- 删除确认弹层

## 6. 页面级 UI 设计说明

## 6.1 Home

### 页面角色

- 品牌入口
- first aha 起点
- 信任建立页

### 画面重点

- Hero 区必须占首屏最大视觉权重
- 主 CTA 要足够明确
- 信任区不能喧宾夺主，但必须可见

### 建议布局

- 顶部：品牌名 + 极简副标
- 中上：主标题
- 中部：一段短说明
- 中下：主 CTA、次 CTA
- 底部：信任区 + 轻量示意区

### 设计重点

- 让用户觉得这是一个“顾问入口”
- 而不是“上传图片功能页”

## 6.2 Capture

### 页面角色

- 首次动作页
- 从“理解产品”切到“开始被观察”

### 画面重点

- 拍摄区域
- 拍摄指引
- 确认按钮

### 建议布局

- 顶部：返回
- 中部：相机取景或预览图
- 下方：4 条拍摄指引
- 底部：主 CTA + 次 CTA

### 设计重点

- 让用户感到动作简单、清楚
- 让照片提交前有明确确认感

## 6.3 Camera Permission Denied Sheet

### 页面角色

- 权限失败回退

### 画面重点

- 明确说明为什么需要相机
- 给出两个直接动作

### 必须包含

- `去相册选择`
- `打开系统设置`

## 6.4 Quality Fail

### 页面角色

- 错误修正页

### 画面重点

- 失败原因
- 一条修复建议
- 一个主动作

### 建议布局

- 中部偏上：失败标题
- 中部：说明 + 建议
- 底部：重试按钮组

### 设计重点

- 看起来像“认真帮你修正”，不是技术错误

## 6.5 Analyzing

### 页面角色

- 等待页
- 仪式建立页

### 画面重点

- 三段式阶段进度
- 柔和而有节奏的 loading 表达
- 为什么需要时间的说明

### 建议布局

- 中上：标题或一句引导语
- 中部：进度组件
- 中下：辅助说明

### 设计重点

- 不要做成普通 loading spinner 页面
- 让用户感觉系统真的在观察、整理、生成

### 设计稿必须覆盖的状态

- 正常 analyzing
- timeout
- failed
- partial ready

## 6.6 Read Me Full

### 页面角色

- 核心价值页
- first aha 页面

### 画面重点

- `Hook` 必须是首屏最强视觉锚点
- `整体格局` 是第二层重点
- `为什么这么判断` 必须看得见但不喧宾夺主

### 建议布局

- 顶部：页面标题或极简导航
- 首屏：
  - Hook 大字句
  - 整体格局卡片
- 首屏下：
  - 内在结构卡片
  - 为什么这么判断卡片
  - 下一步问题卡片
- 底部：主 CTA + 次 CTA

### 设计重点

- 这页不要像报告页
- 更像一段被认真读出来的个人观察

### Why 卡片要求

- 收起态也要可读
- 展开态信息层级要很清楚
- 展开动画要有节奏，但不能花哨

## 6.7 Partial Read Me

### 页面角色

- 降级结果页

### 画面重点

- 虽是简版，但仍要有命中感和解释感

### 必须包含

- 第一印象
- 一个主 tension
- 一个简短 why
- 一个下一步问题

## 6.8 Context Onboarding

### 页面角色

- 从分析进入关系

### 画面重点

- 一次只看一题
- 快捷选项优先
- 轻、短、没有表单感

### 建议布局

- 顶部：说明 + 进度
- 中部：问题
- 中下：选项 chip
- 下部：自由输入
- 底部：继续 / 跳过

### 设计重点

- 让用户觉得这是“为了更懂我”
- 而不是“在收集资料”

## 6.9 Today First Ready

### 页面角色

- 首次承接页
- 从 onboarding 切入连续关系

### 画面重点

- 承接文案
- 今日主线
- 一个可继续追问的 CTA

### 建议布局

- 顶部：承接说明
- 中部：今日主线卡片
- 下部：今日提醒卡片
- 底部：`围绕这件事继续问` / `先收下今天这条提醒`

### 设计重点

- 要让用户感到“产品已经沿着我刚说的这条线继续了”

## 6.10 Today Ready / Loading / Locked

### Today Ready

- 要更像每天回来的“私人提醒”
- 不要像 horoscope 卡片

### Today Loading

- 不能空白
- 要有“正在整理中”的承接感

### Today Locked

- 要友好地把用户带回 `Read Me`
- 不要像权限拦截页

## 6.11 Ask Ready / Bootstrapping / Locked

### Ask Ready

- 中心是线程感
- 标题、历史摘要、当前输入框必须层次清晰

### Ask Bootstrapping

- 要表达“正在沿着你当前主线整理问题入口”

### Ask Locked

- 应提示先完成第一次画像

### Ask Awaiting Response

- 用户刚发出的内容必须保留在画面中
- loading 要表达“继续整理这条主线”

## 6.12 My Story

### 页面角色

- 连续关系总览页

### 画面重点

- 当前主 tension
- 当前主线程
- 最近 7 天摘要
- Memory 入口

### 设计重点

- 不是数据后台
- 更像“我和它之间的记录”

## 6.13 Memory

### 页面角色

- 记忆审阅与纠错页

### 画面重点

- 条目清晰
- 操作明确
- 编辑和压制要低风险

### 每条记忆要能体现

- 内容
- 来源可信度感
- 当前状态
- 可执行操作

## 6.14 Settings / Delete Data Flow

### 页面角色

- 隐私与控制页

### 设计重点

- 删除能力必须明显
- 危险操作必须清楚但不惊悚

### 删除确认弹层要求

- 说明删除对象
- 说明后果
- 主次按钮区分明确

## 7. 组件设计说明

## 7.1 Button 体系

必须定义：

- 主 CTA 按钮
- 次 CTA 按钮
- 文本按钮
- 危险操作按钮

要求：

- 主 CTA 在所有关键流程中视觉语言统一
- 危险操作与普通次按钮明显区分

## 7.2 Card 体系

必须定义：

- 内容卡片
- 状态卡片
- Empty state 卡片
- Why 卡片
- Memory item 卡片

要求：

- 不同卡片通过层级、留白和边框/阴影区分角色
- 卡片不能全都长得一样

## 7.3 Chip 体系

必须定义：

- 单选 chip
- 已选 chip
- 可编辑 tag
- 状态 tag

## 7.4 Progress 体系

必须定义：

- 三段式 analyzing 进度
- Onboarding 进度

## 7.5 Tab Bar

必须定义：

- 4 个 tab 的 icon 与 label
- 激活态
- 未激活态

要求：

- 不花哨
- 清楚、稳定、可信

## 8. 交互与动效建议

## 8.1 动效原则

- 少而准
- 服务状态理解
- 不做花哨微交互

## 8.2 必须有的动效

- Home 到 Capture 的过渡
- Analyzing 的阶段变化
- Why 卡片展开/收起
- Onboarding 题卡切换
- Today First Ready 的承接出现

## 8.3 不建议有的动效

- 大面积粒子星空
- 漫长闪烁光效
- 夸张翻牌
- 强戏剧性的神秘仪式动画

## 9. 状态稿清单

UI 稿必须覆盖以下状态：

- Home `first_open`
- Home `returning_with_readme`
- Capture `camera_ready`
- Capture `photo_preview`
- Capture `camera_permission_denied`
- Quality Fail
- Analyzing `normal`
- Analyzing `timeout`
- Analyzing `failed`
- Analyzing `partial_ready`
- Read Me `full`
- Read Me `partial`
- Why `collapsed`
- Why `expanded`
- Context Onboarding `question_active`
- Context Onboarding `completed`
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
- Memory `list`
- Memory `suppressed`
- Settings
- Delete confirmation

## 10. 设计验收标准

设计稿完成后，应满足：

- 首屏明确传达“顾问型 AI”而不是“识别功能”
- `Read Me` 首屏先打到 tension，再进入解释
- Why 卡片可读且层级清楚
- 首次路径的主 CTA 明确，不让用户犹豫
- 异常状态有产品感，不像系统报错
- `Today / Ask / My Story` 的结构可以直接承接下一版本
- 整套视觉有统一气质，不像拼装页

## 11. 设计交付物清单

设计师最终应交付：

- 1 份风格方向页
- 1 份颜色与字体说明页
- 1 份组件页
- 1 套 first session 高保真稿
- 1 套 tab 壳层与关键状态稿
- 1 套弹层与删除流程稿
- 1 份页面流总览图

## 12. 结论

这份 UI 设计稿说明书的核心，不是让设计做出一套“更像玄学 app”的界面，而是让界面真正支撑这条产品逻辑：

`从脸进入 -> 被说中 -> 感到被理解 -> 愿意继续说 -> 形成关系`

如果设计稿无法强化这条链路，就算好看，也不是合格的首版设计。

## 13. 当前 `facexiang.pen` 评审结论

整体判断：

- `方向部分符合预期，但还不能直接定版`

目前这版设计稿的优点：

- 页面覆盖度是够的，关键页面和状态基本都出了
- 整体语气大方向偏安静、偏私密，没有明显做成廉价神秘学产品
- `Analyzing / Read Me / Ask / My Story` 已经开始形成“连续关系”而不是单页工具的感觉

目前最关键的问题：

### 13.1 产品定位仍有工具感和泛观察感

典型问题：

- Home 仍在说“面部观察”
- 主 CTA 仍是“开始拍摄”

这会把用户带回：

- 上传工具
- 看脸解读

而不是：

- 从脸进入的顾问型 AI
- 解释“为什么你会这样”

### 13.2 首次主路径被改偏

当前稿里：

- `Read Me` 之后直接给了 `进入今日`
- `Today First Ready` 也偏“先开始今日观照”

但正确主路径应是：

`Read Me -> Context Onboarding -> Today First Ready`

也就是说，`Read Me` 之后不该直接跳 `Today`，而要先承接现实处境。

### 13.3 Quality Fail 和 Analyzing 还不够具体

问题表现：

- Quality Fail 用了“还不够清定”这种偏虚的表达
- 一个失败页里堆了多个失败原因
- Analyzing 给了 `预计还需 18 秒` 和 `稍后提醒我`

这不符合首版要求：

- 失败要具体到一个主因
- 等待要让用户继续留在当前流程里
- 不能把首个 aha 引导成“稍后再说”

### 13.4 `Read Me` 的页面结构还不够对

当前优点：

- 已经有命中感
- 已经有 why 区域

但还不够的地方：

- `整体格局 -> 内在结构 -> 为什么这么判断 -> 下一步问题` 的层次不够完整
- `进入今日` 太早
- `保存这次解释` 会把页面拉回“报告工具”

### 13.5 导航与语言系统不统一

问题表现：

- tab 使用 `TODAY / ASK / READ ME` 英文大写
- `My Story` 没有在 tab 文案里稳定出现
- 整体 UI 是中文，但底部导航和部分结构名是英文大写

这会让产品看起来像：

- 临时概念稿
- 信息架构未收敛

### 13.6 My Story 与 Settings 的结构有偏差

`My Story` 当前更像时间线页，缺：

- 当前主 tension
- 当前主线程
- Memory 入口的突出层级

`Settings` 当前把“导出我的数据”做得过重，偏离了 v1 核心：

- 隐私说明
- 删除图片
- 删除记忆
- 删除账号

### 13.7 字体系统不符合预期

当前文件里几乎全量使用 `Microsoft YaHei`。  
这会让整体视觉更像：

- 普通中文后台
- 文档排版

而不是：

- 当代东方顾问
- 安静、可信、有一点书卷感的 iOS 产品

## 14. 给 Pencil 的修订 Prompt

下面这段是基于当前 `facexiang.pen` 继续修改的 prompt。  
目标不是重画一套新稿，而是在保留当前页面覆盖度和安静气质的前提下，把产品逻辑和视觉系统修正到位。

```text
Revise the current FaceXiang iOS design based on the existing draft, instead of redesigning from scratch.

Keep what is already working:
- the calm, quiet, private mood
- the broad screen coverage
- the idea of FaceXiang as a reflective advisor rather than a playful app

But correct the design so it matches the product more precisely.

Core product positioning:
FaceXiang is not a face observation tool and not a generic mystical app.
It is an Eastern AI advisor that starts from a selfie and explains why the user is currently stuck in a certain emotional or life tension.

Main corrections required:

1. Fix the product framing on Home.
- Remove the feeling of “photo analysis tool”.
- Replace wording like “面部观察” with language closer to “从你的脸开始，解释你现在为什么会这样”.
- Replace CTA “开始拍摄” with a more product-level CTA such as “开始看我现在的状态”.
- Home should feel like an intimate advisor entry page, not a camera utility.

2. Correct the first-time core flow.
- The correct flow is:
  Home -> Capture / Upload -> Quality Fail or Analyzing -> Read Me -> Context Onboarding -> Today First Ready
- Do not send users directly from Read Me to Today.
- Read Me must first hand off into Context Onboarding.

3. Revise Quality Fail to be concrete and singular.
- Each failure screen should show one primary reason only.
- Remove vague poetic wording like “还不够清定”.
- Use direct, gentle Chinese such as:
  “光线太暗，额头和五官不够清楚”
  “角度偏侧，无法进入完整分析”
  “遮挡过多，无法判断关键部位”
- Keep one clear fix suggestion and one primary retry action.

4. Revise Analyzing so it feels warm but operationally correct.
- Remove exact countdown copy like “预计还需 18 秒”.
- Remove “稍后提醒我”.
- Use a calm waiting state with:
  “正在观察你的整体格局与关键部位”
  “正在整理你的第一版画像”
- Timeout state should offer:
  “继续等待”
  “重新尝试”
- The page should still feel ritual-like, but not interrupt the first aha.

5. Correct the Read Me information hierarchy.
- Full Read Me must clearly show:
  Hook
  整体格局
  内在结构
  为什么这么判断
  下一步问题
- Keep the emotional hook strong at the top.
- Make the Why card readable and visible, but not larger than the hook.
- Remove report-like or archive-like actions such as “保存这次解释”.
- Replace the main CTA “进入今日” with a CTA that leads into Context Onboarding, such as:
  “继续，让它更贴近我现在的处境”
- Keep a secondary CTA for retaking the photo.

6. Correct Today First Ready.
- This screen should feel like a continuation of onboarding, not a generic Today page.
- Replace “开始今日观照” with a CTA closer to:
  “围绕这件事继续问”
- Replace the secondary CTA with something closer to:
  “先收下今天这条提醒”
- The emotional message should be:
  “我会先沿着你刚才提到的这条主线陪你看下去”

7. Unify the tab system and app language.
- Do not use all-caps English navigation like TODAY / ASK / READ ME.
- Use one consistent Chinese-first navigation language system.
- Recommended tab labels:
  读我
  今日
  继续问
  我的故事
- Make sure the fourth tab is visible and consistent in all tab shell screens.

8. Restructure My Story.
- The current design feels too much like a timeline page.
- Move these modules higher:
  当前主 tension
  当前主线程
  最近 7 天摘要
  Memory 入口
- Timeline/history can remain lower on the page.
- My Story should feel like “the evolving relationship record between the user and FaceXiang,” not just an event feed.

9. Adjust Settings and destructive actions.
- Reduce the emphasis on data export in v1.
- Increase the emphasis on:
  隐私说明
  删除图片
  删除记忆
  删除账号
- Destructive actions should feel calm, clear, and trustworthy.
- Avoid making account deletion the most visually dominant object on the page.

10. Improve the typography system.
- Do not use Microsoft YaHei as the only visible font style across the whole product.
- Introduce a clearer typography hierarchy:
  refined serif-like display style for hero titles and key section titles
  clean modern sans-serif for body text
- The app should feel more editorial, intimate, and premium.

11. Keep and reinforce the correct visual direction.
- Maintain a warm light background
- dark charcoal text
- deep teal or dark jade accent
- muted bronze secondary accent
- large whitespace
- subtle card hierarchy
- no purple
- no galaxy space visuals
- no crystal ball / tarot / cheap mystical cues

12. Make empty, locked, and failure states feel productized.
- They should feel like a calm advisor guiding the user forward.
- Not like technical blocks or empty placeholders.

Please revise the existing screens with these corrections, keeping the same product family and iOS-native layout quality.
Use Chinese UI copy throughout.
```

## 15. 针对 `facexiang-mvp-v1.pen` 的二轮修订 Prompt

这版 `facexiang-mvp-v1.pen` 已经比上一版明显更接近目标：

- Home 的定位基本修正了
- 页面覆盖度已经完整
- 整体气质更像安静的顾问，而不是识别工具

但还没有完全和 PRD 对齐。  
下面这段 prompt 用于基于当前稿继续精修，而不是重画一套。

```text
Refine the current FaceXiang MVP v1 design based on the latest draft.

Do not redesign from scratch.
Keep:
- the calm and private mood
- the warm light palette
- the strong first-session screen coverage
- the more mature Home positioning

Now fix the remaining mismatches with the product spec.

1. Fix the Read Me exit action.
- On Full Read Me, remove the direct CTA “进入今日”.
- Replace it with a CTA that leads into Context Onboarding, such as:
  “继续，让它更贴近我现在的处境”
- Remove “保存这次解释”, because it makes the screen feel like a report archive instead of a live advisory experience.

2. Strengthen the Read Me structure.
- Full Read Me should more clearly express:
  Hook
  整体格局
  内在结构
  为什么这么判断
  下一步问题
- The current version has emotional tone, but still needs a stronger “structure before action” feeling.

3. Fix Context Onboarding so it collects real-world context, not just one emotional pattern.
- The current onboarding is too narrow and feels like a single-choice emotional check-in.
- Redesign it as a progressive lightweight 3-4 step flow that captures:
  你现在最担心失去的是什么
  你最想推进的一件事是什么
  最近最牵动你情绪的是谁
  你希望我先关注关系 / 工作 / 内在状态
- Keep it light, but make it broad enough to support memory and Today generation.

4. Correct Today First Ready.
- It should feel like the handoff after onboarding, not like a generic Today landing.
- Replace CTA “开始今日观照” with:
  “围绕这件事继续问”
- Replace “先看看我的读我” with:
  “先收下今天这条提醒”
- Add a stronger emotional handoff message like:
  “我会先沿着你刚才提到的这条主线陪你看下去”

5. Unify tab navigation language.
- Remove all-caps English labels like TODAY / ASK / READ ME from the tab system.
- Use one stable Chinese-first naming system across all shell screens.
- Recommended:
  读我
  今日
  继续问
  我的故事

6. Restructure My Story.
- The current version still feels too much like a timeline page called “我的轨迹”.
- Move these modules to the top:
  当前主 tension
  当前主线程
  最近 7 天摘要
  Memory 入口
- Timeline/history can remain below, but should not define the entire page.
- The page should feel like “a growing private relationship record,” not just a chronological archive.

7. Adjust Settings priorities.
- Reduce the emphasis on data export in v1.
- Increase clarity around:
  删除图片
  删除记忆
  删除账号
  隐私说明
- Keep destructive flows calm and controlled.

8. Improve the typography hierarchy.
- Do not rely almost entirely on Microsoft YaHei.
- Create a more refined type system:
  display / hero titles with a more editorial serif-like feeling
  clean readable sans-serif for body text
- The app should feel more premium, intimate, and contemporary Eastern.

9. Keep the visual direction stable.
- warm light background
- deep charcoal text
- deep teal or dark jade accent
- muted bronze secondary accent
- large white space
- subtle but premium card hierarchy
- no purple
- no cosmic astrology mood

Please refine the existing screens with these corrections while preserving the current overall design family and screen coverage.
Use Chinese UI copy.
```
