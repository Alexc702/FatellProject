# FaceXiang iOS v1 详细 PRD

## 1. 文档目标

本文件基于以下文档收敛为一份面向 iOS 首版的详细 PRD：

- [analysis-trace-spec.md](/Users/lulu/Codex/FatellProject/docs/analysis-trace-spec.md)
- [facexiang-page-interaction-design.md](/Users/lulu/Codex/FatellProject/docs/facexiang-page-interaction-design.md)
- [async-flow-and-fallback-spec.md](/Users/lulu/Codex/FatellProject/docs/async-flow-and-fallback-spec.md)
- [identity-memory-spec.md](/Users/lulu/Codex/FatellProject/docs/identity-memory-spec.md)
- [v1-copy-and-prompt-spec.md](/Users/lulu/Codex/FatellProject/docs/v1-copy-and-prompt-spec.md)

本文件用于：

- 统一产品、设计、工程、AI、测试对首版范围的理解
- 作为下一步 UI 设计稿的直接输入
- 约束首版不会退化成“面部识别报告工具”

对应的 UI 设计稿说明见：

- [facexiang-ui-design-brief.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ui-design-brief.md)

如需直接生成 AI 设计稿，可使用：

- [facexiang-pencil-design-input.md](/Users/lulu/Codex/FatellProject/docs/facexiang-pencil-design-input.md)

## 2. 产品定义

## 2.1 一句话定义

`FaceXiang` 是一个以自拍为第一识别入口、基于相学知识体系做结构化分析、并围绕用户当下 tension 持续提供 guidance 的东方顾问型 AI。

## 2.2 首版核心价值

首版要证明的不是“识别准不准”，而是：

- 用户是否会在首个 `Read Me` 中感到被说中
- 用户是否觉得产品在解释“为什么我会这样”
- 用户是否愿意在此基础上补充现实处境并继续回来

## 2.3 首版不做

- 泛聊天 AI 伴侣
- 多玄学模块
- 社交关系网络
- 恋爱角色扮演
- 复杂商业化策略

## 2.4 核心渠道

- `iOS first`
- 首版不以微信小程序为主验证渠道

## 3. 产品目标与成功指标

## 3.1 产品目标

### 目标 1：做出强 `first aha`

用户在第一次看完 `Read Me` 后，应该产生以下至少一个感受：

- 它不只是看脸，它在解释我现在的状态
- 它抓到了我最近真正卡住的地方
- 它说中了我为什么总会这样

### 目标 2：建立最小连续关系

用户在 first aha 后，愿意继续提供一点现实处境，让产品从“面相推理”进入“围绕主 tension 的持续关系”。

### 目标 3：建立回访入口

即使首版不把 `Today / Ask / My Story` 做到很深，也要先把入口和结构定清楚，为后续版本留出完整承接面。

## 3.2 成功指标

首版重点观测：

- `Read Me` 完成率
- `first aha` 主观评分
- “是否像在说我”主观评分
- “是否讲清了我为什么会这样”主观评分
- `为什么这么判断` 展开率
- `Context Onboarding` 完成率
- 首次从 `Read Me` 进入 `Today` 的转化率
- `Ask` 首次进入率

## 4. 用户与使用场景

## 4.1 核心用户

- 22-40 岁女性优先
- 对关系、成长、方向问题较敏感
- 对 astrology / tarot / self-discovery / guidance 有消费或使用习惯
- 对现实关系有保留，希望先在低风险环境里表达

## 4.2 触发场景

- 最近关系里有模糊和拉扯，想知道到底卡在哪里
- 最近面临工作或方向选择，但不知道为什么总迈不过去
- 感觉自己在重复某种模式，希望有人把这个模式讲清楚

## 4.3 用户在首版里的心理路径

### 进入前

- 好奇
- 怀疑
- 有一点想被说中的期待

### `Read Me` 中

- 先被一句话勾住
- 再看整体格局和内在结构
- 然后通过“为什么这么判断”建立信任

### `Context Onboarding` 后

- 觉得产品已经知道一部分自己
- 愿意让它继续沿着这条主线跟进

## 5. 分析驱动的产品原则

## 5.1 产品必须体现的分析链

首版页面和功能都必须服务以下链路：

`图片 -> 质量门 -> 结构化观察 -> 相学系统落点 -> 规则合成 -> 解释弧线 -> tension 假设 -> Read Me`

## 5.2 必须接入的相学知识层

首版界面和功能设计必须默认以下知识层已经是产品核心，不是背景说明：

- 五官系统
- 三停系统
- 十二宫系统
- 部位细相
- 主题索引
- 原文溯源能力

## 5.3 面向用户的呈现原则

用户看到的是：

- 整体格局
- 内在结构
- 当前主 tension
- 为什么这么判断

用户不应直接看到：

- 规则 ID
- 原始 JSON
- 过多相学术语堆叠
- 技术性评分解释

## 6. 版本范围

## 6.1 本轮必须落地的页面

- `Home`
- `Capture / Upload`
- `Quality Fail`
- `Analyzing`
- `Read Me`
- `Context Onboarding`
- `Today`
- `Ask`
- `My Story`
- `Memory`
- `Settings`
- `Delete Data Flow`

## 6.2 版本层次

### 高保真产品页面

- `Home`
- `Capture / Upload`
- `Quality Fail`
- `Analyzing`
- `Read Me`
- `Context Onboarding`

### 导航壳与结构定义页面

- `Today`
- `Ask`
- `My Story`
- `Memory`
- `Settings`

## 7. 信息架构

## 7.1 首次使用路径

`Home -> Capture / Upload -> Quality Check -> Analyzing -> Read Me -> Context Onboarding -> Today First Ready`

## 7.2 首次后主导航

底部 tab 固定为：

1. `Read Me`
2. `Today`
3. `Ask`
4. `My Story`

## 7.3 页面分组

### First Session Flow

- `Home`
- `Capture / Upload`
- `Quality Fail`
- `Analyzing`
- `Read Me`
- `Context Onboarding`
- `Today First Ready`

### Main Tabs

- `Read Me`
- `Today`
- `Ask`
- `My Story`

### Secondary Pages

- `Memory`
- `Settings`
- `Delete Data Flow`

## 8. 全局功能需求

## 8.1 匿名身份启动

### 功能目标

- 让用户在 first session 无需登录即可开始
- 又保证后续记忆、线程、`Today` 有稳定归属

### 产品规则

- App 首次启动时自动创建匿名身份
- 匿名身份写入 `Keychain`
- 后续启动自动恢复

### 用户感知

- 用户不需要在 first session 看到注册/登录步骤
- 只有在 `Settings` 或未来账户升级时才显性感知身份系统

## 8.2 图片输入

### 功能目标

- 允许用户快速提交自拍或从相册选择图片

### 输入方式

- iPhone 相机拍照
- 系统相册选择

### 约束

- 单张
- 单人
- 正脸
- 无明显遮挡

### 用户价值

- 减少操作负担
- 在进入分析前先把质量门做好

## 8.3 质量门

### 功能目标

- 在用户等待完整分析前，先阻断明显不可用的图片

### 失败类型

- 没有脸
- 多人
- 非正脸
- 过暗
- 过糊
- 遮挡严重

### 产品规则

- 失败时只展示一个主要原因
- 必须有明确重拍建议
- 必须支持直接回到拍照或选图

## 8.4 分析中异步体验

### 功能目标

- 避免用户把等待理解为系统坏了

### 时延目标

- 质量门 `< 1s`
- 上传 `< 2s`
- 特征抽取与规则映射 `< 6s`
- 完整 `Read Me` `8-12s`

### 产品规则

- 以阶段式文案告诉用户当前在做什么
- 8 秒后进入超时提示态
- 超时后给出 `继续等待 / 重新尝试`
- 必要时允许简版 `Read Me` 降级

## 8.5 Read Me 生成

### 功能目标

- 让用户第一次得到足够强的命中感

### 生成原则

- 不是部位罗列
- 必须体现整体格局
- 必须包含内在结构
- 必须有清晰的“为什么这么判断”

### 核心输出

- `Hook`
- `整体格局`
- `内在结构`
- `当前主线 / 主 tension`
- `为什么这么判断`
- `下一步问题`

## 8.6 Context Onboarding

### 功能目标

- 把刚刚的推理接到用户现实处境

### 设计原则

- 单题分步
- 可跳过
- 选项优先，自由输入补充

### 收集内容

- 最担心失去什么
- 最想推进什么
- 最近最牵动情绪的是谁
- 更想先关注关系、工作还是内在状态

## 8.7 Today

### 功能目标

- 成为用户次日回访主入口

### 首版内容结构

- 今日主线
- 今天最容易失衡的点
- 一个小行动
- 一个跟进问题

### 首版状态

- `locked`
- `loading`
- `first_ready`
- `ready`

## 8.8 Ask

### 功能目标

- 让问题从单问单答变成围绕主线的连续线程

### 首版结构

- 当前线程标题
- 历史摘要
- 问题输入框
- 最新回答
- 下一步问题建议

### 首版状态

- `locked`
- `bootstrapping`
- `ready`
- `awaiting_response`

## 8.9 My Story

### 功能目标

- 让用户感到产品在持续记得自己

### 首版结构

- 当前主 tension
- 当前主线程
- 最近 7 天摘要
- `Memory` 入口
- `Weekly Recap` 占位区

## 8.10 Memory Review

### 功能目标

- 防止因记忆错误造成关系感崩塌

### 用户能力

- 查看关键人物
- 查看当前主画像
- 查看当前主 tension
- 编辑关键记忆
- 标记“这条不对”
- 标记“不要再提”
- 删除记忆

## 8.11 Settings 与删除能力

### 功能目标

- 满足首版隐私与上架要求

### 用户能力

- 删除图片
- 删除记忆
- 删除账号

## 9. 页面级详细 PRD

## 9.1 Home

### 页面目标

- 让用户 5 秒内理解产品定位
- 让用户愿意开始 first aha 路径

### 用户进入场景

- 首次打开 App
- 尚未生成 `Read Me`
- 或已生成过 `Read Me`，再次进入查看

### 页面入口

- App 首次启动
- tab 中切回 `Read Me`

### 页面出口

- 进入相机
- 进入相册
- 若已有画像，进入更新图片流程

### 页面模块

#### 模块 A：品牌与一句话价值主张

作用：

- 给产品一个明确的品类心智

内容要求：

- 不写成“AI 算命”
- 更强调“从你的脸开始解释你现在为什么会这样”

#### 模块 B：Hero 主标题

作用：

- 直接建立 first aha 预期

内容要求：

- 要有 tension 感
- 不能是泛功能陈述

#### 模块 C：简短说明

作用：

- 告诉用户这是如何工作的

内容要求：

- 只用 1 段短文
- 说明系统会观察整体格局、五官功能、三停和重点宫位
- 不展开相学百科

#### 模块 D：主 CTA

文案：

- `开始看我现在的状态`

作用：

- 将首次会话导入相机

#### 模块 E：次 CTA

文案：

- `从相册选择`

作用：

- 给不愿自拍的用户一个低门槛入口

#### 模块 F：信任区

内容：

- 图片仅用于生成画像，可删除
- 内容为文化解读与方向参考，不替代专业意见

#### 模块 G：轻量示意区

内容：

- 产品会看：
  - 整体格局
  - 当前更容易失衡的模式
  - 为什么会落到这个 tension

### 页面状态

#### `first_open`

- 展示完整价值主张
- CTA 指向首次分析

#### `returning_without_readme`

- 与首次类似
- 可加入“继续完成你的第一次画像”

#### `returning_with_readme`

- 显示最近一次主 tension 摘要
- 主 CTA 变为 `更新我的画像`

### 交互规则

- 首屏不出现多个并列主入口
- 不出现过长文案
- 不出现复杂术语解释

### 数据依赖

- `SessionStore.hasReadMe`
- `SessionStore.currentPrimaryTension`

### 埋点

- `home_viewed`
- `home_primary_cta_tapped`
- `home_library_cta_tapped`

### 验收标准

- 用户能明确知道这不是面部识别功能
- 用户知道点击主按钮后会进入自拍分析

## 9.2 Capture / Upload

### 页面目标

- 让用户获得一张适合进入完整分析的照片

### 页面入口

- Home 主 CTA
- Home 次 CTA
- Quality Fail 重试
- Read Me 更新画像

### 页面出口

- 进入 `quality_checking`
- 返回 Home

### 页面模块

#### 模块 A：拍摄/选图预览区

作用：

- 展示当前图片
- 给用户最终确认

#### 模块 B：拍摄指引

固定内容：

- 正脸
- 自然光
- 单人
- 无遮挡

#### 模块 C：主 CTA

文案：

- `使用这张照片`

#### 模块 D：次 CTA

- `重新拍照`
- `重新选择`

#### 模块 E：权限回退弹层

出现条件：

- 用户拒绝相机权限

动作：

- `去相册选择`
- `打开系统设置`

### 页面状态

#### `camera_ready`

- 相机正常可用

#### `photo_preview`

- 已拍完或已选完
- 等待用户确认

#### `camera_permission_denied`

- 弹出权限回退

### 交互规则

- 用户不需要先填任何额外表单
- 确认照片后立即进入质量门

### 数据依赖

- 本地图片
- 相机权限状态
- 相册权限状态

### 埋点

- `photo_capture_opened`
- `photo_library_opened`
- `photo_selected`
- `photo_confirmed`
- `camera_permission_denied`

### 验收标准

- 拍照、选图、重拍、重选都能顺利完成
- 权限失败不阻断整个流程

## 9.3 Quality Fail

### 页面目标

- 把失败变成明确、具体、可修复的反馈

### 页面入口

- `FaceQualityAssessment.passed = false`

### 页面出口

- 返回拍照
- 返回相册重选

### 页面模块

#### 模块 A：失败标题

规则：

- 不使用“识别失败”
- 必须直接说主要原因

#### 模块 B：原因说明

规则：

- 只解释一个主因
- 用用户语言，不用技术语言

#### 模块 C：修复建议

规则：

- 只给一条最关键建议

#### 模块 D：操作按钮

- `重新拍照`
- `从相册选择另一张`

### 失败类型与文案

#### 没有脸

- 标题：没有检测到清晰正脸
- 建议：请正对镜头，保证脸部完整进入画面

#### 多人

- 标题：这张照片里有多人
- 建议：请换成只有你一个人的正脸照片

#### 过暗

- 标题：光线太暗，额头和五官不够清楚
- 建议：请在自然光下重拍，避免逆光

#### 遮挡

- 标题：遮挡过多，无法判断关键部位
- 建议：请移开头发、口罩或墨镜后再试

#### 角度偏侧

- 标题：角度偏侧，无法进入完整分析
- 建议：请正对镜头，避免侧脸和低头

#### 过糊

- 标题：照片偏糊，关键细节不够清楚
- 建议：请换一张更清晰的照片

### 交互规则

- 每次只呈现一个主要失败原因
- 页面必须保留继续动作

### 数据依赖

- `FaceQualityAssessment.failureReasons`

### 埋点

- `quality_failed`
- `quality_failed_retry_camera`
- `quality_failed_retry_library`

### 验收标准

- 用户看完知道为什么失败
- 用户知道下一步怎么修复

## 9.4 Analyzing

### 页面目标

- 在用户等待期间维持信任和期待感

### 页面入口

- 质量门通过
- 已开始上传和分析

### 页面出口

- 进入 `Read Me`
- 进入 `Quality Fail`
- 进入分析失败页
- 进入简版 `Read Me`

### 页面模块

#### 模块 A：阶段进度区

固定文案：

1. 正在检查照片质量
2. 正在观察你的整体格局与关键部位
3. 正在整理你的第一版画像

#### 模块 B：解释说明区

作用：

- 告诉用户为什么需要一点时间

表达要求：

- 像顾问在观察，而不是技术加载

#### 模块 C：超时操作区

出现条件：

- 超过 8 秒

动作：

- `继续等待`
- `重新尝试`

#### 模块 D：失败回退区

出现条件：

- 网络失败
- 模型失败
- 输出不合法且重试后仍失败

动作：

- `再试一次`
- `换一张照片`

#### 模块 E：降级结果入口

出现条件：

- 完整 `Read Me` 暂时拿不到
- 但有结构化 trace 能支持简版结果

动作：

- `先看简版结果`

### 页面状态

#### `quality_checking`

- 第一阶段

#### `uploading`

- 上传中

#### `analyzing`

- 核心观察与推理中

#### `timeout`

- 超时提示

#### `failed`

- 分析失败态

#### `partial_ready`

- 可进入简版结果

### 交互规则

- 页面中心不出现技术词、JSON、置信度
- 超时不自动强跳失败
- 用户始终知道系统还在处理什么

### 数据依赖

- `async analysis state`
- `partial ReadMeOutput`

### 埋点

- `analyzing_viewed`
- `analyzing_timeout`
- `analyzing_retry`
- `analyzing_partial_entered`

### 验收标准

- 用户不会把等待理解为卡死
- 用户不会因为技术性提示失去信任

## 9.5 Read Me

### 页面目标

- 完成首个 `first aha`

### 页面入口

- 完整分析完成
- 或简版结果就绪

### 页面出口

- 进入 `Context Onboarding`
- 返回更新图片

### 页面结构总览

首屏必须按以下顺序呈现：

1. `Hook`
2. `整体格局`
3. `内在结构`
4. `为什么这么判断`
5. `下一步问题`

### 模块 A：Hook

#### 目标

- 第一秒打到 tension

#### 内容要求

- 1 句话
- 不绝对
- 具体
- 克制
- 不像模板

#### 示例方向

- 你现在最累的地方，可能不是事情太多，而是你一直在替所有后果做提前防守。

### 模块 B：整体格局

#### 目标

- 给用户一个“整体被看见”的感觉

#### 内容要求

- 强调整体结构
- 不罗列部位
- 不直接下命定判断

#### 表达方向

- 你给人的感觉更像稳住局面的人，不轻易把波动放在表面，但这种稳里其实包着很强的自我保护。

### 模块 C：内在结构

#### 目标

- 把五官功能倾向、三停能量、重点宫位，压缩为可理解的人格动力学解释

#### 必须表达的内容

- 你更像先判断还是先扛住
- 你更容易在哪个主题上先收住自己
- 当前更被激活的是关系、选择、安全感还是自我价值

#### 表达限制

- 不直接大篇术语堆叠
- 不讲成教学材料

### 模块 D：为什么这么判断

#### 目标

- 建立解释性与可信度

#### 交互形式

- 默认半展开
- 点击后完整展开

#### 收起态

- 2-3 句摘要

#### 展开态顺序

1. `我看到了什么`
2. `这些位置通常指向什么`
3. `为什么会落到你现在的 tension`

#### 展现边界

- 不展示规则 ID
- 不展示原始 JSON
- 允许轻量提到：
  - 眉眼这一组
  - 山根/印堂这一组
  - 鼻部/中庭这一组

### 模块 E：下一步问题

#### 目标

- 把静态分析自然接到用户现实处境

#### 表达要求

- 像继续追问，不像表单

#### 示例方向

- 如果这句有点像，你最近更卡在关系、工作，还是自己心里的拉扯？

### 模块 F：页面底部动作

- 主 CTA：`继续，让它更贴近我现在的处境`
- 次 CTA：`换一张照片重看`

### 页面状态

#### `full_readme`

- 展示完整 5 个区块

#### `partial_readme`

- 只展示：
  - 第一印象
  - 一个主 tension
  - 一个下一步问题
- 仍必须保留 `为什么这么判断`

#### `readme_refresh`

- 用于更新图片后的再次生成

### 数据依赖

- `ReadMeOutput`
- `ExplanationTrace`

### 埋点

- `readme_viewed`
- `readme_why_expanded`
- `readme_continue_tapped`
- `readme_refresh_tapped`

### 验收标准

- 用户首屏先看到命中感
- 用户能通过“为什么这么判断”建立信任
- 页面不被用户理解成面部识别报告

## 9.6 Context Onboarding

### 页面目标

- 用最少输入，把刚刚的画像贴近现实处境

### 页面入口

- `Read Me` 主 CTA

### 页面出口

- `Today First Ready`

### 页面模块

#### 模块 A：顶部说明

文案目标：

- 让用户理解这不是冗长资料采集

建议表达：

- 只需要一点点现实处境，我才能把刚才那段判断说得更贴近你

#### 模块 B：单题卡片

交互形式：

- 一次只显示一题
- 提供快捷选项
- 支持自由输入
- 支持跳过

#### 模块 C：进度提示

作用：

- 降低表单感

表达建议：

- `1 / 4`
- `2 / 4`

### 问题定义

#### Q1：你现在最担心失去的是什么？

目的：

- 捕捉核心 fear

#### Q2：你最想推进的一件事是什么？

目的：

- 捕捉核心 desire

#### Q3：最近最牵动你情绪的是谁？

目的：

- 捕捉重要关系对象

#### Q4：你希望我先更关注关系、工作，还是内在状态？

目的：

- 决定 first `Today` 的主语境

### 页面状态

- `question_active`
- `question_skipped`
- `completed`

### 交互规则

- 不出现长表单
- 每题都允许跳过
- 完成后不回首页

### 数据依赖

- 本地 onboarding draft
- 后续可写入 `MemoryItem / TensionProfile`

### 埋点

- `onboarding_started`
- `onboarding_question_answered`
- `onboarding_question_skipped`
- `onboarding_completed`

### 验收标准

- 用户不会把它理解为繁琐问卷
- 完成后能自然进入后续关系页面

## 9.7 Today

### 页面目标

- 成为次日回访入口

### 页面入口

- 首次 onboarding 完成
- 后续从 tab 进入

### 页面出口

- 进入 `Ask`
- 进入 `My Story`

### 页面模块

#### 模块 A：今日主线

作用：

- 告诉用户今天产品围绕哪条 tension 在看

#### 模块 B：今天最容易失衡的点

作用：

- 把指导落到今天

#### 模块 C：一个小行动

作用：

- 给轻量可执行动作

#### 模块 D：一个跟进问题

作用：

- 引导进入 `Ask`

### 页面状态

#### `locked`

- 未完成 `Read Me`
- 文案：先完成第一次画像，Today 才会开始真正围绕你生成

#### `loading`

- 内容生成中
- 文案：今天的内容还在整理中

#### `first_ready`

- 首次 onboarding 完成后的欢迎态
- 顶部承接文案：
  - 我会先沿着你刚才提到的这条主线陪你看下去

#### `ready`

- 正常展示今日内容

### 交互规则

- 当日内容未生成时，不展示空白
- 首次 ready 必须给出 `去 Ask` 和 `先收下这条提醒` 两个动作

### 数据依赖

- `DailyGuidance`
- 当前主 tension
- 当前主线程

### 埋点

- `today_viewed`
- `today_first_ready_viewed`
- `today_ask_cta_tapped`
- `today_refresh_tapped`

### 验收标准

- 用户感到 Today 是围绕自己，而不是日运卡片

## 9.8 Ask

### 页面目标

- 围绕当前主线继续推进，而不是重新开始一次问答

### 页面入口

- Today 跟进问题
- Tab 进入

### 页面出口

- 留在本页继续对话
- 进入 My Story

### 页面模块

#### 模块 A：当前线程标题

作用：

- 告诉用户系统正在围绕哪条主线继续

#### 模块 B：历史摘要

作用：

- 降低重复解释成本

#### 模块 C：输入框

作用：

- 接收用户当前问题

#### 模块 D：最新回答区

作用：

- 给出承接式回答

#### 模块 E：下一步问题建议

作用：

- 引导用户再往下挖一层

### 页面状态

#### `locked`

- 未完成 `Read Me`

#### `bootstrapping`

- 没有线程，但系统正在用主 tension 建立首个线程

#### `ready`

- 正常使用态

#### `awaiting_response`

- 用户已提交问题，系统正在整理回复
- 必须保留用户输入内容

### 交互规则

- 回答必须承接历史线程
- 不允许像普通聊天页那样完全无上下文

### 数据依赖

- `GuidanceThread`
- `ThreadMessage`
- 当前主 tension

### 埋点

- `ask_viewed`
- `ask_first_bootstrapped`
- `ask_message_sent`
- `ask_response_received`

### 验收标准

- 用户感到问题是被承接的，不是被重新处理的

## 9.9 My Story

### 页面目标

- 建立“它真的在持续记得我”的感觉

### 页面入口

- 主 tab 进入

### 页面出口

- 进入 `Memory`
- 进入未来 `Weekly Recap`

### 页面模块

#### 模块 A：当前主 tension

作用：

- 固定当前主线感

#### 模块 B：当前主线程

作用：

- 让用户知道现在最主要的持续主题是什么

#### 模块 C：最近 7 天摘要

作用：

- 用时间维度加强“连续关系”

#### 模块 D：Memory 入口

作用：

- 提供记忆可控感

#### 模块 E：Weekly Recap 占位区

作用：

- 为后续版本预埋结构

### 页面状态

#### `locked`

- 未完成 `Read Me`

#### `empty`

- 已完成 `Read Me`，但还没有足够历史内容

#### `ready`

- 展示摘要与入口

### 数据依赖

- `TensionProfile`
- `GuidanceThread`
- `WeeklyRecap`

### 埋点

- `my_story_viewed`
- `memory_entry_tapped`

### 验收标准

- 用户能理解这是“我和它之间的连续记录”

## 9.10 Memory

### 页面目标

- 提供最小可用的记忆审阅与纠错闭环

### 页面入口

- `My Story` 入口

### 页面出口

- 返回 `My Story`
- 进入具体编辑

### 页面模块

#### 模块 A：关键人物

内容：

- 名称/代称
- 关系类型
- 当前关系阶段

#### 模块 B：当前关注主题

内容：

- 当前 tension
- 当前主线标签

#### 模块 C：已确认记忆

内容：

- 用户输入过的关键事实
- 已确认的 AI 推断

#### 模块 D：记忆操作

每条记忆支持：

- `修改`
- `不要再提`
- `删除`

### 交互规则

- 被压制的记忆应显示为已压制
- 被删除的记忆不再出现在主列表

### 数据依赖

- `MemoryItem[]`

### 埋点

- `memory_viewed`
- `memory_edited`
- `memory_suppressed`
- `memory_deleted`

### 验收标准

- 用户能纠正至少一条关键记忆
- 用户有能力阻止错误记忆继续影响回答

## 9.11 Settings

### 页面目标

- 承接隐私、删除、账号相关动作

### 页面模块

#### 模块 A：图片管理

- 查看是否可删除图片

#### 模块 B：记忆管理快捷入口

- 跳转 Memory

#### 模块 C：账号与数据

- 删除账号
- 删除全部记忆
- 删除全部图片

### 数据依赖

- 匿名账户状态
- 服务端删除接口状态

### 验收标准

- 用户能明确找到数据删除能力

## 9.12 Delete Data Flow

### 页面目标

- 让删除动作明确、可撤回确认、不可误触

### 删除类型

- 删除单张图片
- 删除单条记忆
- 删除全部记忆
- 删除账号

### 流程规则

- 先确认
- 明确说明后果
- 删除成功后给反馈

### 验收标准

- 删除后本地状态同步更新
- 未来生成内容不再引用已删除/已压制数据

## 10. 功能级详细 PRD

## 10.1 匿名身份恢复

### 功能目标

- 让用户无登录也能形成连续关系

### 触发时机

- App 启动

### 功能行为

- 读取 `Keychain`
- 若存在匿名身份，则恢复
- 若不存在，则创建匿名身份

### 成功定义

- 用户无感恢复画像、线程、Today、My Story

## 10.2 Read Me 刷新

### 功能目标

- 允许用户换图重看，但不破坏关系主线

### 功能行为

- 用户在 `Read Me` 点击 `换一张照片重看`
- 重新走 `Capture / Upload -> Quality Gate -> Analyzing -> Read Me`
- 新画像覆盖旧画像快照

### 产品规则

- 主 tension 可变化
- 但历史关系与记忆不应被直接清空

## 10.3 简版 Read Me 降级

### 功能目标

- 在完整结果暂不可用时，仍保留 first aha 机会

### 触发条件

- 完整结果超时
- 但已有可用结构化 trace

### 输出要求

- 第一印象
- 一个主 tension
- 一个后续问题
- 一个最短版“为什么这么判断”

### 禁止

- 用 generic 文案填空

## 10.4 Today 首次 ready

### 功能目标

- 把 onboarding 刚收集到的现实处境，立刻转成一个连续关系承接点

### 功能行为

- onboarding 完成
- 生成首个 Today
- 同时给出进入 Ask 的 CTA

### 成功定义

- 用户感觉产品已经开始“沿着我刚提到的这条线继续”

## 10.5 Thread bootstrap

### 功能目标

- 用 `Read Me` 的主 tension 建立第一个主题线程

### 触发条件

- 用户第一次进入 Ask 且没有现成线程

### 功能行为

- 以主 tension 为主题建立线程
- 写入首条摘要
- 准备后续回答上下文

## 10.6 Memory suppression

### 功能目标

- 防止错误或敏感记忆继续被引用

### 功能行为

- 用户点击 `不要再提`
- 记忆状态改为 `suppressed`
- 后续生成不得引用

## 10.7 账号删除

### 功能目标

- 满足隐私与审核要求

### 功能行为

- 用户确认删除账号
- 删除服务端主档、线程、recap
- 本地 token 作废

## 11. 文案与语气要求

## 11.1 全局语气

应该有的感觉：

- 具体
- 克制
- 温和
- 像真的在观察你

不应该有的感觉：

- 神棍
- 训话
- 鸡汤
- 宿命论
- 诱导依赖

## 11.2 Read Me 文案结构

固定由以下内容组成：

1. Hook
2. 第一印象 / 整体格局
3. 防御模式 / 内在结构
4. 主 tension
5. 为什么这么判断
6. 下一步问题

## 11.3 风险边界

可以说：

- 倾向
- 模式
- 拉扯
- 当下状态
- 小行动建议

不可以说：

- 保证结果
- 命定结果
- 医疗/心理诊断
- 投资/法律建议
- 对第三方绝对判断

## 12. 数据与页面映射

## 12.1 Read Me 映射

- `hookLine` -> Hook
- `overallPattern` -> 整体格局
- `defensePattern` + `relationshipSignal` + `careerOrRealitySignal` -> 内在结构
- `primaryTension` -> 当前主线
- `trace.whySummary` -> 为什么这么判断摘要

## 12.2 Quality Fail 映射

- `FaceQualityAssessment.failureReasons` -> 失败页标题和建议

## 12.3 Today 映射

- `DailyGuidance.title` -> 今日主线
- `DailyGuidance.imbalancePoint` -> 今天最容易失衡的点
- `DailyGuidance.smallAction` -> 一个小行动
- `DailyGuidance.followUpQuestion` -> 一个跟进问题

## 12.4 Ask 映射

- `GuidanceThread.title` -> 当前线程标题
- `GuidanceThread.summary` -> 历史摘要
- `ThreadMessage` -> 回答区

## 12.5 My Story 映射

- `TensionProfile.primaryTension` -> 当前主 tension
- `GuidanceThread.current` -> 当前主线程
- `WeeklyRecap / recent summaries` -> 最近 7 天摘要

## 13. 状态机要求

首会话状态机固定为：

1. `idle`
2. `photo_selected`
3. `quality_checking`
4. `quality_failed`
5. `uploading`
6. `analyzing`
7. `readme_partial_ready`
8. `readme_ready`
9. `context_collecting`
10. `today_ready`
11. `failed`

设计稿必须覆盖这些状态至少对应的关键界面。

## 14. 埋点要求

必须埋点：

- Home 主 CTA 点击率
- 图片提交率
- 质量门失败原因分布
- Analyzing 超时率
- `Read Me` 完成率
- `为什么这么判断` 展开率
- `Context Onboarding` 完成率
- `Today` 首次打开率
- `Ask` 首次进入率
- `Memory` 编辑/压制/删除率

## 15. 测试与验收

## 15.1 首次路径验收

- 首屏能明确传达产品定位
- 用户能完成拍照或选图
- 质量失败时知道怎么修复
- 等待时不觉得系统卡死
- `Read Me` 首屏先打到 tension
- 用户能读懂“为什么这么判断”
- onboarding 不像填写档案

## 15.2 壳层验收

- `Today / Ask / My Story` 导航关系清楚
- 锁定态、空态、加载态都有定义
- 页面结构足够支撑后续版本接入真实内容

## 15.3 隐私与记忆验收

- 匿名身份可恢复
- 用户能删除图片、记忆和账号
- 被压制的记忆不会再次被引用

## 16. 给 UI 设计稿的输出要求

基于本 PRD，下一步 UI 设计稿至少需要覆盖：

- `Home`
- `Capture / Upload`
- `Quality Fail`
- `Analyzing`
- `Read Me`
- `Context Onboarding`
- `Today First Ready`
- `Today ready / loading / locked`
- `Ask ready / bootstrapping / locked`
- `My Story ready / empty / locked`
- `Memory`
- `Settings`
- `Delete Data Flow`

每张 UI 稿必须明确：

- 页面标题
- 核心模块层级
- 主 CTA / 次 CTA
- 状态切换
- 文案语气
- 空状态 / 错误状态 / 加载状态

## 17. 结论

这版 iOS 首版 PRD 的核心不是“做一款拍照识别产品”，而是：

- 用自拍建立第一识别锚点
- 用相学推理完成 first aha
- 用 onboarding 把解释接到现实处境
- 用 `Today / Ask / My Story` 预留连续关系的产品骨架

下一步 UI 设计必须始终围绕这一点展开：

`先让用户觉得被说中，再让用户觉得被记得。`
