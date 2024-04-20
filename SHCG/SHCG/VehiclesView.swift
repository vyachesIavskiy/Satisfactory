import SwiftUI
import ComposableArchitecture

@Reducer
struct VehiclesFeature {
    @ObservableState
    struct State {
        
    }
}

struct VehiclesView: View {
    @Bindable var store: StoreOf<VehiclesFeature>
    
    var body: some View {
        List {
            
        }
        .navigationTitle("Vehicles")
    }
}

#Preview {
    VehiclesView(store: Store(initialState: VehiclesFeature.State()) {
        VehiclesFeature()
    })
}
