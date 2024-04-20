import SwiftUI
import ComposableArchitecture

@Reducer
struct ProductsFeature {
    @ObservableState
    struct State {
        
    }
}

struct ProductsView: View {
    @Bindable var store: StoreOf<ProductsFeature>
    
    var body: some View {
        List {
            
        }
        .navigationTitle("Products")
    }
}

#Preview {
    ProductsView(store: Store(initialState: ProductsFeature.State()) {
        ProductsFeature()
    })
}
