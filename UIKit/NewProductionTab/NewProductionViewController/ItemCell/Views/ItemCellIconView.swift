import UIKit
import SwiftUI
import SHModels

final class ItemCellIconView: UIView {
    private let backgroundView = UIView()
    private let backgroundMaskLayer = CAShapeLayer()
    private let backgroundStrokeLayer = CAShapeLayer()
    private let imageView = UIImageView()
    
    var imageName = "" {
        didSet {
            guard oldValue != imageName else { return }
            
            imageView.image = UIImage(named: imageName)
        }
    }
    
    var form: Part.Form? {
        didSet {
            guard oldValue != form else { return }
            
            updateFormShape()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        updateFormShape()
    }
    
    private func layout() {
        configureBackgroundView()
        imageView.contentMode = .scaleAspectFit
        
        addSubview(backgroundView)
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundView.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundView.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundView.topAnchor.constraint(equalTo: topAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 6),
            trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 6),
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 6),
            bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 6),
            
            imageView.widthAnchor.constraint(equalToConstant: 40),
            imageView.heightAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 1.0)
        ])
    }
    
    private func configureBackgroundView() {
        backgroundView.backgroundColor = .sh(.gray10)
        backgroundView.layer.addSublayer(backgroundStrokeLayer)
    }
    
    private func updateFormShape() {
        let path = switch form {
        case .solid, nil:
            AngledRectangle(cornerRadius: 5).path(in: bounds).cgPath
            
        case .fluid, .gas:
            UnevenRoundedRectangle(bottomLeadingRadius: 10, topTrailingRadius: 10).path(in: bounds).cgPath
        }
        backgroundMaskLayer.path = path
        backgroundView.layer.mask = backgroundMaskLayer
        
        backgroundStrokeLayer.path = path
        backgroundStrokeLayer.fillColor = UIColor.clear.cgColor
        backgroundStrokeLayer.strokeColor = .sh(.gray30)
    }
}

#Preview {
    let view = ItemCellIconView()
    view.imageName = "part-iron-plate"
    return view
}
