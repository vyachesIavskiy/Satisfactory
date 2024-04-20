import SwiftUI
import ComposableArchitecture

@Reducer
struct RootFeature {
    enum Tab {
        case products
        case recipes
        case buildings
        case vehicles
    }
    
    @ObservableState
    struct State {
        var selectedTab: Tab?
        
        // scoped
        var products = ProductsFeature.State()
        var recipes = RecipesFeature.State()
        var buildings = BuildingsFeature.State()
        var vehicles = VehiclesFeature.State()
    }
    
    enum Action: BindableAction {
        case binding(BindingAction<State>)
        
        // scoped
        case products(ProductsFeature.Action)
        case recipes(RecipesFeature.Action)
        case buildings(BuildingsFeature.Action)
        case vehicles(VehiclesFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
        BindingReducer()
    }
}

struct RootView: View {
    @Bindable var store: StoreOf<RootFeature>
    
    var body: some View {
        NavigationSplitView {
            List(selection: $store.selectedTab) {
                Text("Products")
                    .tag(RootFeature.Tab.products)
                Text("Recipes")
                    .tag(RootFeature.Tab.recipes)
                Text("Buildings")
                    .tag(RootFeature.Tab.buildings)
                Text("Vehicles")
                    .tag(RootFeature.Tab.vehicles)
            }
            .navigationSplitViewColumnWidth(175)
        } detail: {
            switch store.selectedTab {
            case .products:
                ProductsView(store: store.scope(state: \.products, action: \.products))
                
            case .recipes:
                RecipesView(store: store.scope(state: \.recipes, action: \.recipes))
                
            case .buildings:
                BuildingsView(store: store.scope(state: \.buildings, action: \.buildings))
                
            case .vehicles:
                VehiclesView(store: store.scope(state: \.vehicles, action: \.vehicles))
                
            default:
                Text("Select a section from a sidebar")
            }
        }
        .navigationTitle("Content Generation")
    }
}

#if DEBUG
#Preview {
    RootView(store: Store(initialState: RootFeature.State()) {
        RootFeature()
    })
    .frame(width: 750, height: 600)
}
#endif
