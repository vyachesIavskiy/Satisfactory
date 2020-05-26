import UIKit

class PartsDataSource: UITableViewDiffableDataSource<String, Part> {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        snapshot().sectionIdentifiers[section]
    }
}

final class PartsViewController: ViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(class: BasicCell.self)
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search parts..."
        return controller
    }()
    
    private var dataSource: PartsDataSource!
    
    var parts: [Part] {
        let parts = Storage.shared.parts
        return isSearchBarEmpty ? parts : parts.filter { $0.name.contains(searchText) }
    }
    
    var isSearchBarEmpty: Bool {
        searchController.searchBar.text?.isEmpty ?? true
    }
    
    var searchText: String {
        searchController.searchBar.text ?? ""
    }
    
    override init() {
        super.init()
        
        tabBarItem = UITabBarItem(title: "Recipes", image: UIImage(systemName: "doc.text"), selectedImage: UIImage(systemName: "doc.text.fill"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        view.add(subview: tableView).fill(inside: view)
        
        dataSource = PartsDataSource(tableView: tableView) { tableView, indexPath, part in
            let cell = tableView.dequeue(cell: BasicCell.self, for: indexPath)
            cell.textLabel?.text = part.name
            cell.imageView?.image = UIImage(named: part.name)
            return cell
        }
        
        updateDataSource(animated: false)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    private func updateDataSource(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<String, Part>()
        snapshot.deleteAllItems()
        snapshot.appendSections([""])
        snapshot.appendItems(parts)
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension PartsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let recipesViewController = RecipesViewController(part: parts[indexPath.row])
        navigationController?.pushViewController(recipesViewController, animated: true)
    }
}

extension PartsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        updateDataSource()
    }
}