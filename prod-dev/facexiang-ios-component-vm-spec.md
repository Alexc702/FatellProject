# FaceXiang iOS 组件树与 ViewModel 状态定义

## 1. 说明

本文件定义：

- iOS 首版组件树
- 页面级 ViewModel
- 全局状态与页面状态

实现口径仍以：

- [facexiang-ios-detailed-prd.md](/Users/lulu/Codex/FatellProject/docs/facexiang-ios-detailed-prd.md)
- [facexiang-page-interaction-design.md](/Users/lulu/Codex/FatellProject/docs/facexiang-page-interaction-design.md)

为准。

## 2. 根组件树

```text
FaceXiangiOSApp
└── RootView
    ├── LaunchGateView
    ├── FirstSessionCoordinatorView
    │   ├── HomeView
    │   ├── CaptureView
    │   ├── PhotoPreviewView
    │   ├── CameraPermissionDeniedSheet
    │   ├── QualityFailView
    │   ├── AnalyzingView
    │   ├── ReadMeView
    │   ├── ContextOnboardingView
    │   └── TodayFirstReadyView
    └── MainTabShellView
        ├── ReadMeTabView
        ├── TodayView
        ├── AskView
        └── MyStoryView
            ├── MemoryView
            ├── SettingsView
            └── DeleteConfirmationSheet
```

## 3. Shared 组件树

```text
Shared
├── Buttons
│   ├── PrimaryCTAButton
│   ├── SecondaryCTAButton
│   ├── GhostButton
│   └── DestructiveButton
├── Cards
│   ├── HeroCard
│   ├── ReadMeSectionCard
│   ├── ExpandableWhyCard
│   ├── EmptyStateCard
│   ├── StatusCard
│   └── MemoryItemCard
├── Input
│   ├── OptionChip
│   ├── MultiLineInput
│   └── ThreadInputBar
├── System
│   ├── AppTabBar
│   ├── ProgressStageList
│   ├── PermissionSheet
│   ├── DeleteConfirmationSheet
│   └── LoadingPlaceholder
└── Content
    ├── TensionBadge
    ├── ThreadSummaryCard
    ├── GuidanceCard
    └── TimelineEntryCard
```

## 4. 全局状态定义

## 4.1 AppRoute

```swift
enum AppRoute {
    case launching
    case firstSession(FirstSessionRoute)
    case mainTab(MainTabRoute)
}
```

## 4.2 FirstSessionRoute

```swift
enum FirstSessionRoute {
    case home
    case capture
    case photoPreview
    case qualityFail
    case analyzing
    case readMe
    case contextOnboarding
    case todayFirstReady
}
```

## 4.3 MainTabRoute

```swift
enum MainTabRoute {
    case readMe
    case today
    case ask
    case myStory
}
```

## 4.4 SessionStore

`SessionStore` 是全局唯一状态源。

建议持有：

```swift
struct SessionSnapshot {
    var hasAnonymousIdentity: Bool
    var hasCompletedReadMe: Bool
    var hasCompletedOnboarding: Bool
    var currentPrimaryTension: String?
    var currentThreadId: String?
    var currentReadMe: ReadMeOutput?
    var currentExplanationTrace: ExplanationTrace?
    var currentToday: DailyGuidance?
}
```

## 5. 页面组件树与 ViewModel

## 5.1 Home

### 组件树

```text
HomeView
├── BrandHeader
├── HeroSection
├── ProductPromiseCard
├── PrimaryCTAButton
├── SecondaryCTAButton
├── TrustInfoCard
└── LightHowItWorksCard
```

### ViewModel

```swift
struct HomeViewState {
    var mode: HomeMode
    var latestPrimaryTension: String?
}

enum HomeMode {
    case firstOpen
    case returningWithoutReadMe
    case returningWithReadMe
}
```

### 事件

- `primaryTapped`
- `libraryTapped`
- `howItWorksTapped`

## 5.2 Capture / Photo Preview

### 组件树

```text
CaptureView
├── NavigationHeader
├── CameraOrLibrarySurface
├── PhotoGuidelineList
├── PrimaryCTAButton
└── SecondaryCTAGroup
```

```text
PhotoPreviewView
├── NavigationHeader
├── PreviewImage
├── PhotoGuidelineList
├── PrimaryCTAButton
└── SecondaryCTAGroup
```

### ViewModel

```swift
struct CaptureViewState {
    var mode: CaptureMode
    var selectedImage: SelectedImage?
    var cameraPermission: PermissionState
    var photoPermission: PermissionState
}

enum CaptureMode {
    case cameraReady
    case photoPreview
    case cameraPermissionDenied
}

enum PermissionState {
    case notDetermined
    case granted
    case denied
}
```

### 事件

- `cameraOpened`
- `libraryOpened`
- `photoCaptured`
- `photoSelected`
- `confirmPhoto`
- `retake`
- `reselect`

## 5.3 Quality Fail

### 组件树

```text
QualityFailView
├── NavigationHeader
├── FailureTitle
├── FailureReasonCard
├── FixSuggestionCard
└── ActionGroup
```

### ViewModel

```swift
struct QualityFailViewState {
    var reason: QualityFailureReason
    var title: String
    var suggestion: String
}
```

### 事件

- `retryCameraTapped`
- `retryLibraryTapped`

## 5.4 Analyzing

### 组件树

```text
AnalyzingView
├── NavigationHeader
├── ProgressStageList
├── ExplanationLabel
├── TimeoutActionGroup
├── FailureActionGroup
└── PartialReadMeEntryCard
```

### ViewModel

```swift
struct AnalyzingViewState {
    var phase: AnalysisPhase
    var canShowRetry: Bool
    var canShowPartialReadMe: Bool
    var partialReadMe: ReadMeOutput?
}

enum AnalysisPhase {
    case qualityChecking
    case uploading
    case analyzing
    case timeout
    case failed(message: String)
    case partialReady
}
```

### 事件

- `continueWaitingTapped`
- `retryTapped`
- `usePartialReadMeTapped`
- `changePhotoTapped`

## 5.5 Read Me

### 组件树

```text
ReadMeView
├── NavigationHeader
├── HookSection
├── OverallPatternCard
├── InnerStructureCard
├── ExpandableWhyCard
├── NextQuestionCard
└── BottomActionBar
```

### ViewModel

```swift
struct ReadMeViewState {
    var mode: ReadMeMode
    var hook: String
    var overallPattern: String
    var innerStructure: [String]
    var whyCollapsedSummary: String
    var whyExpanded: WhyExpandedState
    var nextQuestion: String
}

enum ReadMeMode {
    case full
    case partial
    case refresh
}

struct WhyExpandedState {
    var observed: [String]
    var interpreted: [String]
    var tensionBridge: [String]
    var isExpanded: Bool
}
```

### 事件

- `whyExpanded`
- `continueToOnboardingTapped`
- `retakePhotoTapped`

## 5.6 Context Onboarding

### 组件树

```text
ContextOnboardingView
├── NavigationHeader
├── IntroLabel
├── ProgressIndicator
├── QuestionCard
│   ├── OptionChipGroup
│   └── FreeTextInput
└── BottomActionBar
```

### ViewModel

```swift
struct ContextOnboardingViewState {
    var step: Int
    var totalSteps: Int
    var questions: [OnboardingQuestion]
    var answers: [String: OnboardingAnswer]
    var currentQuestion: OnboardingQuestion
}

struct OnboardingQuestion {
    var id: String
    var title: String
    var options: [String]
    var allowsFreeText: Bool
}

struct OnboardingAnswer {
    var selectedOption: String?
    var freeText: String?
    var skipped: Bool
}
```

### 事件

- `optionSelected`
- `freeTextChanged`
- `nextTapped`
- `skipTapped`
- `backTapped`

## 5.7 Today First Ready / Today

### 组件树

```text
TodayView
├── NavigationHeader
├── TodayHeroCard
├── MainAxisCard
├── ImbalanceCard
├── SmallActionCard
├── FollowUpQuestionCard
└── BottomActionBar
```

### ViewModel

```swift
struct TodayViewState {
    var mode: TodayMode
    var title: String?
    var mainAxis: String?
    var imbalancePoint: String?
    var smallAction: String?
    var followUpQuestion: String?
}

enum TodayMode {
    case locked
    case loading
    case firstReady
    case ready
}
```

### 事件

- `gotoAskTapped`
- `acceptTodayTapped`
- `refreshTapped`
- `gotoReadMeTapped`

## 5.8 Ask

### 组件树

```text
AskView
├── NavigationHeader
├── ThreadTitle
├── ThreadSummaryCard
├── MessageList
├── SuggestionPromptCard
└── ThreadInputBar
```

### ViewModel

```swift
struct AskViewState {
    var mode: AskMode
    var threadTitle: String?
    var threadSummary: String?
    var messages: [ThreadMessage]
    var draft: String
    var suggestedQuestion: String?
}

enum AskMode {
    case locked
    case bootstrapping
    case ready
    case awaitingResponse
}
```

### 事件

- `sendTapped`
- `draftChanged`
- `suggestionTapped`
- `gotoReadMeTapped`

## 5.9 My Story

### 组件树

```text
MyStoryView
├── NavigationHeader
├── PrimaryTensionCard
├── CurrentThreadCard
├── RecentSevenDaysCard
├── MemoryEntryCard
├── WeeklyRecapPlaceholderCard
└── TimelineSection
```

### ViewModel

```swift
struct MyStoryViewState {
    var mode: MyStoryMode
    var primaryTension: String?
    var currentThreadTitle: String?
    var recentSummary: [String]
    var timeline: [TimelineEntry]
}

enum MyStoryMode {
    case locked
    case empty
    case ready
}

struct TimelineEntry {
    var date: String
    var type: String
    var summary: String
}
```

### 事件

- `memoryTapped`
- `gotoReadMeTapped`
- `viewAllTimelineTapped`

## 5.10 Memory

### 组件树

```text
MemoryView
├── NavigationHeader
├── ImportantPeopleSection
├── CurrentFocusSection
├── MemoryList
│   └── MemoryItemCard
└── AddMemoryButton
```

### ViewModel

```swift
struct MemoryViewState {
    var mode: MemoryMode
    var items: [MemoryItem]
    var editingItemId: String?
}

enum MemoryMode {
    case loading
    case list
    case editing
    case empty
}
```

### 事件

- `editTapped`
- `suppressTapped`
- `deleteTapped`
- `addTapped`

## 5.11 Settings

### 组件树

```text
SettingsView
├── NavigationHeader
├── PrivacySection
├── PhotoManagementSection
├── MemoryManagementSection
└── AccountDangerSection
```

### ViewModel

```swift
struct SettingsViewState {
    var hasAnonymousIdentity: Bool
    var canDeletePhotos: Bool
    var canDeleteMemory: Bool
}
```

### 事件

- `deletePhotoTapped`
- `deleteMemoryTapped`
- `deleteAccountTapped`

## 5.12 Delete Confirmation

### 组件树

```text
DeleteConfirmationSheet
├── Title
├── Explanation
├── ConsequenceList
└── ActionButtons
```

### ViewModel

```swift
struct DeleteConfirmationViewState {
    var target: DeleteTarget
    var title: String
    var explanation: String
    var destructiveButtonTitle: String
}

enum DeleteTarget {
    case photo
    case memory
    case account
}
```

### 事件

- `confirmTapped`
- `cancelTapped`

## 6. Service Adapter 结构

```text
Services
├── SessionService
├── AnalysisService
├── TodayService
├── ThreadService
└── MemoryService
```

协议建议：

```swift
protocol SessionServiceProtocol
protocol AnalysisServiceProtocol
protocol TodayServiceProtocol
protocol ThreadServiceProtocol
protocol MemoryServiceProtocol
```

## 7. 状态管理约束

### 7.1 单一事实来源

- 全局身份、主 tension、线程 ID、当前 `Read Me` 放在 `SessionStore`
- 页面临时状态只放在页面级 ViewModel

### 7.2 页面不得直接拼接业务文案

- `ReadMeOutput / DailyGuidance / GuidanceThread` 先转成 `ViewState`
- 页面只消费 `ViewState`

### 7.3 页面不得直接触达底层识别器

- `ViewModel -> Service Protocol -> Adapter -> FaceXiangCore`

## 8. 最小实现优先级

最先需要定义完成的状态和组件：

1. `SessionStore`
2. `AppRoute / FirstSessionRoute / MainTabRoute`
3. `CaptureViewState`
4. `AnalyzingViewState`
5. `ReadMeViewState`
6. `ContextOnboardingViewState`
7. `TodayViewState`

因为这 7 个对象决定了首版 first session 是否能真正跑通。
