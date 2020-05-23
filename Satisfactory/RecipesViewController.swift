import UIKit

final class RecipesDataSource: UITableViewDiffableDataSource<String, Recipe> {}

final class RecipesViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(class: BasicCell.self)
        return tableView
    }()
    
    private var dataSource: RecipesDataSource!
    
    var recipes: [Recipe]
    
    init(part: Part) {
        recipes = Storage.shared[recipeByPartName: part.name]
        
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.add(subview: tableView).fill(inside: view)
        navigationItem.largeTitleDisplayMode = .never
        
        dataSource = RecipesDataSource(tableView: tableView) { tableView, indexPath, recipe -> UITableViewCell? in
            let cell = tableView.dequeue(cell: BasicCell.self, for: indexPath)
            cell.textLabel?.text = "\(recipe)"
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<String, Recipe>()
        snapshot.appendSections([""])
        snapshot.appendItems(recipes)
        dataSource.apply(snapshot)
    }
}
