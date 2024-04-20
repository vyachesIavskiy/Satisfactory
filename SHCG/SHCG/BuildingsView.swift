import SwiftUI
import ComposableArchitecture

@Reducer
struct BuildingsFeature {
    @ObservableState
    struct State {
        
    }
}

struct BuildingsView: View {
    @Bindable var store: StoreOf<BuildingsFeature>
    
    var body: some View {
        List {
            
        }
        .navigationTitle("Buildings")
    }
}

#Preview {
    BuildingsView(store: Store(initialState: BuildingsFeature.State()) {
        BuildingsFeature()
    })
}
