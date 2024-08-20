import Foundation

public struct Extraction: Hashable, Sendable {
    public let building: Building
    public let naturalResources: [Part]
    public let rates: [Rate]
    
    public init(building: Building, naturalResources: [Part], rates: [Rate]) {
        self.building = building
        self.naturalResources = naturalResources
        self.rates = rates
    }
}

extension Extraction {
    public struct Rate: Hashable, Sendable {
        public let purity: Purity
        public let amount: Double
        
        public init(purity: Purity, amount: Double) {
            self.purity = purity
            self.amount = amount
        }
    }
}

extension Extraction {
    public enum Purity: Hashable, Sendable {
        case impure
        case normal
        case pure
        
        public var id: String {
            switch self {
            case .impure: "purity-impure"
            case .normal: "purity-normal"
            case .pure: "purity-pure"
            }
        }
        
        public var localizedName: String {
            NSLocalizedString(id, tableName: "Extractions", bundle: .module, comment: "")
        }
    }
}
