import SwiftUI
import Storage
import TCA

struct LoadingReducer: Reducer {
    struct State: Equatable {
        
    }
    
    enum Action: Equatable {
        enum View: Equatable {
            case task
        }
        
        enum Delegate: Equatable {
            case loaded
        }
        
        case view(View)
        case delegate(Delegate)
    }
    
    @Dependency(\.storageClient) private var storageClient
    
    var body: some ReducerOf<Self> {
        Reduce { _, action in
            switch action {
            case .view(.task):
                .run { send in
                    try storageClient.load()
                    
                    await send(.delegate(.loaded))
                } catch: { error, send in
                    print(error)
                }
                
            case .delegate:
                .none
            }
        }
    }
}

struct LoadingView: View {
    @ObservedObject private var viewStore: ViewStore<LoadingReducer.State, LoadingReducer.Action.View>
    
    @AppStorage("flushed_v1.4")
    private var flushed_v1_4 = false
    
    init(store: StoreOf<LoadingReducer>) {
        viewStore = ViewStore(store, observe: { $0 }, send: LoadingReducer.Action.view)
    }
    
    var body: some View {
        ProgressView()
            .task {
                viewStore.send(.task)
            }
    }
}

#Preview("Loading view") {
    LoadingView(store: Store(initialState: LoadingReducer.State()) {
        LoadingReducer()
    })
}
