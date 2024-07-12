import SwiftUI

@Observable
final class TabsViewModel {
    var disclaimerToShow = Disclaimer.latest
    
    let newProductionViewModel = NewProductionViewModel()
    let settingsViewModel = SettingsViewModel()
}

struct TabsView: View {
    @Bindable var viewModel: TabsViewModel
    
    var body: some View {
        TabView {
            NewProductionView(viewModel: viewModel.newProductionViewModel)
                .tabItem {
                    Label("New Production", systemImage: "hammer")
                }
            
            // TODO: Factories tab

            SettingsView(viewModel: viewModel.settingsViewModel)
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
        }
        .sheet(item: $viewModel.disclaimerToShow) { disclaimer in
            DisclaimerViewContainer(disclaimer)
                .interactiveDismissDisabled(true)
        }
    }
}

#if DEBUG
#Preview("Tabs view") {
    TabsView(viewModel: TabsViewModel())
}
#endif
