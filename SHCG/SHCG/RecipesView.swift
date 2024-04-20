import SwiftUI
import ComposableArchitecture

@Reducer
struct RecipesFeature {
    @ObservableState
    struct State {
        
    }
}

struct RecipesView: View {
    @Bindable var store: StoreOf<RecipesFeature>
    
    var body: some View {
        List {
            
        }
        .navigationTitle("Recipes")
    }
}

#Preview {
    RecipesView(store: Store(initialState: RecipesFeature.State()) {
        RecipesFeature()
    })
}
