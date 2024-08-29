import Observation
import SHModels

@Observable
final class ProductionProportionViewModel {
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
    private let totalAmount: Double
    
    @MainActor
    init(
        proportion: Proportion,
        totalAmount: Double,
        numberOfRecipes: Int,
        onChange: @escaping (Proportion) -> Void
    ) {
        self.onChange = onChange
        switch proportion {
        case .auto:
            proportionDisplay = .auto
            fractionAmount = 100.0 / Double(numberOfRecipes)
            
        case let .fraction(fraction):
            proportionDisplay = .fraction
            fractionAmount = fraction * 100
            
        case .fixed:
            proportionDisplay = .fixed
            fractionAmount = 100.0 / Double(numberOfRecipes)
        }
        
        fixedAmount = totalAmount
        self.totalAmount = totalAmount
    }
    
    @MainActor
    func adjustFractionAmount() {
        fractionAmount = min(100.0, max(0.0, fractionAmount))
    }
    
    @MainActor
    func adjustFixedAmount() {
        fixedAmount = min(totalAmount, max(0.0, fixedAmount))
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
