import SwiftUI
import ComposableArchitecture

@main
struct SHCGApp: App {
    var body: some Scene {
        WindowGroup("Satisfactory Helper Content Generator") {
            RootView(store: Store(initialState: RootFeature.State()) {
                RootFeature()
            })
            .frame(idealWidth: 750, idealHeight: 600)
        }
    }
}
