# FaceXiang v1 Memory & Thread Schema

## 1. 目标

本文件定义首版可直接落库和落接口的核心对象：

- 用户
- 记忆
- 线程
- Today
- Weekly Recap

## 2. User

```ts
type User = {
  userId: string
  identityType: "anonymous" | "apple"
  createdAt: string
  lastActiveAt: string
  status: "active" | "deleted"
}
```

## 3. UserProfile

```ts
type UserProfile = {
  userId: string
  displayName?: string
  locale: string
  timezone: string
  preferredFocus?: "work" | "relationship" | "inner_state"
  currentPrimaryThreadId?: string
}
```

## 4. FaceReadingSnapshot

```ts
type FaceReadingSnapshot = {
  snapshotId: string
  userId: string
  imageId: string
  qualityPassed: boolean
  faceProfileId: string
  readMeVersion: string
  createdAt: string
}
```

## 5. MemoryItem

```ts
type MemoryItem = {
  memoryId: string
  userId: string
  category:
    | "fact"
    | "tension"
    | "relationship"
    | "thread"
    | "summary"
  key: string
  value: string
  source: "user_input" | "user_correction" | "ai_inference" | "system_summary"
  confidence: number
  status: "active" | "needs_confirmation" | "suppressed" | "deleted"
  isSensitive: boolean
  lastConfirmedAt?: string
  createdAt: string
  updatedAt: string
}
```

## 6. TensionProfile

```ts
type TensionProfile = {
  tensionId: string
  userId: string
  tensionType:
    | "fear_of_loss"
    | "fear_of_rejection"
    | "decision_anxiety"
    | "self_worth_instability"
    | "relationship_ambiguity"
    | "control_pressure"
    | "attraction_uncertainty"
  strength: number
  source: "face_reading" | "user_input" | "thread_summary"
  status: "primary" | "secondary" | "historical"
  createdAt: string
  updatedAt: string
}
```

## 7. GuidanceThread

```ts
type GuidanceThread = {
  threadId: string
  userId: string
  type:
    | "relationship"
    | "career_direction"
    | "self_worth"
    | "decision_conflict"
    | "emotional_balance"
  title: string
  primaryTensionId: string
  phase:
    | "problem_seen"
    | "emotion_unpacked"
    | "resistance_identified"
    | "action_defined"
    | "reflection_done"
    | "recalibrating"
    | "closed"
  status: "active" | "paused" | "closed"
  startedAt: string
  lastActiveAt: string
}
```

## 8. ThreadMessage

```ts
type ThreadMessage = {
  messageId: string
  threadId: string
  role: "user" | "assistant" | "system"
  content: string
  summary?: string
  createdAt: string
}
```

## 9. DailyGuidance

```ts
type DailyGuidance = {
  guidanceId: string
  userId: string
  threadId: string
  date: string
  imbalancePoint: string
  noticePoint: string
  smallAction: string
  followupQuestion: string
  createdAt: string
}
```

## 10. WeeklyRecap

```ts
type WeeklyRecap = {
  recapId: string
  userId: string
  weekKey: string
  dominantTension: string
  triggerScenarios: string[]
  progressSignals: string[]
  nextSuggestedThreadType?: GuidanceThread["type"]
  createdAt: string
}
```

## 11. 线程状态流转

建议的首版流转：

1. `problem_seen`
2. `emotion_unpacked`
3. `resistance_identified`
4. `action_defined`
5. `reflection_done`
6. `recalibrating`
7. `closed`

说明：

- v1 不需要强制用户线性通过全部状态
- 但需要服务端知道当前线程大致处在哪一阶段

## 12. 首版 API 最小集合

建议至少有：

- `POST /anonymous-users`
- `POST /images`
- `POST /read-me`
- `POST /onboarding`
- `GET /threads/current`
- `POST /threads/:id/messages`
- `GET /guidance/today`
- `GET /recaps/current-week`
- `PATCH /memory/:id`
- `DELETE /user-data`

