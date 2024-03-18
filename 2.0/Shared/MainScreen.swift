import SwiftUI

struct MainScreen: View {
    enum Tab {
        case product
        case resources
        case power
    }
    
    @State private var selectedTab = Tab.product
    
    var body: some View {
        ContentView(selectedTab: $selectedTab)
    }
}

#Preview {
    MainScreen()
}
