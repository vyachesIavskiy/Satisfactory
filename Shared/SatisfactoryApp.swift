import SwiftUI

@main
struct SatisfactoryApp: App {
    @State private var isLoaded = false
    @StateObject private var storage: BaseStorage = Storage()
    
    var body: some Scene {
        WindowGroup {
            Group {
                if isLoaded {
                    ItemListView()
                } else {
                    LoadingView(isLoaded: $isLoaded)
                }
            }
            .environmentObject(storage)
        }
    }
}
