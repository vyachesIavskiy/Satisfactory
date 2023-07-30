import SwiftUI

struct ContentView: View {
    @State private var latestDisclaimer: Disclaimer?
    
    @EnvironmentObject private var storage: Storage
    
    var body: some View {
        TabView {
            ItemListView(model: ItemListView.Model(storage: storage))
                .tabItem {
                    Label("Production", systemImage: "hammer")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .onAppear {
            latestDisclaimer = Disclaimer.latest
        }
        .sheet(item: $latestDisclaimer) { disclaimer in
            DisclaimerViewContainer(disclaimer)
                .interactiveDismissDisabled(true)
        }
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

