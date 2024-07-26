import SwiftUI

@Observable
final class TabsViewModel {
    var changeLogToShow = ChangeLog.latest
}

struct TabsView: View {
    @State
    var viewModel = TabsViewModel()
    
    var body: some View {
        TabView {
            NewProductionView()
                .tabItem {
                    Label("New Production", systemImage: "hammer")
                }
            
            // TODO: Factories tab

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .sheet(item: $viewModel.changeLogToShow) { changeLog in
            NavigationStack {
                ChangeLogView(changeLog, mode: .showOnLaunch)
            }
            .interactiveDismissDisabled(true)
        }
    }
}

#if DEBUG
#Preview("Tabs view") {
    TabsView()
}
#endif
