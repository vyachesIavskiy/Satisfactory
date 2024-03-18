import SwiftUI
import TCA

struct MainTabBarReducer: Reducer {
    struct State: Equatable {
        var newProduction: NewProductionFeature.State
        var settings = SettingsReducer.State()
    }
    
    enum Action: Equatable {
        // Scoped
        case newProduction(NewProductionFeature.Action)
        case settings(SettingsReducer.Action)
    }
    
    var body: some ReducerOf<Self> {
        Scope(state: \.newProduction, action: /Action.newProduction) {
            NewProductionFeature()
        }
        
        Scope(state: \.settings, action: /Action.settings) {
            SettingsReducer()
        }
    }
}

struct MainTabBarView: View {
    private let store: StoreOf<MainTabBarReducer>
    @ObservedObject private var viewStore: ViewStoreOf<MainTabBarReducer>
    
//    @State private var latestDisclaimer: Disclaimer?
    
    init(store: StoreOf<MainTabBarReducer>) {
        self.store = store
        viewStore = ViewStore(store, observe: { $0 })
    }
    
    var body: some View {
        TabView {
            NewProductionView(store: store.scope(state: \.newProduction, action: MainTabBarReducer.Action.newProduction))
                .tabItem {
                    Label("Production", systemImage: "hammer")
                }
            
            Text("< Factories >")
                .tabItem {
                    Label("Factories", systemImage: "folder")
                }
            
            SettingsView(store: store.scope(state: \.settings, action: MainTabBarReducer.Action.settings))
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
//        .onAppear {
//            latestDisclaimer = Disclaimer.latest
//        }
//        .sheet(item: $latestDisclaimer) { disclaimer in
//            DisclaimerViewContainer(disclaimer)
//                .interactiveDismissDisabled(true)
//        }
    }
}

#Preview("Main TabBar View") {
    MainTabBarView(store: Store(initialState: MainTabBarReducer.State(newProduction: NewProductionFeature.State(appStorage: AppStorage()))) {
        MainTabBarReducer()
    })
}

