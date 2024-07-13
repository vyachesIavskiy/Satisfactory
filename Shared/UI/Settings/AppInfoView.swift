import SwiftUI
import SHStorage

struct AppInfoView: View {
    @Dependency(\.storageService)
    private var storageService
    
    var body: some View {
        List {
            Section("App") {
                cell(title: "App version:", subtitle: Bundle.main.appVersion)
                
                cell(title: "App build number:", subtitle: Bundle.main.appBuildNumber)
                
                cell(
                    title: "Static configuration version",
                    subtitle: storageService.staticConfiguration().version.formatted(.number)
                )
                
                cell(
                    title: "Persistent configuration version",
                    subtitle: storageService.persistentConfiguration().version.formatted(.number)
                )
            }
            
            Section("Game") {
                cell(title: "Game update", subtitle: "Update 8")
                
                cell(title: "Game branch", subtitle: "Early access")
                
                cell(title: "Game version", subtitle: "0.8.3.3")
                
                cell(title: "Game build number", subtitle: "273254")
            }
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
