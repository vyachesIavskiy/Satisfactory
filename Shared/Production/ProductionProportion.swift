struct ProductionProportion: Codable {
    static let defaultFraction = 0.5
    static let defaultAmount = 1.0
    static let `default` = ProductionProportion(mode: .fraction, value: 1.0)
    
    var mode: Mode
    var value: Double
}

extension ProductionProportion {
    enum Mode: String, CaseIterable, Codable {
        case fraction
        case amount
        
        var title: String {
            switch self {
            case .fraction: return "Fraction"
            case .amount: return "Amount"
            }
        }
    }
}
