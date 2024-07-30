import UIKit
import SwiftUI

struct FeedbackCellConfiguration: UIContentConfiguration, Hashable {
    var text: String
    
    func makeContentView() -> any UIView & UIContentView {
        FeedbackContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> FeedbackCellConfiguration {
        self
    }
}

private final class FeedbackContentView: UIView, UIContentView {
    private let shapeLayer = CAShapeLayer()
    private let textLabel = UILabel()
    
    private var _configuration: FeedbackCellConfiguration
    var configuration: any UIContentConfiguration {
        get { _configuration }
        set {
            guard
                let configuration = newValue as? FeedbackCellConfiguration,
                configuration != _configuration
            else { return }
            
            apply(configuration)
        }
    }
    
    init(configuration: FeedbackCellConfiguration) {
        _configuration = configuration
        
        super.init(frame: .zero)
        
        layout()
        apply(configuration)
        layer.mask = shapeLayer
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        shapeLayer.path = UIBezierPath(ovalIn: bounds).cgPath
        shapeLayer.frame = bounds
    }
    
    private func layout() {
        addSubview(textLabel)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            textLabel.leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor, constant: 20),
            textLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            textLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            textLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            textLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 24)
        ])
    }
    
    private func apply(_ configuration: FeedbackCellConfiguration) {
        var container = AttributeContainer()
        container.font = Font.body.weight(.semibold)
        let string = AttributedString(configuration.text, attributes: container)
        textLabel.attributedText = NSAttributedString(string)
    }
}

#Preview("Feedback cell") {
    FeedbackContentView(configuration: FeedbackCellConfiguration(text: "Send Feedback"))
}
