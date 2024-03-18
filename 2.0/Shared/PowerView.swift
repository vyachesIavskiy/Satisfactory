import SwiftUI

struct PowerView: View {
    static let tag = MainScreen.Tab.power
    
    var body: some View {
        NavigationStack {
            Color.clear
                .navigationTitle("Power")
        }
    }
    
    @ViewBuilder static var label: some View {
        Label("Power", systemImage: "bolt")
    }
    
    @ViewBuilder static var navigationLink: some View {
        NavigationLink(value: Self.tag) {
            label
        }
    }
}

#Preview {
    PowerView()
}
