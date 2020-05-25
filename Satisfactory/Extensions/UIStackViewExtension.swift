import UIKit

extension UIStackView {
    convenience init(views: [UIView],
                     axis: NSLayoutConstraint.Axis,
                     distribution: UIStackView.Distribution = .fill,
                     alignment: UIStackView.Alignment = .center,
                     spacing: CGFloat = 0) {
        self.init(arrangedSubviews: views)
        self.axis = axis
        self.distribution = distribution
        self.alignment = alignment
        self.spacing = spacing
    }
}
