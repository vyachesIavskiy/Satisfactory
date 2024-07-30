import UIKit

final class SectionHeaderView: UICollectionReusableView {
    private let label = UILabel()
    
    var title = "" {
        didSet {
            label.text = title
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        label.textColor = .secondaryLabel
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            label.leadingAnchor.constraint(equalTo: leadingAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor),
            label.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bottomAnchor.constraint(equalTo: label.bottomAnchor, constant: 4)
        ])
        
        backgroundColor = .systemBackground
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#Preview {
    let header = SectionHeaderView()
    header.title = "Preview"
    return header
}
