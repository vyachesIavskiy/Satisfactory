import SwiftUI

struct ContentView: View {
    @AppStorage("disclaimer.shown.v1_4")
    private var disclaimerForV1_4Shown = false
    
    @State private var showDisclaimer = false
    
    var body: some View {
        ItemListView()
            .onAppear {
                guard !disclaimerForV1_4Shown else { return }
                
                showDisclaimer = true
            }
            .fullScreenCover(isPresented: $showDisclaimer) {
                DisclaimerView()
            }
            .onChange(of: showDisclaimer) { newValue in
                if !showDisclaimer {
                    disclaimerForV1_4Shown = true
                }
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

