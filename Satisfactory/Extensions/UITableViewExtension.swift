import UIKit

extension UITableView {
    // MARK: - Cells
    func register<CellClass: UITableViewCell>(class classType: CellClass.Type) {
        register(classType, forCellReuseIdentifier: classType.reusableId)
    }
    
    func dequeue<Cell: UITableViewCell>(cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withIdentifier: cell.reusableId, for: indexPath) as! Cell
    }
    
    // MARK: - Headers/Footers
    func register<HeaderFooterClass: UITableViewHeaderFooterView>(headerFooterClass: HeaderFooterClass.Type) {
        register(headerFooterClass, forHeaderFooterViewReuseIdentifier: headerFooterClass.reusableId)
    }
    
    func dequeue<HeaderFooter: UITableViewHeaderFooterView>(headerFooter: HeaderFooter.Type) -> HeaderFooter {
        dequeueReusableHeaderFooterView(withIdentifier: headerFooter.reusableId) as! HeaderFooter
    }
}
