import SwiftUI

struct RootView: View {
    @EnvironmentObject private var sessionStore: SessionStore

    var body: some View {
        Group {
            switch sessionStore.route {
            case .launching:
                ProgressView()
            case .firstSession(let route):
                FirstSessionCoordinatorView(route: route)
            case .mainTab:
                MainTabShellView()
            }
        }
        .background(AppTheme.background.ignoresSafeArea())
    }
}
