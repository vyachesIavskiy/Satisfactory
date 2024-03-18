import SwiftUI

struct ContentView: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var iPhone: Bool {
        horizontalSizeClass == .compact
    }
    
    @Binding var selectedTab: MainScreen.Tab
    private var listSelectedTab: Binding<MainScreen.Tab?> {
        Binding {
            selectedTab
        } set: { newValue in
            guard let newValue else { return }
            selectedTab = newValue
        }

    }
    
    var body: some View {
        if iPhone {
            TabView(selection: $selectedTab) {
                ProductView()
                    .tabItem {
                        ProductView.label
                    }
                    .tag(ProductView.tag)
                
                ResourcesView()
                    .tabItem {
                        ResourcesView.label
                    }
                    .tag(ResourcesView.tag)
                
                PowerView()
                    .tabItem {
                        PowerView.label
                    }
                    .tag(PowerView.tag)
            }
            .tint(Color("Colours/Orange"))
        } else {
            NavigationSplitView {
                List(selection: listSelectedTab) {
                    ProductView.navigationLink
                    
                    ResourcesView.navigationLink
                    
                    PowerView.navigationLink
                }
                #if !os(macOS)
                .navigationBarTitleDisplayMode(.inline)
                #endif
            } detail: {
                switch selectedTab {
                case .product:
                    ProductView()
                    
                case .resources:
                    ResourcesView()
                    
                case .power:
                    PowerView()
                }
            }
            .tint(Color("Colours/Orange"))
        }
    }
}

#Preview {
    ContentView(selectedTab: .constant(.product))
}
