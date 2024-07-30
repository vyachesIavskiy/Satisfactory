import UIKit

final class ItemCellUndelineView: UIView {
    private let gradientLayer = CAGradientLayer()
    private var heightConstraint: NSLayoutConstraint!
    
    init() {
        super.init(frame: .zero)
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        gradientLayer.frame = bounds
        registerForTraitChanges([UITraitDisplayScale.self]) { (self: Self, previousTraitCollection: UITraitCollection) in
            guard previousTraitCollection.displayScale != self.traitCollection.displayScale else { return }
            
            self.heightConstraint.constant = 1 / self.traitCollection.displayScale
        }
    }
    
    private func layout() {
        gradientLayer.colors = [
            UIColor(named: "Colors/Midnight/Midnight - 100")?.cgColor as Any,
            UIColor(named: "Colors/Midnight/Midnight - 10")?.cgColor as Any
        ]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        layer.addSublayer(gradientLayer)
        
        translatesAutoresizingMaskIntoConstraints = false
        heightConstraint = heightAnchor.constraint(equalToConstant: 1 / traitCollection.displayScale)
        heightConstraint.isActive = true
    }
}

#Preview {
    ItemCellUndelineView()
}
