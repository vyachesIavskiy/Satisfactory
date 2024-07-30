import UIKit
import SwiftUI
import SHModels

final class ItemCellContentView: UIView, UIContentView {
    private let iconView = ItemCellIconView()
    private let titleView = UILabel()
    private let underlineView = ItemCellUndelineView()
    
    private var _configuration: ItemCellConfiguration
    var configuration: any UIContentConfiguration {
        get { _configuration }
        set {
            guard
                let configuration = newValue as? ItemCellConfiguration,
                configuration != _configuration
            else { return }
            
            apply(configuration)
        }
    }
    
    init(configuration: ItemCellConfiguration) {
        _configuration = configuration
        
        super.init(frame: .zero)
        
        layout()
        apply(configuration)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(iconView)
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(titleView)
        titleView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(underlineView)
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            iconView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),
            iconView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            bottomAnchor.constraint(greaterThanOrEqualTo: iconView.bottomAnchor, constant: 8),
            
            titleView.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: 12),
            trailingAnchor.constraint(equalTo: titleView.trailingAnchor, constant: 8),
            titleView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            
            underlineView.leadingAnchor.constraint(equalTo: titleView.leadingAnchor),
            underlineView.trailingAnchor.constraint(equalTo: titleView.trailingAnchor),
            underlineView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            bottomAnchor.constraint(equalTo: underlineView.bottomAnchor, constant: 8)
        ])
    }
    
    private func apply(_ configuration: ItemCellConfiguration) {
        _configuration = configuration
        
        titleView.text = configuration.title
        iconView.imageName = configuration.imageName
        iconView.form = configuration.form
    }
}

#Preview {
    ItemCellContentView(configuration: ItemCellConfiguration(
        title: "Preview",
        imageName: "part-iron-plate",
        form: .solid
    ))
}
