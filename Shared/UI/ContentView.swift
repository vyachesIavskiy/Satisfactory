import SwiftUI

struct ContentView: View {
    var body: some View {
        ItemListView()
    }
}

struct ContentPreviews: PreviewProvider {
    @State private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ContentView()
            .environmentObject(Settings())
            .environmentObject(storage)
    }
}

