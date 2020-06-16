import UIKit
import SwiftUI

final class ItemTableCell: TableViewCell {
    private let itemView = ItemView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.add(subview: itemView)
            .center(inside: contentView)
            .height(equalTo: contentView, constant: -16)
        backgroundColor = .clear
    }
    
    func configure(name: String, amount: Int? = nil) {
        itemView.name = name
        itemView.amount = amount
    }
}

final class ItemView: BasicView {
    private let imageView = ImageView()
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        label.layer.cornerRadius = 3
        label.layer.maskedCorners = [.layerMaxXMaxYCorner]
        label.layer.masksToBounds = true
        label.textColor = .systemGray5
        return label
    }()
    
    private let amountLabel: UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        label.layer.cornerRadius = 3
        label.layer.maskedCorners = [.layerMinXMinYCorner]
        label.layer.masksToBounds = true
        label.textColor = .factoryPrimaryColor
        return label
    }()
    
    var name: String {
        get {
            nameLabel.text ?? ""
        }
        set {
            nameLabel.text = newValue
            imageView.image = UIImage(named: newValue)
        }
    }
    
    var amount: Int? {
        get {
            Int(amountLabel.text ?? "")
        }
        set {
            amountLabel.isHidden = newValue == nil
            guard let amount = newValue else { return }
            amountLabel.text = "\(amount)"
        }
    }
    
    override init() {
        super.init()
        
        add(subview: imageView).fill(inside: self, offset: 4)
        add(subview: nameLabel)
            .leading(equalTo: self)
            .top(equalTo: self)
        add(subview: amountLabel)
            .trailing(equalTo: self)
            .bottom(equalTo: self)
        
        layer.cornerRadius = 10
        layer.masksToBounds = true
        
        backgroundColor = .secondarySystemBackground
    }
}


#if DEBUG
struct ItemViewPreview: PreviewProvider {
    static var previews: some View {
        ItemViewSUI(name: "Iron Ore", amount: 10)
            .previewLayout(.fixed(width: 300, height: 300))
    }
}
#endif
