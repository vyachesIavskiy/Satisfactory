import SwiftUI
import TCA

@main
struct SH2App: App {
    let store = Store(initialState: MainScreenReducer.State()) {
        MainScreenReducer()
    }
    
    var body: some Scene {
        WindowGroup {
            MainScreen(store: store)
        }
    }
}
