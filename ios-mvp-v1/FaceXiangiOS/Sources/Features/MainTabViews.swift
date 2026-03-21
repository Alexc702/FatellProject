import SwiftUI

struct MainTabShellView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        TabView(selection: Binding(
            get: { sessionStore.selectedTab },
            set: { sessionStore.selectTab($0) }
        )) {
            NavigationStack {
                ReadMeTabView()
            }
            .tabItem {
                Label("读我", systemImage: "sparkles.rectangle.stack")
            }
            .tag(MainTabRoute.readMe)

            NavigationStack {
                TodayView()
            }
            .tabItem {
                Label("今日", systemImage: "sun.max")
            }
            .tag(MainTabRoute.today)

            NavigationStack {
                AskView()
            }
            .tabItem {
                Label("继续问", systemImage: "bubble.left.and.bubble.right")
            }
            .tag(MainTabRoute.ask)

            NavigationStack {
                MyStoryView()
            }
            .tabItem {
                Label("我的主线", systemImage: "book.closed")
            }
            .tag(MainTabRoute.myStory)
        }
        .tint(AppTheme.accent)
    }
}

struct ReadMeTabView: View {
    var body: some View {
        ReadMeView()
            .navigationTitle("读我")
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct TodayView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            if let today = sessionStore.appSession?.todayGuidance {
                SectionTitle(
                    eyebrow: "Today",
                    title: "今天，先沿着这一条主线走",
                    bodyText: "Today 不是日签，而是延续你当前 tension 的一条提醒。"
                )

                PageCard(title: "今日主线") {
                    Text(today.noticePoint)
                        .font(AppFont.title(22))
                    Text(today.imbalancePoint)
                        .font(AppFont.body(15))
                        .foregroundStyle(AppTheme.muted)
                }

                PageCard(title: "一个小行动") {
                    Text(today.smallAction)
                        .font(AppFont.body(16))
                    Text(today.followupQuestion)
                        .font(AppFont.body(15))
                        .foregroundStyle(AppTheme.muted)
                }
            } else {
                EmptyShellCard(
                    title: "先完成第一次画像",
                    bodyText: "Today 会围绕你的当前主线生成，而不是给所有人同一张卡片。",
                    cta: "先去完成 Read Me"
                ) {
                    sessionStore.goToCapture()
                }
            }
        }
        .navigationTitle("今日")
    }
}

struct AskView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            if let thread = sessionStore.currentThread {
                SectionTitle(
                    eyebrow: "Ask",
                    title: thread.title,
                    bodyText: "这里不是重新开始，而是围绕你当前主线往下拆。"
                )

                PageCard(title: "线程状态") {
                    Text("阶段：\(thread.phase)")
                        .font(AppFont.body(15))
                        .foregroundStyle(AppTheme.muted)
                    if let tension = sessionStore.currentTension {
                        Text("当前 tension：\(tension.tensionType)")
                            .font(AppFont.body(14))
                            .foregroundStyle(AppTheme.muted)
                    }
                }

                PageCard(title: "对话") {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(sessionStore.currentThreadMessages.suffix(6)) { message in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(message.role == "assistant" ? "顾问" : "你")
                                    .font(AppFont.title(14))
                                Text(message.content)
                                    .font(AppFont.body(15))
                                    .foregroundStyle(message.role == "assistant" ? AppTheme.ink : AppTheme.muted)
                            }
                            .padding(12)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .background(message.role == "assistant" ? Color.white.opacity(0.56) : Color.white.opacity(0.32))
                            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
                        }
                    }
                }

                PageCard(title: "继续问") {
                    TextField("把你现在最想继续拆的问题写下来", text: $sessionStore.currentDraftMessage, axis: .vertical)
                        .textFieldStyle(.roundedBorder)
                    PrimaryCTAButton(title: "发送") {
                        sessionStore.sendCurrentMessage()
                    }
                }
            } else {
                EmptyShellCard(
                    title: "先建立你的主线线程",
                    bodyText: "Ask 会接在当前 tension 后面，不是泛聊天。",
                    cta: "先完成 Read Me"
                ) {
                    sessionStore.goToCapture()
                }
            }
        }
        .navigationTitle("继续问")
    }
}

struct MyStoryView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            if let thread = sessionStore.currentThread,
               let tension = sessionStore.currentTension {
                SectionTitle(
                    eyebrow: "My Story",
                    title: "它现在记得你的，是这一条主线",
                    bodyText: "这里先展示当前主 tension、当前主线程和最近 7 天的摘要，而不是一条散乱时间线。"
                )

                PageCard(title: "当前主 tension") {
                    Text(sessionStore.currentReadMeOutput?.primaryTension ?? tension.tensionType)
                        .font(AppFont.title(22))
                    Text(thread.title)
                        .font(AppFont.body(15))
                        .foregroundStyle(AppTheme.muted)
                }

                PageCard(title: "最近 7 天摘要") {
                    Text(sessionStore.appSession?.weeklyRecap?.triggerScenarios.joined(separator: "；") ?? "你的主线还在形成。")
                        .font(AppFont.body(15))
                        .foregroundStyle(AppTheme.muted)
                }

                PageCard(title: "Memory") {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("关键人物")
                            .font(AppFont.title(16))
                        ForEach(sessionStore.currentMemories.filter { $0.category == "relationship" }) { item in
                            Text("• \(item.value)")
                                .font(AppFont.body(15))
                        }
                        Text("已确认记忆")
                            .font(AppFont.title(16))
                            .padding(.top, 6)
                        ForEach(sessionStore.currentMemories.filter { $0.status == "active" || $0.status == "needs_confirmation" }) { item in
                            Text("• \(item.value)")
                                .font(AppFont.body(15))
                        }
                    }
                }

                VStack(spacing: 12) {
                    PrimaryCTAButton(title: "查看 Memory") {
                        sessionStore.showingMemorySheet = true
                    }
                    SecondaryCTAButton(title: "设置与删除") {
                        sessionStore.showingSettingsSheet = true
                    }
                }
            } else {
                EmptyShellCard(
                    title: "你的主线还没形成",
                    bodyText: "完成 Read Me 和第一次承接后，这里才会开始显示它正在记得你的是什么。",
                    cta: "先去完成 Read Me"
                ) {
                    sessionStore.goToCapture()
                }
            }
        }
        .navigationTitle("我的主线")
        .sheet(isPresented: $sessionStore.showingMemorySheet) {
            NavigationStack { MemoryView() }
        }
        .sheet(isPresented: $sessionStore.showingSettingsSheet) {
            NavigationStack { SettingsView() }
        }
    }
}

struct MemoryView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        ScreenContainer {
            if !sessionStore.currentMemories.isEmpty {
                SectionTitle(
                    eyebrow: "Memory",
                    title: "你可以检查它现在记得了什么",
                    bodyText: "首版先支持确认、不要再提和删除，避免关系感被错记内容破坏。"
                )

                ForEach(sessionStore.currentMemories) { memory in
                    PageCard(title: memory.key) {
                        VStack(alignment: .leading, spacing: 10) {
                            Text(memory.value)
                                .font(AppFont.body(15))
                            Text("来源：\(memory.source) · 状态：\(memory.status)")
                                .font(AppFont.body(13))
                                .foregroundStyle(AppTheme.muted)

                            HStack(spacing: 10) {
                                SecondaryCTAButton(title: "确认") {
                                    sessionStore.confirmMemory(memory)
                                }
                                SecondaryCTAButton(title: "不要再提") {
                                    sessionStore.suppressMemory(memory)
                                }
                            }
                            PrimaryCTAButton(title: "删除这条记忆") {
                                sessionStore.deleteMemory(memory)
                            }
                        }
                    }
                }
            }
        }
        .navigationTitle("Memory")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("关闭") {
                    sessionStore.showingMemorySheet = false
                }
            }
        }
    }
}

struct SettingsView: View {
    @EnvironmentObject private var sessionStore: SessionStore
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ScreenContainer {
            SectionTitle(
                eyebrow: "Settings",
                title: "隐私、数据与重置",
                bodyText: "当前版本默认本地保存你的画像、上下文和当前主线。你可以随时清除。"
            )

            PageCard(title: "图片与数据") {
                Text("照片只用于这次分析。当前版本的分析输出已经切到本地结构化 trace，而不是泛化文案 mock。")
                    .font(AppFont.body(15))
                    .foregroundStyle(AppTheme.muted)
            }

            PageCard(title: "重置") {
                Text("如果你想重新从头开始，可以删除当前保存的 Read Me、Today、Ask 和 Memory。")
                    .font(AppFont.body(15))
                    .foregroundStyle(AppTheme.muted)
                PrimaryCTAButton(title: "删除当前本地数据") {
                    sessionStore.resetAllData()
                    dismiss()
                }
            }
        }
        .navigationTitle("设置")
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button("关闭") {
                    dismiss()
                }
            }
        }
    }
}
