import UIKit

extension UICollectionView {
    // MARK: - Cells
    func register<Cell: UICollectionViewCell>(cell classType: Cell.Type) {
        register(classType, forCellWithReuseIdentifier: classType.reusableId)
    }
    
    func dequeue<Cell: UICollectionViewCell>(cell: Cell.Type, for indexPath: IndexPath) -> Cell {
        dequeueReusableCell(withReuseIdentifier: cell.reusableId, for: indexPath) as! Cell
    }
    
    // MARK: - Headers/Footers
    func register<Header: UICollectionReusableView>(header: Header.Type) {
        register(header,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                 withReuseIdentifier: header.reusableId)
    }
    
    // MARK: - Headers/Footers
    func register<Footer: UICollectionReusableView>(footer: Footer.Type) {
        register(footer,
                 forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                 withReuseIdentifier: footer.reusableId)
    }
    
    func dequeue<Header: UIView>(header: Header.Type, for indexPath: IndexPath) -> Header {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader,
                                         withReuseIdentifier: header.reusableId,
                                         for: indexPath) as! Header
    }
    
    func dequeue<Footer: UIView>(footer: Footer.Type, for indexPath: IndexPath) -> Footer {
        dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionFooter,
                                         withReuseIdentifier: footer.reusableId,
                                         for: indexPath) as! Footer
    }
}
