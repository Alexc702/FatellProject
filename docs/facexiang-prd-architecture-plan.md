# FaceXiang v1 PRD、产品架构与分阶段开发测试计划

## 1. 文档目标

本文件用于统一以下三件事：

- `PRD`：明确首版产品要解决什么问题、给谁用、做什么、不做什么
- `产品/技术架构`：明确未来能够支撑“面相入口 + 记忆 + 连续 guidance”的系统结构
- `开发/测试计划`：明确如何按阶段推进，而不是一开始做成大而全产品

本文默认基于以下已形成的判断：

- [product-plan.md](/Users/lulu/Codex/FatellProject/docs/product-plan.md)
- [marketanalysis.md](/Users/lulu/Codex/FatellProject/docs/marketanalysis.md)
- [astrobot.md](/Users/lulu/Codex/FatellProject/docs/astrobot.md)
- [companion-differentiation.md](/Users/lulu/Codex/FatellProject/docs/companion-differentiation.md)
- [facexiang-page-interaction-design.md](/Users/lulu/Codex/FatellProject/docs/facexiang-page-interaction-design.md)
- [facexiang-ios-implementation-tasks.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-implementation-tasks.md)
- [facexiang-ios-detailed-prd.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-detailed-prd.md)
- [facexiang-ui-design-brief.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ui-design-brief.md)

## 2. 一句话定义

`FaceXiang` 是一个以面相为第一识别入口、会记住用户人生上下文、并围绕其真实 tension 持续提供 guidance 的东方顾问型 AI。

它不是：

- 一次性面相报告工具
- 泛聊天 AI 伴侣
- 传统算命 App

它要做的是：

- 用自拍建立第一锚点
- 用记忆和线程建立连续关系
- 用 daily / weekly guidance 提供可持续消费理由

## 3. 产品愿景与首版目标

### 3.1 愿景

打造一个真正“越来越懂你”的东方 personal oracle，而不是“给你一条今日运势”的内容产品。

### 3.2 v1 目标

验证三件事，但优先级明确如下：

1. `最高优先级`：用户是否会因为首个 `Read Me` 明显感到“它抓到了我真正的 tension”
2. 用户是否愿意在 first aha 之后继续补充一点现实处境
3. 用户是否会围绕同一主题在 7 天内持续回来

### 3.3 v1 不验证的事情

首版不追求验证：

- 大规模 DAU
- 多玄学模块扩张
- 复杂社交网络
- 恋爱型 AI 伴侣关系
- 完整订阅体系最优解

### 3.4 渠道策略

当前已明确：

- `iOS first`
- `微信后置`

原因：

- 当前首版重点是验证强 `first aha`，需要更完整的 App 体验、推送能力、图片链路和后续线程承接
- iOS 更适合承载“拍照 -> 识别 -> 结果 -> 回访 -> 线程 -> recap”的连续体验
- 微信小程序后续作为渠道扩展与中文私域承接，而不是首版验证载体

## 4. 用户与需求

### 4.1 核心用户

- 22-40 岁，女性优先
- 对关系、成长、方向选择高度敏感
- 对 astrology / tarot / self-discovery / guidance 有消费习惯
- 有一定表达欲，但并不一定愿意向现实关系完全暴露自己

### 4.2 用户当下最常见的触发问题

- 我最近适合换工作吗
- 他到底怎么想
- 这段关系我该继续吗
- 我为什么总会卡在同样的地方
- 我是不是正在失去吸引力、选择权或节奏感

### 4.3 底层需求

基于已有研究，v1 最应该抓住的不是“好玩”，而是以下需求：

- 被看见
- 被记得
- 被跟进
- 在不确定里获得最小确定感
- 在混乱里获得解释框架

### 4.4 不该主动激发的危险需求

虽然用户也会带着爱情、欲望、独占等动机进入，但产品不应依靠以下方式增长：

- 制造情感依赖
- 加强宿命论
- 煽动恐惧后付费
- 显性成人化 flirt
- 暗示替代现实关系

## 5. 价值主张

### 5.1 第一价值主张

`它不是只看脸，而是能从你的脸和你的处境里，抓到你现在真正卡住的那根线。`

### 5.2 持续价值主张

`它会记得你最近在经历什么，并围绕同一个 tension 持续给你 guidance。`

### 5.3 对外可用表达

- 懂你当下处境的 AI 相学顾问
- 从你的脸开始认识你，并随着你越聊越懂你
- 比一次性解读更进一步：一个会持续跟进你的 personal oracle

## 6. 产品原则

首版必须遵循以下原则：

### 6.1 先深后广

只做少数高频主线，不做多玄学工具拼盘。

### 6.2 先 tension，后信息量

用户不是需要一份更长报告，而是需要被说中真正的 tension。

### 6.3 先线程，后问答

用户提问不是独立事件，必须挂到主题线程里。

### 6.4 先关系，后内容

daily guidance 不是内容供给，而是连续关系的触点。

### 6.5 先边界，后刺激

产品必须做深层 tension，但不能做操控型依赖设计。

### 6.6 先 first aha，后留存系统

如果首个 `Read Me` 不能稳定打中用户，后续 Today、Ask、Recap 都只会放大空泛感。  
因此首版推进顺序必须是：

- 先把 first aha 打磨到稳定
- 再补线程和留存机制

## 7. v1 产品范围

## 7.1 首版必须有的模块

### 模块 A：Read Me

作用：

- 用户自拍/选图
- 建立第一识别锚点
- 输出第一版相学分析、人格结构与当前 tension 判断

核心输出：

- 整体格局
- 五官功能倾向
- 三停能量分布
- 当前被激活的重点宫位
- 防御方式
- 关系气场 / 吸引力倾向
- 当前主要 tension

说明：

- `Read Me` 不是“识别到哪些面部特征”
- 而是“把五官、三停、十二宫与部位细相组合成一段有推理感的解释”
- 用户应明显感到产品在分析“为什么你会这样”，而不是在列举“你长什么样”

### 模块 B：Context Onboarding

作用：

- 快速建立基础记忆
- 不是收集简历，而是收集当下 tension

首版建议问题：

- 你现在最担心失去的是什么？
- 你现在最想推进的是哪件事？
- 最近最牵动你情绪的是谁？
- 你希望我更关注工作、关系还是内在状态？

### 模块 C：Today With Me

作用：

- 不是运势，而是 contextual guidance
- 围绕当前线程给出当天建议

典型输出：

- 今天你最容易在哪件事上失衡
- 今天最该留意的关系/情绪模式
- 今天最适合做的一个小行动

### 模块 D：Ask About This

作用：

- 围绕当前 tension 持续发问
- 自动将问题归入线程，而不是单问单答

首版线程类型建议：

- `relationship`
- `career_direction`
- `self_worth`
- `decision_conflict`
- `emotional_balance`

### 模块 E：Weekly Pattern Recap

作用：

- 做阶段性总结
- 把产品从回答器升级为人生镜子

首版输出：

- 本周最常重复的 tension
- 最容易被触发的场景
- 哪些建议被执行了
- 下周建议继续跟的主线

## 7.2 首版明确不做

- 多玄学分支：塔罗、梦境、数秘、手相
- 社交功能
- 用户与用户匹配
- 角色扮演型 romantic AI
- 复杂商城与多层付费墙
- 过度主动消息

## 8. 核心用户流程

### 8.1 首次使用

1. 用户进入首页
2. 看到价值主张与免责声明
3. 自拍/上传正脸
4. 系统完成结构化观察、相学落点与推理
5. 输出第一版 `Read Me`
6. 进入 `Context Onboarding`
7. 生成首个 `Today With Me`
8. 引导用户进入第一个线程提问

### 8.2 次日回访

1. 用户打开 App
2. 看到新的 `Today With Me`
3. 看到“昨日主线跟进”
4. 补充一句近况或继续提问
5. 线程继续推进

### 8.3 一周后

1. 用户完成若干次 Today / Ask
2. 收到 `Weekly Pattern Recap`
3. 看到本周 pattern
4. 选择继续同一主线或开启下一主线

## 9. PRD 细化

## 9.1 首页

目标：

- 让用户理解这不是算命工具，而是顾问型 AI
- 提升首次上传意愿

必要元素：

- 产品价值主张
- 自拍入口
- 隐私与免责声明摘要
- 已有线程入口

### 9.2 Read Me 页面

目标：

- 提供第一下 aha moment

内容结构：

- 你给人的第一印象与整体格局
- 你当前更容易出现的防御模式
- 你在关系/事业/安全感上的当前主线
- 为什么这么判断
- 下一步引导问题

补充要求：

- 页面内容不能只由单个部位解释组成
- 必须体现“整体 -> 系统 -> 主线 -> tension”的分析递进
- “为什么这么判断”中应能让用户感到五官、三停、十二宫不是背景知识，而是结论来源

### 9.3 Context Onboarding 页面

目标：

- 快速拿到最小必要上下文

要求：

- 4 个以内问题
- 每题可跳过
- 允许自由输入

### 9.4 Today With Me 页面

目标：

- 成为用户回来的主要入口

内容结构：

- 今日主线
- 今日最容易失衡点
- 一条建议
- 一个小动作
- 一个跟进问题

### 9.5 Ask About This 页面

目标：

- 延长线程生命周期

内容结构：

- 当前线程标题
- 历史摘要
- 当前问题输入框
- 回答
- 线程中的下一步建议

### 9.6 Weekly Pattern Recap 页面

目标：

- 让用户感到“它真的在观察我的 pattern”

内容结构：

- 本周主 tension
- 触发场景
- 已发生的变化
- 下周建议

## 10. 产品架构

## 10.1 信息架构

首版建议只有四个主导航：

1. `Read Me`
2. `Today`
3. `Ask`
4. `My Story`

说明：

- `Read Me`：自拍、画像、更新
- `Today`：daily guidance
- `Ask`：当前线程对话
- `My Story`：历史、记忆、weekly recap

## 10.2 领域对象

核心对象建议如下：

- `User`
- `UserProfile`
- `FaceProfile`
- `FaceReadingSnapshot`
- `ObservedFeature`
- `OfficialAssessment`
- `ZoneAssessment`
- `PalaceAssessment`
- `KnowledgeTopicHit`
- `RuleHit`
- `InterpretationArc`
- `TensionHypothesis`
- `ExplanationTrace`
- `MemoryItem`
- `TensionProfile`
- `GuidanceThread`
- `ThreadMessage`
- `DailyGuidance`
- `WeeklyRecap`
- `ConsentRecord`

## 10.3 记忆架构

首版不做无限记忆，先做四层：

### Layer 1：事实记忆

- 工作状态
- 感情状态
- 重要人物
- 当前目标

### Layer 2：tension 记忆

- 最担心失去什么
- 最想推进什么
- 当前最大压力源
- 最在意的决定

### Layer 3：线程记忆

- 当前主线程
- 历史线程
- 每个线程的阶段
- 上次建议与反馈

### Layer 4：总结记忆

- 本周 recurring pattern
- 哪些建议有效
- 哪些建议无效

## 10.4 AI 架构

建议拆成 9 条生成链路：

1. `Face Quality Gate`
   - 输入：自拍
   - 输出：是否单人、是否正脸、是否清晰、是否遮挡、关键区域是否可继续

2. `Structured Observation Extraction`
   - 输入：通过质量门的图片
   - 输出：脸型、额、眉、眼、鼻、口、耳、下庭、气色、纹痣疤等结构化观察结果

3. `Xiangxue System Grounding`
   - 输入：`ObservedFeature[]` + `/知识库`
   - 输出：`OfficialAssessment[]`、`ZoneAssessment[]`、`PalaceAssessment[]`、`KnowledgeTopicHit[]`

4. `Rule Synthesis`
   - 输入：观察结果 + 相学系统落点
   - 输出：`RuleHit[]`

5. `Interpretation Arc`
   - 输入：`RuleHit[]`
   - 输出：整体格局、内在结构、关系姿态、事业压力、防御方式等解释弧线

6. `Tension Hypothesis`
   - 输入：`InterpretationArc[]` + 用户最小上下文
   - 输出：`TensionHypothesis[]`

7. `Read Me Generation`
   - 输入：解释弧线 + tension 假设 + 风格约束
   - 输出：首版读图解释

8. `Context Profiling`
   - 输入：onboarding 问题答案
   - 输出：事实记忆 + tension 记忆

9. `Daily / Thread Generation`
   - 输入：线程状态 + 记忆 + 前次反馈 + 面相画像
   - 输出：当日 guidance 或线程延续回答

设计要求：

- 第 3-6 步是首版的核心，不允许被压缩成“一次模型调用”
- `Read Me` 的竞争力来自“相学分析与推理链”，不是“视觉识别能力”
- `/知识库` 中的五官、三停、十二宫、部位细相和主题索引必须进入服务端推理层

## 10.5 技术架构

建议未来采用：

### 客户端

- `FaceXiangiOS`：真正上架的 iOS App 宿主
- 后续可补 Web onboarding / funnel

### 业务模块

- `FaceXiangCore`：领域模型、规则、分析逻辑
- `FaceXiangMemory`：记忆与线程
- `FaceXiangAI`：模型适配、prompt orchestration、输出校验
- `FaceXiangFeatures`：Read Me / Today / Ask / Recap 编排

### 服务端

- API：用户、上传、线程、记忆、guidance
- Worker：图像处理、模型调用、摘要生成
- DB：用户、线程、记忆、分析快照、结果
- Storage：图片对象存储
- Queue：异步分析任务

### 基础设施

- iOS 客户端
- 后端 API
- 对象存储
- PostgreSQL
- Redis / Queue
- 监控和日志

## 10.6 身份与持久化策略

为兼顾 `iOS first` 与 `first aha` 低摩擦，v1 建议采用：

### 身份策略

- 默认 `anonymous cloud account`
- 首次启动即由服务端签发匿名 `user_id`
- 设备端将匿名身份写入 `Keychain`
- 后续可升级绑定 `Sign in with Apple`

说明：

- 不要求 first session 先登录
- 但线程、记忆、history 不做纯本地孤岛

### 数据归属

- 服务端为主存
- 本地为缓存
- 卸载重装后，只要匿名身份仍在 Keychain，可恢复连续关系

### 用户可控能力

- 查看当前主画像
- 编辑关键人物和当前主线
- 标记“这条不对”
- 删除图片、记忆和账号

## 11. 非功能要求

### 11.1 隐私

- 明确说明图片用途
- 支持删除图片与账号数据
- 默认不做不必要长期存图

### 11.2 安全与风控

- 结果中不输出医疗、法律、投资类建议
- 不使用命运决定论表述
- 对高风险情绪内容做边界回复

### 11.3 可解释性

- 关键输出要有“为什么这么判断”
- 对 deep guidance 输出保留 traceable explanation
- `Read Me` 必须能回溯到观察结果、相学系统落点和知识来源

### 11.4 稳定性

- 首次 Read Me 生成成功率目标 > 95%
- Today 生成成功率目标 > 98%

## 12. 成功指标

首版只盯以下指标：

- first aha 主观评分
- “是否像在说我”主观评分
- “是否讲清了我为什么会这样”主观评分
- Read Me 展开/读完率
- 首次自拍完成率
- Read Me 完成率
- Context Onboarding 完成率
- 次日回访率
- 7 日线程持续率
- 同一线程二次提问率
- Weekly Recap 查看率
- “感觉被理解”主观评分

## 13. 分阶段开发计划

建议分 5 个阶段推进。

### 阶段门槛原则

在进入 `Phase 3: Today With Me` 前，必须满足：

- first aha 主观评分达到预设阈值
- Read Me 中“为什么这么判断”理解度达标
- 样本用户普遍认为结果不是 generic 内容

如果上述门槛不达标，不应继续把资源投入留存功能扩写。

## Phase 0：定义与验证准备（1-2 周）

目标：

- 对齐产品定义、用户路径、模型边界

输出：

- 本 PRD 定稿
- 页面与交互设计文档
- 结果语气规范
- tension taxonomy
- 首版线程 taxonomy
- 样例文案 30-50 条

涉及角色：

- 产品
- 设计
- AI / Prompt
- 工程负责人

## Phase 1：Read Me MVP（2-4 周）

目标：

- 跑通自拍 -> 结构化观察 -> 相学推理 -> 首版读图结果

开发内容：

- 图片上传/拍照
- 图像质量检查
- 结构化观察链路
- `/知识库` 最小可用子集接入
- `ObservedFeature / OfficialAssessment / ZoneAssessment / PalaceAssessment / RuleHit / InterpretationArc / ExplanationTrace` 数据结构
- 面相基础分析与推理引擎
- Read Me 页面
- 分析中与失败回退状态
- 错误处理

验收标准：

- 用户能从自拍拿到完整首版结果
- 输出结构稳定
- 结果能体现相学分析过程，而不是部位标签堆叠
- 用户能看懂“为什么这么判断”
- 用户能明显感到产品在解释“为什么我会这样”
- 错误能被明确提示

## Phase 2：记忆与线程 MVP（2-3 周）

目标：

- 从一次性报告变成持续关系

开发内容：

- onboarding 问题
- 事实记忆层
- tension 记忆层
- 线程数据模型
- 记忆查看/纠错最小闭环
- Ask About This 页面
- 线程归类逻辑

验收标准：

- 用户可创建并持续一个线程
- 系统能记得上一次主题和背景

## Phase 3：Today With Me（2-3 周）

目标：

- 建立次日回访理由

开发内容：

- daily guidance 生成链路
- 今日主线算法
- 今日建议与小行动
- 回访埋点

验收标准：

- 用户次日打开能看到与其当前线程相关的 guidance
- 不出现 generic 运势式内容

## Phase 4：Weekly Pattern Recap（2 周）

目标：

- 建立一周级别价值感

开发内容：

- 线程摘要
- 本周 recurring pattern 检测
- recap 页面
- 推荐下一主线

验收标准：

- 系统能基于真实交互生成 recap
- 用户能明确感知“它在追踪我的 pattern”

## Phase 5：上线准备（2 周）

目标：

- 完成灰度与上架前准备

开发内容：

- 埋点完善
- 隐私协议
- 账号删除
- 订阅/IAP 预埋
- 崩溃监控
- App Store 元数据

验收标准：

- 可内测
- 可提交审核

## 14. 测试计划

测试按 4 层组织。

## 14.1 单元测试

范围：

- 面相规则映射
- tension 分类逻辑
- 线程归档逻辑
- weekly recap 生成逻辑

目标：

- 核心领域逻辑可回归

## 14.2 集成测试

范围：

- 自拍上传到识别结果
- onboarding 到记忆写入
- Ask 到线程更新
- Today 到回访状态更新

目标：

- 保证关键链路不断裂

## 14.3 AI 输出测试

范围：

- 输出结构是否稳定
- 是否命中 tension
- 是否有危险表达
- 是否出现过度空泛/模板化

方法：

- 固定样本集
- prompt regression
- 红队用例

重点检查：

- 是否做命运断言
- 是否做医疗/心理治疗暗示
- 是否有操控型语言

## 14.4 用户测试

范围：

- 首次 aha moment
- first aha 的“像在说我”强度
- 次日回访意愿
- 线程连续使用意愿

建议样本：

- 10-15 个深访用户
- 30-50 个轻量内测用户

重点问题：

- 哪句话最让你觉得“被说中”
- 哪句话最让你觉得空泛
- 你看得懂它为什么这么判断吗
- 你愿不愿意明天再回来
- 你觉得它记住你了吗

## 15. 每阶段测试重点

### Phase 1

- 识别成功率
- Read Me 稳定性
- 页面和错误态

### Phase 2

- 记忆正确率
- 线程归类准确性
- 上下文衔接

### Phase 3

- Today 与当前线程相关性
- guidance 非模板化程度
- 次日回访体验

### Phase 4

- recap 的可解释性
- recurring pattern 的用户认可度

### Phase 5

- 崩溃率
- 埋点完整性
- 审核风险排查

## 16. 团队建议配置

最小推进配置建议：

- 产品经理 / 创始人：1
- iOS 工程：1
- 后端工程：1
- AI / Prompt：1
- 设计：0.5-1
- QA：0.5

如果人更少，优先保证：

- 产品
- iOS
- 后端/AI 至少有一位能联动

## 17. 主要风险

### 17.1 首次输出不够锋利

风险：

- 用户看完觉得泛

应对：

- 用固定样本集反复打磨 first aha 文案

### 17.2 记忆错误破坏关系感

风险：

- 用户觉得系统并不懂我

应对：

- 首版限制记忆类型
- 允许用户编辑/纠正

### 17.3 Today 退化成 generic 内容

风险：

- 用户没有次日回访理由

应对：

- Today 强绑定当前线程

### 17.4 合规与审核风险

风险：

- 被判定为操控性、宿命论或治疗暗示

应对：

- 输出模板与审核词库前置

## 18. 里程碑建议

建议用 10-14 周完成首版内测。

### 里程碑 M1

- 完成 Read Me MVP

### 里程碑 M2

- 完成线程和记忆 MVP

### 里程碑 M3

- 完成 Today With Me

### 里程碑 M4

- 完成 Weekly Recap

### 里程碑 M5

- 完成内测上线准备

## 19. 下一步建议

在本文件基础上，建议立刻补两份执行文档：

1. `memory-thread-schema.md`
   - 定义记忆字段、线程状态、recap 结构

2. `v1-copy-and-prompt-spec.md`
   - 定义首版文案语气、prompt 结构、危险表达边界

3. `analysis-trace-spec.md`
   - 定义质量门、观察特征、规则命中、解释 trace、页面输出结构

4. `identity-memory-spec.md`
   - 定义匿名身份、记忆纠错、删除与恢复逻辑

5. `async-flow-and-fallback-spec.md`
   - 定义上传、分析中、超时、降级、失败回退体验

这样产品、设计、工程、AI 才能并行推进。
