import UIKit

struct ToggleCellConfiguration: UIContentConfiguration {
    var title: String
    var subtitle: String?
    var isOn: Bool
    var onToggle: (_ newValue: Bool) -> Void
    
    func makeContentView() -> any UIView & UIContentView {
        ToggleContentView(configuration: self)
    }
    
    func updated(for state: any UIConfigurationState) -> ToggleCellConfiguration {
        self
    }
}

extension ToggleCellConfiguration: Hashable {
    static func == (lhs: ToggleCellConfiguration, rhs: ToggleCellConfiguration) -> Bool {
        lhs.title == rhs.title &&
        lhs.subtitle == rhs.subtitle &&
        lhs.isOn == rhs.isOn
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title)
        hasher.combine(subtitle)
        hasher.combine(isOn)
    }
}

private final class ToggleContentView: UIView, UIContentView {
    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let toggle = UISwitch()
    private var actionID: UIAction.Identifier?
    
    var configuration: any UIContentConfiguration {
        didSet {
            applyConfiguration()
        }
    }
    
    init(configuration: ToggleCellConfiguration) {
        self.configuration = configuration
        
        super.init(frame: .zero)
        
        layout()
        applyConfiguration()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        subtitleLabel.font = .preferredFont(forTextStyle: .caption1)
        subtitleLabel.textColor = .secondaryLabel
        subtitleLabel.numberOfLines = 0
        
        toggle.onTintColor = .sh(.orange)
        
        let hStack = UIStackView(arrangedSubviews: [titleLabel, toggle])
        hStack.axis = .horizontal
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.distribution = .fill
        
        let vStack = UIStackView(arrangedSubviews: [hStack, subtitleLabel])
        vStack.axis = .vertical
        vStack.spacing = 8
        vStack.alignment = .leading
        vStack.distribution = .fill
        
        addSubview(vStack)
        vStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            vStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            vStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            vStack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            vStack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
            hStack.widthAnchor.constraint(equalTo: vStack.widthAnchor, multiplier: 1.0)
        ])
    }
    
    private func applyConfiguration() {
        guard let configuration = configuration as? ToggleCellConfiguration else { return }
        
        titleLabel.text = configuration.title
        subtitleLabel.text = configuration.subtitle
        subtitleLabel.isHidden = configuration.subtitle == nil
        if toggle.isOn != configuration.isOn {
            toggle.isOn = configuration.isOn
        }
        if let actionID {
            toggle.removeAction(identifiedBy: actionID, for: .valueChanged)
        }
        
        let action = UIAction { [unowned toggle] _ in
            configuration.onToggle(toggle.isOn)
        }
        actionID = action.identifier
        toggle.addAction(action, for: .valueChanged)
    }
}

#Preview("Toggle cell") {
    ToggleContentView(
        configuration: ToggleCellConfiguration(
            title: "Show recipe ingredient names",
            subtitle: "If it is difficult for you to distinguish recipe ingredients only by it's icon, you can enable this setting to also see recipe ingredient names.",
            isOn: true,
            onToggle: { _ in }
        )
    )
}
