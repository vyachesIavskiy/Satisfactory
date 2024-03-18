import SwiftUI
import TCA

struct MainScreenPlatformResolvedView<Product: View, Resources: View, Power: View>: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    private var iPhone: Bool {
        horizontalSizeClass == .compact
    }
    
    @Bindable var store: StoreOf<MainScreenReducer>
    
    private var listSelectedTab: Binding<MainScreenReducer.Tab?> {
        Binding {
            store.selectedTab
        } set: { newValue in
            guard 
                let newValue,
                newValue != store.selectedTab
            else { return }
            
            store.selectedTab = newValue
        }
    }
    
    private let productView: Product
    private let resourcesView: Resources
    private let powerView: Power
    
    init(
        store: StoreOf<MainScreenReducer>,
        @ViewBuilder prodcut: () -> Product,
        @ViewBuilder resources: () -> Resources,
        @ViewBuilder power: () -> Power
    ) {
        self.store = store
        productView = prodcut()
        resourcesView = resources()
        powerView = power()
    }
    
    var body: some View {
        if iPhone {
            TabView(selection: $store.selectedTab) {
                productView
                    .tabItem {
                        ProductView.label
                    }
                    .tag(ProductView.tag)
                
                resourcesView
                    .tabItem {
                        ResourcesView.label
                    }
                    .tag(ResourcesView.tag)
                
                powerView
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
                switch store.selectedTab {
                case .product:
                    productView
                    
                case .resources:
                    resourcesView
                    
                case .power:
                    powerView
                }
            }
            .tint(Color("Colours/Orange"))
        }
    }
}

#Preview {
    MainScreenPlatformResolvedView(store: Store(initialState: MainScreenReducer.State()) {
        MainScreenReducer()
    }) {
        ProductView()
    } resources: {
        ResourcesView()
    } power: {
        PowerView()
    }
}
