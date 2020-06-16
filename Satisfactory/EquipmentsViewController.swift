import UIKit

final class EquipmentDataSource: UITableViewDiffableDataSource<EquipmentType, Equipment> {
    override init(tableView: UITableView, cellProvider: @escaping EquipmentDataSource.CellProvider) {
        super.init(tableView: tableView, cellProvider: cellProvider)
        
        defaultRowAnimation = .fade
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        BuildingType.allCases[section].rawValue
    }
}

final class EquipmentsViewController: ViewController {
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(class: BasicCell.self)
        tableView.delegate = self
        return tableView
    }()
    
    private lazy var dataSource: EquipmentDataSource = {
        let dataSource = EquipmentDataSource(tableView: tableView) { tableView, indexPath, equipment in
            let cell = tableView.dequeue(cell: BasicCell.self, for: indexPath)
            cell.textLabel?.text = equipment.name
            cell.imageView?.image = UIImage(named: equipment.name)
            return cell
        }
        return dataSource
    }()
    
    private lazy var searchController: UISearchController = {
        let controller = UISearchController(searchResultsController: nil)
        controller.searchResultsUpdater = self
        controller.obscuresBackgroundDuringPresentation = false
        controller.searchBar.placeholder = "Search equipment"
        return controller
    }()
    
    override init() {
        super.init()
        
        tabBarItem = UITabBarItem(title: "Equipment", image: UIImage(systemName: "hammer"), selectedImage: UIImage(systemName: "hammer.fill"))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.searchController = searchController
        navigationItem.largeTitleDisplayMode = .always
        
        view.add(subview: tableView).fill(inside: view)
        
        updateTable(animated: false)
    }
    
    private func updateTable(animated: Bool = true) {
        var snapshot = NSDiffableDataSourceSnapshot<EquipmentType, Equipment>()
        snapshot.deleteAllItems()
        snapshot.appendSections(EquipmentType.allCases)
        EquipmentType.allCases.forEach { equipmentType in
            snapshot.appendItems(Storage.shared.equipments.filter {
                var result = $0.equipmentType == equipmentType
                if let text = searchController.searchBar.text, !text.isEmpty {
                    result = result && $0.name.contains(text)
                }
                return result
            }, toSection: equipmentType)
        }
        snapshot.sectionIdentifiers.forEach { section in
            if snapshot.numberOfItems(inSection: section) == 0 {
                snapshot.deleteSections([section])
            }
        }
        dataSource.apply(snapshot, animatingDifferences: animated)
    }
}

extension EquipmentsViewController: UITableViewDelegate {
    
}

extension EquipmentsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        updateTable()
    }
}
