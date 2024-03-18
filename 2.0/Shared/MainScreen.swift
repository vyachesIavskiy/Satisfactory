import SwiftUI
import TCA

@Reducer
struct MainScreenReducer {
    enum Tab {
        case product
        case resources
        case power
    }
    
    @ObservableState
    struct State {
        var selectedTab = Tab.product
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
    }
}

struct MainScreen: View {
    @Bindable var store: StoreOf<MainScreenReducer>
    
    var body: some View {
        MainScreenPlatformResolvedView(store: store) {
            ProductView()
        } resources: {
            ResourcesView()
        } power: {
            PowerView()
        }
    }
}

#Preview {
    MainScreen(store: Store(initialState: MainScreenReducer.State()) {
        MainScreenReducer()
    })
}
