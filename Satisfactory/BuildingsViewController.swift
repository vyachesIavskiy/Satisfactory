import UIKit

final class BuildingsDataSource: UITableViewDiffableDataSource<BuildingType, Building> {
    override init(tableView: UITableView, cellProvider: @escaping UITableViewDiffableDataSource<BuildingType, Building>.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
        
        defaultRowAnimation = .fade
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        BuildingType.allCases[section].rawValue
    }
}

final class BuildingsViewController: ViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(class: BasicCell.self)
        return tableView
    }()
    
    lazy var dataSource: BuildingsDataSource = {
        let dataSource = BuildingsDataSource(tableView: tableView) { tableView, indexPath, building in
            let cell = tableView.dequeue(cell: BasicCell.self, for: indexPath)
            cell.textLabel?.text = building.name
            cell.imageView?.image = UIImage(named: building.name)
            return cell
        }
        return dataSource
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search buildings"
        return controller
    }()
    
    override init() {
        super.init()
        
        tabBarItem = UITabBarItem(title: "Buildings", image: UIImage(systemName: "command"), selectedImage: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        view.add(subview: tableView).fill(inside: view)
        
        updateTable(animated: false)
    }
    
    private func updateTable(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<BuildingType, Building>()
        snapshot.deleteAllItems()
        snapshot.appendSections(BuildingType.allCases)
        BuildingType.allCases.forEach { buildingType in
            snapshot.appendItems(Storage.shared.buildings.filter {
                var result = $0.buildingType == buildingType
                if let text = searchController.searchBar.text, !text.isEmpty {
                    result = result && $0.name.contains(text)
                }
                return result
            }, toSection: buildingType)
        }
        snapshot.sectionIdentifiers.forEach { section in
            if snapshot.numberOfItems(inSection: section) == 0 {
                snapshot.deleteSections([section])
            }
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension BuildingsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        updateTable()
    }
}
