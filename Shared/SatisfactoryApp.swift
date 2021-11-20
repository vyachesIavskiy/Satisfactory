import SwiftUI

@main
struct SatisfactoryApp: App {
    @State private var isLoaded = false
    @StateObject private var storage: BaseStorage = Storage()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoaded {
                    ContentView()
                } else {
                    LoadingView(isLoaded: $isLoaded)
                }
            }
            .environmentObject(storage)
            .environmentObject(Settings())
        }
    }
}
