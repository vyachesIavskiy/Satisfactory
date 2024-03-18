import SwiftUI

struct ProductView: View {
    static let tag = MainScreen.Tab.product
    
    var body: some View {
        NavigationStack {
            Color.clear
                .navigationTitle("Product")
        }
    }
    
    @ViewBuilder static var label: some View {
        Label("Product", systemImage: "list.bullet")
    }
    
    @ViewBuilder static var navigationLink: some View {
        NavigationLink(value: Self.tag) {
            label
        }
    }
}

#Preview {
    ProductView()
}
