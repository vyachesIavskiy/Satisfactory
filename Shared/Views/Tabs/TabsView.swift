import SwiftUI

struct TabsView: View {
    @State
    private var viewModel = TabsViewModel()
    
    var body: some View {
        Group {
            if #available(iOS 18.0, *) {
                iOS18Body
            } else {
                iOS17Body
            }
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
    
    @ViewBuilder
    private var iOS17Body: some View {
        TabView(selection: $viewModel.selectedTab) {
//            ProductionTypeSelectionView()
            NavigationStack {
                SingleItemCalculatorItemSelectionView()
            }
            .tint(.sh(.orange))
            .tabItem {
                Label("tab-new-production", systemImage: "hammer")
            }
            .tag(TabsViewModel.TabValue.newProduction)
            
            FactoryListView()
                .tint(.sh(.orange))
                .tabItem {
                    if viewModel.selectedTab == .factories {
                        Label("tab-factories", systemImage: "building.2.fill")
                    } else {
                        Label("tab-factories", systemImage: "building.2")
                            .environment(\.symbolVariants, .none)
                    }
                }
                .tag(TabsViewModel.TabValue.factories)

            SettingsView()
                .tint(.sh(.orange))
                .tabItem {
                    Label("tab-settings", systemImage: "gear")
                }
                .tag(TabsViewModel.TabValue.settings)
        }
    }
    
    @available(iOS 18, *)
    @ViewBuilder
    private var iOS18Body: some View {
        TabView(selection: $viewModel.selectedTab) {
            Tab("tab-new-production", systemImage: "hammer", value: .newProduction) {
                NavigationStack {
                    SingleItemCalculatorItemSelectionView()
                }
                .tint(.sh(.orange))
            }
            
            Tab(value: .factories) {
                NavigationStack {
                    FactoryListView()
                }
                .tint(.sh(.orange))
            } label: {
                if viewModel.selectedTab == .factories {
                    Label("tab-factories", systemImage: "building.2.fill")
                } else {
                    Label("tab-factories", systemImage: "building.2")
                        .environment(\.symbolVariants, .none)
                }
            }
            
            Tab("tab-settings", systemImage: "gear", value: .settings) {
                NavigationStack {
                    SettingsView()
                }
                .tint(.sh(.orange))
            }
        }
        .tabViewStyle(.sidebarAdaptable)
    }
}

#if DEBUG
#Preview("Tabs view") {
    TabsView()
}
#endif
