import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ItemListV3()
                .navigationBarTitle("Parts")
                .navigationViewStyle(StackNavigationViewStyle())
        }
    }
}

struct HomeSearchResultsView: View {
    var body: some View {
        Text("Home search results")
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            Home()
        }
    }
}
