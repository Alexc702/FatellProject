# FaceXiang v1 Analysis Trace Spec

## 1. 目标

本文件定义首版 `Read Me` 的分析与推理契约。

首版要做的不是：

- 识别五官位置
- 输出几段好听文案
- 做一个“看图写性格”的 VLM demo

首版真正要做的是：

`图片 -> 质量门 -> 结构化观察 -> 相学知识落点 -> 多层推理 -> 当前 tension -> first aha 输出`

也就是说，`Read Me` 的灵魂不在“识别到什么”，而在“这些部位、结构、气色与纹路，如何通过相学体系被解释成一个人当前的内在张力、关系姿态与现实卡点”。

## 2. 知识底座

首版推理必须显式建立在 `/知识库` 的结构化材料之上，而不是只靠 prompt 常识发挥。

当前 v1 必须接入的知识层包括：

- `五官系统`
  - 耳：采听官
  - 眉：保寿官
  - 眼：监察官
  - 鼻：审辨官
  - 口：出纳官
- `三停系统`
  - 上停：先天基础、思维、少年运
  - 中停：行动、事业、社会表现、中年运
  - 下停：情欲、享受、归宿、晚运
- `十二宫系统`
  - 命宫、财帛宫、夫妻宫、疾厄宫、官禄宫、福德宫等
- `部位细相`
  - 眉、眼、耳、鼻、口、额、山根、印堂、鱼尾、鼻翼、地阁等
- `主题索引`
  - 性格、关系、事业、财运、健康倾向、用人法、整体格局
- `原文溯源`
  - 每条核心判断都应能回到 `/知识库` 的主题 chunk、页标题或原文摘要

首版不要求把整本书全做完，但至少要把以下主题做成可用推理层：

- 五官总纲
- 三停
- 十二宫
- 额相
- 眉相
- 眼相
- 鼻相
- 口相
- 部位细相

## 3. 设计原则

### 3.1 先相学语义，后用户文案

- 图像层负责“看到什么”
- 相学层负责“这些东西在体系里意味着什么”
- 文案层负责“把推理说成人能感到被说中的话”

### 3.2 先整体格局，后单点结论

首版不能做成：

- 鼻子怎样 = 财运怎样
- 眼尾怎样 = 感情怎样

而要先看：

- 整体脸型与骨肉比例
- 五官之间的协调度
- 三停是否均衡
- 哪个宫位和哪个官最突出或最失衡

然后才进入单点判断。

### 3.3 先多层交叉，再落 tension

一个能打中用户的 first aha，必须至少经过两层以上交叉：

- `观察层`
- `相学系统层`
- `人生主题层`
- `当前 tension 层`

禁止单一特征直接跳到强结论。

### 3.4 先解释“你为什么会这样”，再给建议

`Read Me` 的第一任务不是给方法，而是让用户觉得：

- 这不是模板
- 这不是泛安慰
- 它真的看到了我身上的某种结构和惯性

### 3.5 保留文化解释感，但不做宿命论

首版可以提供：

- 性格倾向
- 防御方式
- 关系姿态
- 当前更容易失衡的主题

首版不应直接提供：

- 命定结果
- 医疗判断
- 法律/投资判断
- 无证据支持的灾祸式断言

## 4. 分析链路总览

### Step 1：Photo Intake

输入：

- 用户自拍/相册照片

输出：

- `ImageAsset`

### Step 2：Face Quality Gate

检查：

- 是否单人
- 是否正脸
- 是否清晰
- 是否亮度可用
- 是否遮挡严重
- 是否足够看清额头、眉眼、鼻、口、下庭

输出：

- `FaceQualityAssessment`

如果失败：

- 不进入后续相学分析
- 返回具体重拍建议

### Step 3：Structured Observation Extraction

目标：

- 抽取进入相学层所需的结构化观察结果

包括但不限于：

- 脸型与轮廓
- 额头宽窄、饱满度、平整度
- 眉形、眉距、浓淡、顺逆
- 眼型、眼神、眼尾、卧蚕/下睑
- 山根、鼻梁、鼻头、鼻翼、鼻孔
- 唇形、口角、闭合感
- 耳位、耳厚、耳轮
- 下巴、地阁、法令、印堂、气色、明显纹痣疤

输出：

- `ObservedFeature[]`

说明：

- v1 可用 VLM 做观察抽取
- 但必须只输出结构化 JSON
- 此阶段仍不生成用户结果文案

### Step 4：Xiangxue System Grounding

目标：

- 将观察结果映射到相学体系中的“系统落点”

首版至少完成 4 类落点：

1. `五官落点`
2. `三停落点`
3. `十二宫落点`
4. `部位细相主题落点`

输出：

- `OfficialAssessment[]`
- `ZoneAssessment[]`
- `PalaceAssessment[]`
- `KnowledgeTopicHit[]`

### Step 5：Rule Synthesis

目标：

- 将“看到的部位”转成“可解释的相学判断”

这一步不是简单规则匹配，而是做 3 层合成：

1. `局部语义`
   - 某个部位的典型含义
2. `系统语义`
   - 五官、三停、十二宫之间是否互相加强或互相抵消
3. `主题语义`
   - 更靠近关系、事业、自我价值、控制感还是情绪稳定

输出：

- `RuleHit[]`
- `InterpretationArc[]`

### Step 6：Tension Hypothesis

目标：

- 根据解释弧线和最小上下文，推断用户当前最可能卡住的 tension

输出：

- `TensionHypothesis[]`

### Step 7：Read Me Generation

目标：

- 生成首版用户可读结果

要求：

- 必须体现“整体格局 + 当前张力”
- 必须有“为什么这么判断”
- 必须让用户感到这是一段解释，而不是一串标签

输出：

- `ReadMeOutput`

## 5. 数据契约

## 5.1 ImageAsset

```ts
type ImageAsset = {
  imageId: string
  source: "camera" | "library"
  width: number
  height: number
  mimeType: "image/jpeg" | "image/png"
  createdAt: string
}
```

## 5.2 FaceQualityAssessment

```ts
type FaceQualityAssessment = {
  passed: boolean
  singleFace: boolean
  frontalScore: number
  clarityScore: number
  lighting: "bright" | "balanced" | "dim" | "backlit"
  occlusion: "none" | "low" | "medium" | "high"
  regionVisibility: {
    forehead: "clear" | "partial" | "blocked"
    eyebrows: "clear" | "partial" | "blocked"
    eyes: "clear" | "partial" | "blocked"
    nose: "clear" | "partial" | "blocked"
    mouth: "clear" | "partial" | "blocked"
    chin: "clear" | "partial" | "blocked"
  }
  failureReasons: QualityFailureReason[]
}

type QualityFailureReason =
  | "no_face"
  | "multiple_faces"
  | "low_clarity"
  | "not_frontal"
  | "poor_lighting"
  | "heavy_occlusion"
  | "key_region_missing"
```

## 5.3 ObservedFeature

```ts
type ObservedFeature = {
  featureId: string
  area:
    | "forehead"
    | "eyebrows"
    | "eyes"
    | "nose"
    | "mouth"
    | "ears"
    | "chin"
    | "midface"
    | "complexion"
    | "lines_marks"
  subArea?: string
  signalType:
    | "shape"
    | "width"
    | "height"
    | "fullness"
    | "symmetry"
    | "texture"
    | "color"
    | "line_mark"
    | "spacing"
  value: string
  confidence: number
  evidence: string
}
```

说明：

- `ObservedFeature` 只是观察结果，不是解释结果
- 比如“印堂偏窄”“鼻翼偏薄”“山根偏低”“眼尾细纹明显”都属于观察层

## 5.4 OfficialAssessment

```ts
type OfficialAssessment = {
  officialId:
    | "caiting_guan"
    | "baoshou_guan"
    | "jiancha_guan"
    | "shenbian_guan"
    | "chuna_guan"
  name: "ear" | "brow" | "eye" | "nose" | "mouth"
  observedFeatureIds: string[]
  strengths: string[]
  risks: string[]
  xiangxueMeaning: string
  weight: number
}
```

作用：

- 把五官从“器官”变成“功能”
- 例如：
  - `眼/监察官` 更偏洞察、判断、情绪感知
  - `鼻/审辨官` 更偏主见、执行、现实承载与财帛

## 5.5 ZoneAssessment

```ts
type ZoneAssessment = {
  zoneId: "upper" | "middle" | "lower"
  observedFeatureIds: string[]
  balance: "weak" | "balanced" | "dominant"
  xiangxueMeaning: string
  userFacingMeaning: string
  weight: number
}
```

作用：

- 不是给用户讲“上停中停下停”的术语
- 而是解释：
  - 你更偏思维型还是行动型
  - 你在关系与欲望层更强还是更收
  - 你当前的结构更像“脑内拉扯”还是“现实承压”

## 5.6 PalaceAssessment

```ts
type PalaceAssessment = {
  palaceId:
    | "ming"
    | "caibo"
    | "xiongdi"
    | "fuqi"
    | "zinv"
    | "jie"
    | "qianyi"
    | "nupu"
    | "guanlu"
    | "tianzhai"
    | "fude"
    | "fumu"
  name: string
  region: string
  observedFeatureIds: string[]
  status: "supported" | "tense" | "unclear"
  xiangxueMeaning: string
  userFacingMeaning: string
  weight: number
}
```

作用：

- 把“人生哪个领域更值得被看”结构化
- v1 不要求 12 宫全部强解读
- 但首版必须稳定支持：
  - `命宫`
  - `夫妻宫`
  - `财帛宫`
  - `疾厄宫`
  - `官禄宫`
  - `福德宫`

## 5.7 KnowledgeTopicHit

```ts
type KnowledgeTopicHit = {
  topicId: string
  topicType:
    | "five_officials"
    | "three_zones"
    | "twelve_palaces"
    | "feature_topic"
    | "theme_topic"
  title: string
  matchedFeatureIds: string[]
  summary: string
  sourceRefs: EvidenceCitation[]
  confidence: number
}
```

## 5.8 EvidenceCitation

```ts
type EvidenceCitation = {
  sourceFile:
    | "xiangxue_knowledge_complete_149p.json"
    | "xiangxue_rag_min.json"
    | "xiangxue_knowledge_ai_kg.json"
  pageTitle?: string
  chunkId?: string
  excerpt: string
}
```

作用：

- 用于内部 trace 与质检
- 用户界面只展示压缩后的“为什么这么判断”
- 但系统必须知道这段判断是从哪一类知识来的

## 5.9 RuleHit

```ts
type RuleHit = {
  ruleId: string
  category:
    | "overall_pattern"
    | "five_officials"
    | "three_zones"
    | "twelve_palaces"
    | "relationship"
    | "career"
    | "self"
    | "defense"
    | "attraction"
  observedFeatureIds: string[]
  supportingTopicIds: string[]
  xiangxueMeaning: string
  userFacingMeaning: string
  weight: number
}
```

## 5.10 InterpretationArc

```ts
type InterpretationArc = {
  arcId: string
  title: string
  summary: string
  supportingRuleIds: string[]
  dominantTheme:
    | "impression"
    | "self_protection"
    | "relationship_pattern"
    | "career_drive"
    | "control_and_security"
    | "emotional_load"
  confidence: number
}
```

作用：

- `InterpretationArc` 承担“灵魂”层
- 它不是一句规则，而是一段结构化解释
- 比如：
  - 外在克制，但内里紧张
  - 对关系敏感，但更习惯先收而不是先要
  - 主见强，但做决定时容易背太多现实压力

## 5.11 TensionHypothesis

```ts
type TensionHypothesis = {
  hypothesisId: string
  tensionType:
    | "fear_of_loss"
    | "fear_of_rejection"
    | "decision_anxiety"
    | "self_worth_instability"
    | "relationship_ambiguity"
    | "control_pressure"
    | "attraction_uncertainty"
  confidence: number
  supportingArcIds: string[]
  supportingRuleIds: string[]
  explanation: string
}
```

## 5.12 ExplanationTrace

```ts
type ExplanationTrace = {
  primaryObservedFeatures: string[]
  primaryOfficialAssessments: string[]
  primaryZoneAssessments: string[]
  primaryPalaceAssessments: string[]
  primaryRuleHits: string[]
  primaryInterpretationArcs: string[]
  primaryTensionHypotheses: string[]
  evidenceRefs: EvidenceCitation[]
  whySummary: string
}
```

## 5.13 ReadMeOutput

```ts
type ReadMeOutput = {
  hookLine: string
  overallPattern: string
  relationshipSignal: string
  careerOrRealitySignal: string
  defensePattern: string
  attractionPattern: string
  primaryTension: string
  whyThisFeelsTrue: string
  nextQuestion: string
  trace: ExplanationTrace
}
```

## 6. 推理规则

## 6.1 不允许单点强推断

以下判断必须至少由两类证据共同支持：

- 关系 tension
- 事业 tension
- 自我价值 tension
- 控制感/安全感 tension

支持来源至少满足下面之一：

- `五官 + 三停`
- `五官 + 十二宫`
- `部位细相 + 十二宫`
- `整体格局 + 部位细相`

## 6.2 先做“整体基调”，再做“当前主线”

`Read Me` 的推理顺序应为：

1. 先给出整体气质与外在给人的感受
2. 再判断内在惯性和防御方式
3. 再判断现在更容易卡住的人生主题
4. 最后落到当前 tension

## 6.3 十二宫主要决定“领域”，不是单独决定结论

例如：

- `夫妻宫` 更多决定“关系主题是否被激活”
- `官禄宫` 更多决定“事业和选择压力是否突出”
- `命宫` 更多决定“整体心态与主见的张力”

它们不是单独一句话就能决定全部结论，必须与整体结构结合。

## 6.4 三停主要决定“能量分布”

例如：

- 上停偏强：更容易活在思维、判断、预设与脑内拉扯里
- 中停偏强：更偏现实执行、社会位置、责任与压力
- 下停偏强：更偏情欲、归属、关系回应与安全感

这层是把用户从“部位解释”拉到“人格动力学解释”的关键。

## 6.5 五官主要决定“功能倾向”

例如：

- `眉/保寿官`：持续力、秩序感、原则感
- `眼/监察官`：观察、敏感度、关系感知
- `鼻/审辨官`：主见、现实感、承压与财帛主题
- `口/出纳官`：表达、承诺、情绪出口与人际互动
- `耳/采听官`：接收、感知、根基与承受方式

## 6.6 first aha 的核心不是“像不像我”，而是“为什么总这样”

所以 `Read Me` 至少要回答两件事：

- 你现在的主要 tension 是什么
- 这个 tension 背后更深的结构是什么

## 7. 页面输出契约

## 7.1 Read Me 页面必须展示的 5 块内容

1. `整体格局`
   - 这张脸先给人什么感受
   - 你更偏收、偏稳、偏敏感，还是偏强推进
2. `内在结构`
   - 五官与三停交叉后，当前更典型的防御方式或惯性
3. `当前主线`
   - 十二宫与部位细相指向的关系/事业/自我主题
4. `为什么这么判断`
   - 不是列规则 ID
   - 而是把“看到的部位 -> 相学意义 -> tension”讲清楚
5. `下一步入口`
   - 引出 onboarding 或 thread 的第一个问题

## 7.2 “为什么这么判断”必须来自结构化 trace

用户能看到的是压缩后的解释，但系统内部必须能回溯：

- 观察到什么
- 落到了哪几个官、停、宫
- 命中了哪些相学主题
- 为什么把它们合成为当前 tension

## 8. Prompt 约束

## 8.1 Observation Prompt

要求：

- 只输出 JSON
- 只输出结构化观察结果
- 不输出相学解释
- 不输出建议
- 不输出命运判断

## 8.2 Reasoning Prompt

输入必须包含：

- `ObservedFeature[]`
- `OfficialAssessment[]`
- `ZoneAssessment[]`
- `PalaceAssessment[]`
- `KnowledgeTopicHit[]`
- `RuleHit[]`
- `TensionHypothesis[]`

禁止输入：

- 原始图片
- 无来源的自由发挥结论

要求：

- 先输出推理结构，再输出用户文案
- 优先解释结构冲突与张力，不堆术语

## 8.3 Copy Prompt

文案必须做到：

- 有命中感，但不神神叨叨
- 有解释感，但不堆知识点
- 有情绪承接，但不替代治疗
- 有东方语义感，但不复制古文腔

## 9. v1 技术策略建议

v1 推荐链路：

- 图像质量门：模型或视觉服务完成
- 结构化观察：VLM + schema 约束
- 相学落点：服务端规则层 + `/知识库` 检索
- 解释弧线与 tension：规则合成 + 轻量模型辅助
- 最终文案：LLM 生成

这样首版即使视觉抽取还不够强，也不会退化成“看图直接吐一篇内容”。

## 10. 测试与验收

## 10.1 单元测试

- 五官、三停、十二宫映射是否稳定
- `RuleHit` 是否正确挂到知识主题
- `InterpretationArc` 是否能由多证据支持
- tension 映射是否稳定
- trace 是否完整

## 10.2 AI 回归测试

- 相同输入下结构化字段稳定
- 不输出额外字段
- 不跳过相学落点直接写结论
- 不输出宿命论

## 10.3 用户测试

验证以下问题：

- 你觉得它是在识别脸，还是在分析你
- 哪一段最像“说中了你为什么总会这样”
- “为什么这么判断”是否能让你信服
- 你会不会觉得它只是从一个部位硬扯结论

## 11. Phase 1 验收门槛

进入后续线程与留存开发前，至少满足：

- `Read Me` 可稳定生成
- 结果里能明显看出“整体格局 + 当前 tension”，而不是部位罗列
- `why` 模块可读且有依据
- 固定样本集里大多数结果不被用户评价为“像模板”
- 样本用户能复述出“它说我为什么会这样”
- 失败重拍建议准确可执行
