import SwiftUI

struct TabsView: View {
    @State
    private var viewModel = TabsViewModel()
    
    var body: some View {
        TabView(selection: $viewModel.selectedTabIndex) {
            NewProductionView()
                .tint(.sh(.orange))
                .tabItem {
                    Label("New Production", systemImage: "hammer")
                }
                .tag(0)
            
            FactoriesView()
                .tint(.sh(.orange))
                .tabItem {
                    if viewModel.selectedTabIndex == 1 {
                        Label("Factories", systemImage: "building.2.fill")
                    } else {
                        Label("Factories", systemImage: "building.2")
                            .environment(\.symbolVariants, .none)
                    }
                }
                .tag(1)

            SettingsView()
                .tint(.sh(.orange))
                .tabItem {
                    Label("Settings", systemImage: "gear")
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
