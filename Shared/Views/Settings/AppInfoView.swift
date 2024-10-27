import SwiftUI
import SHStorage

struct AppInfoView: View {
    var body: some View {
        List {
            cell(title: "settings-app-info-app-version-row-title", subtitle: Bundle.main.appVersion)
            
            cell(title: "settings-app-info-app-build-number-row-title", subtitle: Bundle.main.appBuildNumber)
            
            cell(title: "settings-app-info-game-update-row-title", subtitle: "Stable 1.0")
            
            cell(title: "settings-app-info-game-version-row-title", subtitle: "v1.0.0.4")
        }
        .navigationTitle("settings-app-info-navigation-title")
    }
    
    @MainActor @ViewBuilder
    private func cell(title: LocalizedStringKey, subtitle: String) -> some View {
        HStack {
            Text(title)
            
            Spacer()
            
            Text(subtitle)
                .font(.footnote)
                .foregroundStyle(.secondary)
                .monospaced()
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        AppInfoView()
    }
}
#endif
