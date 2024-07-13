import SwiftUI

@Observable
final class TabsViewModel {
    var changeLogToShow = ChangeLog.latest
}

struct TabsView: View {
    @Bindable var viewModel: TabsViewModel
    
    var body: some View {
        TabView {
            NewProductionView(viewModel: NewProductionViewModel())
                .tabItem {
                    Label("New Production", systemImage: "hammer")
                }
            
            // TODO: Factories tab

            SettingsView(viewModel: SettingsViewModel())
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .sheet(item: $viewModel.changeLogToShow) { changeLog in
            ChangeLogView(changeLog, mode: .showOnLaunch)
                .interactiveDismissDisabled(true)
        }
    }
}

#if DEBUG
#Preview("Tabs view") {
    TabsView(viewModel: TabsViewModel())
}
#endif
