import UIKit

class PartsDataSource: UITableViewDiffableDataSource<PartType, Part> {
    override init(tableView: UITableView, cellProvider: @escaping UITableViewDiffableDataSource<PartType, Part>.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
        
        defaultRowAnimation = .fade
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        snapshot().sectionIdentifiers[section].rawValue
    }
}

final class PartsViewController: ViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
//        tableView.register(class: BasicCell.self)
//        tableView.register(class: ItemTableCell.self)
        tableView.delegate = self
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search parts"
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
//            let cell = tableView.dequeue(cell: BasicCell.self, for: indexPath)
//            let cell = tableView.dequeue(cell: ItemTableCell.self, for: indexPath)
//            cell.textLabel?.text = part.name
//            cell.imageView?.image = UIImage(named: part.name)
//            cell.configure(name: part.name)
//            return cell
            return UITableViewCell()
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
        var snapshot = NSDiffableDataSourceSnapshot<PartType, Part>()
        snapshot.deleteAllItems()
        
        
        snapshot.appendSections(PartType.allCases)
        PartType.allCases.forEach { partType in
            snapshot.appendItems(Storage.shared.parts.filter {
                var result = $0.partType == partType
                if let text = searchController.searchBar.text, !text.isEmpty {
                    result = result && $0.name.contains(text)
                }
                return result
            }, toSection: partType)
        }
        snapshot.sectionIdentifiers.forEach { section in
            if snapshot.numberOfItems(inSection: section) == 0 {
                snapshot.deleteSections([section])
            }
        }
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
