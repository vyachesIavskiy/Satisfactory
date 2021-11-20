import SwiftUI

struct ContentView: View {
    
    
    var body: some View {
        ItemListView()
        
//        TabView {
//            ItemListView()
//                .tabItem {
//                    Label("Production", systemImage: "square.stack.fill")
//                }
//
//            SettingsView()
//                .tabItem {
//                    Label("Settings", systemImage: "gear")
//                }
//        }
    }
}

struct ContentPreviews: PreviewProvider {
    @State private static var storage: BaseStorage = PreviewStorage()
    
    static var previews: some View {
        ContentView()
            .environmentObject(Settings())
            .environmentObject(storage)
    }
}

