import SwiftUI
import SHStorage

struct AppInfoView: View {
    var body: some View {
        List {
            cell(title: "App version:", subtitle: Bundle.main.appVersion)
            
            cell(title: "App build number:", subtitle: Bundle.main.appBuildNumber)
            
            cell(title: "Game update", subtitle: "Update 8")
            
            cell(title: "Game version", subtitle: "0.8.3.3")
        }
        .navigationTitle("App Info")
    }
    
    @MainActor @ViewBuilder
    private func cell(title: String, subtitle: String) -> some View {
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
