import UIKit

class SHListCell: UICollectionViewListCell {
    private let angledRectangleLayer = CAShapeLayer()
    
    var index = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    var numberOfItems = 0 {
        didSet {
            setNeedsLayout()
        }
    }
    
    override var layer: CALayer {
        get {
            let l = super.layer
            l.maskedCorners = []
            l.masksToBounds = false
            l.mask = angledRectangleLayer
            return l
        }
        set { }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        angledRectangleLayer.frame = bounds
        
        var corners = AngledRectangle.Corner.Set()
        if index == 1 {
            corners.insert(.topRight)
        }
        if index == numberOfItems - 1 {
            corners.insert(.bottomLeft)
        }
        angledRectangleLayer.path = AngledRectangle(cornerRadius: 12, corners: corners).path(in: bounds).cgPath
    }
}

#Preview {
    let cell = SHListCell()
    cell.index = 0
    cell.numberOfItems = 1
    return cell
}
