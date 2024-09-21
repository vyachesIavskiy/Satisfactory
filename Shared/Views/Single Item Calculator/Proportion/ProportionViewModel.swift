import SwiftUI
import TipKit
import SHModels

@Observable
final class ProportionViewModel {
    enum ProductionProportionDisplay {
        case auto
        case fraction
        case fixed
    }
    
    @MainActor @ObservationIgnored
    var proportionDisplay: ProductionProportionDisplay {
        didSet {
            update()
        }
    }
    
    @MainActor @ObservationIgnored
    var fractionAmount: Double
    
    @MainActor @ObservationIgnored
    var fixedAmount: Double
    
    @ObservationIgnored
    private var onChange: (Proportion) -> Void
    
    @ObservationIgnored
    private let itemAmount: Double
    
    let proportionTip: ProportionTip?
    
    @MainActor
    init(
        proportion: Proportion,
        recipeAmount: Double,
        itemAmount: Double,
        showTip: Bool,
        onChange: @escaping (Proportion) -> Void
    ) {
        self.onChange = onChange
        switch proportion {
        case .auto:
            proportionDisplay = .auto
            fractionAmount = (recipeAmount / itemAmount) * 100.0
            
        case let .fraction(fraction):
            proportionDisplay = .fraction
            fractionAmount = fraction * 100
            
        case .fixed:
            proportionDisplay = .fixed
            fractionAmount = (recipeAmount / itemAmount) * 100.0
        }
        
        fixedAmount = recipeAmount
        self.itemAmount = itemAmount
        proportionTip = if showTip {
            ProportionTip()
        } else {
            nil
        }
    }
    
    @MainActor
    func adjustFractionAmount() {
        fractionAmount = min(100.0, max(0.0, fractionAmount))
    }
    
    @MainActor
    func adjustFixedAmount() {
        fixedAmount = min(itemAmount, max(0.0, fixedAmount))
    }
    
    @MainActor
    func update() {
        switch proportionDisplay {
        case .auto:
            onChange(.auto)
            
        case .fraction:
            onChange(.fraction(fractionAmount / 100))
            
        case .fixed:
            onChange(.fixed(fixedAmount))
        }
    }
}

extension ProportionViewModel {
    struct ProportionTip: Tip {
        var title: Text {
            Text("single-item-production-tip-proportion-title")
        }
        
        var message: Text? {
            Text("single-item-production-tip-proportion-message")
        }
        
        var options: [any TipOption] = [
            MaxDisplayCount(1)
        ]
    }
}
