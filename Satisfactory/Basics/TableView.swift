import UIKit

struct Configuration {
    let cells: [IndexPath: UITableViewCell.Type]
}

class TableView<Model>: UITableView {
    var models = [Model]()
    let configuration: Configuration
    
    var cell: ((_ cell: UITableViewCell, _ model: Model) -> Void)?
    
    init(configuration: Configuration, style: UITableView.Style = .plain) {
        self.configuration = configuration
        super.init(frame: .zero, style: style)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func numberOfRows(inSection section: Int) -> Int { models.count }
    override func cellForRow(at indexPath: IndexPath) -> UITableViewCell? {
        let cellType = configuration.cells[indexPath] ?? UITableViewCell.self
        let c = dequeue(cell: cellType, for: indexPath)
        cell?(c, models[indexPath.row])
        return c
    }
}
