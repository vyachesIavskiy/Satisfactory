import SwiftUI
import SHFactory

struct TabsView: View {
    @State
    private var viewModel = TabsViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTabIndex) {
            ProductionTypeSelectionView()
                .tint(.sh(.orange))
                .tabItem {
                    Label("tab-new-production", systemImage: "hammer")
                }
                .tag(0)
            
            FactoryListView()
                .tint(.sh(.orange))
                .tabItem {
                    if viewModel.selectedTabIndex == 1 {
                        Label("tab-factories", systemImage: "building.2.fill")
                    } else {
                        Label("tab-factories", systemImage: "building.2")
                            .environment(\.symbolVariants, .none)
                    }
                }
                .tag(1)

            SettingsView()
                .tint(.sh(.orange))
                .tabItem {
                    Label("tab-settings", systemImage: "gear")
                }
                .tag(2)
        }
        .tint(.sh(.midnight))
        .onAppear {
            viewModel.checkWhatsNewStatus()
        }
        .sheet(isPresented: $viewModel.shouldPresentWhatsNew) {
            NavigationStack {
                WhatsNewView {
                    viewModel.didShowWhatsNew()
                }
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
