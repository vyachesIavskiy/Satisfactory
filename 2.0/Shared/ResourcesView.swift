import SwiftUI

struct ResourcesView: View {
    static let tag = MainScreen.Tab.resources
    
    var body: some View {
        NavigationStack {
            Color.clear
                .navigationTitle("Resources")
        }
    }
    
    @ViewBuilder static var label: some View {
        Label("Resources", systemImage: "circle.dotted.circle")
    }
    
    @ViewBuilder static var navigationLink: some View {
        NavigationLink(value: Self.tag) {
            label
        }
    }
}

#Preview {
    ResourcesView()
}
