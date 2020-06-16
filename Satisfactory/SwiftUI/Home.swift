import SwiftUI

final class SearchHome: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = UISearchController()
        navigationItem.largeTitleDisplayMode = .always
        
        let home = UIHostingController(rootView: Home())
        addChild(home)
        view.add(subview: home.view).fill(inside: view)
        home.didMove(toParent: self)
    }
}

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
