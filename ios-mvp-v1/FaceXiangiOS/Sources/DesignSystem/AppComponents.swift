import SwiftUI

struct ScreenContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                content
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 24)
        }
    }
}

struct PageCard<Content: View>: View {
    let title: String?
    let content: Content

    init(title: String? = nil, @ViewBuilder content: () -> Content) {
        self.title = title
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            if let title {
                Text(title)
                    .font(AppFont.title(18))
                    .foregroundStyle(AppTheme.ink)
            }
            content
        }
        .padding(18)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(AppTheme.card)
        .clipShape(RoundedRectangle(cornerRadius: 20, style: .continuous))
        .overlay(
            RoundedRectangle(cornerRadius: 20, style: .continuous)
                .stroke(AppTheme.softBorder, lineWidth: 1)
        )
    }
}

struct PrimaryCTAButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.body(16))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(AppTheme.accent)
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

struct SecondaryCTAButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppFont.body(15))
                .foregroundStyle(AppTheme.ink)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 14)
                .background(Color.white.opacity(0.5))
                .clipShape(RoundedRectangle(cornerRadius: 16, style: .continuous))
                .overlay(
                    RoundedRectangle(cornerRadius: 16, style: .continuous)
                        .stroke(AppTheme.softBorder, lineWidth: 1)
                )
        }
        .buttonStyle(.plain)
    }
}

struct SectionTitle: View {
    let eyebrow: String?
    let title: String
    let bodyText: String

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let eyebrow {
                Text(eyebrow)
                    .font(AppFont.body(12))
                    .foregroundStyle(AppTheme.muted)
                    .textCase(.uppercase)
                    .tracking(1.2)
            }
            Text(title)
                .font(AppFont.title(28))
                .foregroundStyle(AppTheme.ink)
            Text(bodyText)
                .font(AppFont.body(16))
                .foregroundStyle(AppTheme.muted)
                .fixedSize(horizontal: false, vertical: true)
        }
    }
}

struct EmptyShellCard: View {
    let title: String
    let bodyText: String
    let cta: String
    let action: () -> Void

    var body: some View {
        PageCard(title: title) {
            Text(bodyText)
                .font(AppFont.body(15))
                .foregroundStyle(AppTheme.muted)
            PrimaryCTAButton(title: cta, action: action)
        }
    }
}
