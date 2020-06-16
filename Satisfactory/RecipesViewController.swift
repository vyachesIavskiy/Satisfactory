import UIKit

final class RecipePartView: BasicView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.square()
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    init(name: String) {
        super.init()
        
        add(subview: imageView)
        .leading(equalTo: self, constant: 5)
        .top(equalTo: self, constant: 5)
        .centerY(equalTo: self)
        
        add(subview: titleLabel)
            .leading(equalTo: imageView.trailingAnchor, constant: 8)
            .top(equalTo: self)
            .bottom(equalTo: self)
            .trailing(equalTo: self, constant: 8)
        
        titleLabel.text = name
        imageView.image = UIImage(named: name)
    }
}

final class RecipeTableCell: TableViewCell {
    private let inputContainerView = UIView()
    private let dividerView: UIImageView = {
        let imageView = UIImageView(image: UIImage(systemName: "arrow.down"))
        imageView.tintColor = .systemGreen
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let outputContainerView = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(subview: inputContainerView)
            .leading(equalTo: contentView, constant: separatorInset.left)
            .centerX(equalTo: contentView)
            .top(equalTo: contentView, constant: 5)
        
        contentView.add(subview: dividerView)
            .leading(equalTo: contentView, constant: separatorInset.left)
            .trailing(equalTo: contentView)
            .top(equalTo: inputContainerView.bottomAnchor, constant: 10)
        
        contentView.add(subview: outputContainerView)
            .leading(equalTo: inputContainerView)
            .trailing(equalTo: inputContainerView)
            .top(equalTo: dividerView.bottomAnchor, constant: 10)
            .bottom(equalTo: contentView, constant: 5)
    }
    
    func configure(with recipe: Recipe) {
        inputContainerView.subviews.forEach { $0.removeFromSuperview() }
        outputContainerView.subviews.forEach { $0.removeFromSuperview() }
        
        let views = recipe.input.map { RecipePartView(name: $0.item.name).height(equalTo: 40) }
        let views2 = recipe.output.map { RecipePartView(name: $0.item.name).height(equalTo: 40) }
        
        inputContainerView.add(subview: UIStackView(views: views, axis: .vertical, alignment: .leading)).fill(inside: inputContainerView)
        outputContainerView.add(subview: UIStackView(views: views2, axis: .vertical, alignment: .leading)).fill(inside: outputContainerView)
    }
}

final class RecipesDataSource: UITableViewDiffableDataSource<String, Recipe> {}

final class RecipesViewController: UIViewController {
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.register(class: RecipeTableCell.self)
        return tableView
    }()
    
    private var dataSource: RecipesDataSource!
    
    var recipes: [Recipe]
    
    init(part: Part) {
        recipes = Storage.shared[recipesFor: part.id]
        
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
            let cell = tableView.dequeue(cell: RecipeTableCell.self, for: indexPath)
            cell.configure(with: recipe)
            return cell
        }
        
        var snapshot = NSDiffableDataSourceSnapshot<String, Recipe>()
        recipes.enumerated().forEach {
            snapshot.appendSections(["\($0.offset)"])
            snapshot.appendItems([$0.element])
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}
