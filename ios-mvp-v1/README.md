# FaceXiang iOS MVP v1

这是一个全新重建的 iOS v1 工程目录。

原则：

- 不延用旧 `ios-mvp` 的页面、ViewModel 和产品契约
- 直接按 `/prod-dev` 的 v1 计划实现
- 先搭建正式 iOS App 宿主与 `first aha` 路径

当前结构：

- `FaceXiangiOS.xcodeproj`：正式 iOS App 工程
- `FaceXiangiOS/Sources/App`：App 入口、根路由、全局状态
- `FaceXiangiOS/Sources/DesignSystem`：首版共享样式和基础组件
- `FaceXiangiOS/Sources/Features`：First Session 与 Main Tab 页面骨架

当前目标：

- 跑通 `Home -> Capture -> Analyzing -> Read Me -> Context Onboarding -> Today First Ready`
- 提供 `读我 / 今日 / 继续问 / 我的主线` 四个 tab 壳
- 后续再接真实分析链、图片输入、线程和记忆
