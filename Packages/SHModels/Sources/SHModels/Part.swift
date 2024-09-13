import Foundation

public struct Part: Item {
    public let id: String
    public let category: Category
    public let progressionIndex: Int
    public let form: Form
    public let isNaturalResource: Bool
    
    public var description: String {
        "Part: \(localizedName)"
    }
    
    public init(id: String, category: Category, progressionIndex: Int, form: Form, isNaturalResource: Bool = false) {
        self.id = id
        self.category = category
        self.progressionIndex = progressionIndex
        self.form = form
        self.isNaturalResource = isNaturalResource
    }
}

public extension Part {
    enum Form: Sendable {
        case solid
        case fluid
        case gas
        case matter
        
        public var id: String {
            switch self {
            case .solid: "part-form-solid"
            case .fluid: "part-form-fluid"
            case .gas: "part-form-gas"
            case .matter: "part-form-matter"
            }
        }
        
        public var localizedName: String {
            NSLocalizedString(id, tableName: "Part Forms", bundle: .module, comment: "")
        }
    }
}

public extension Sequence<Part> {
    func sortedByProgression() -> [Element] {
        sorted(using: KeyPathComparator(\.progressionIndex))
    }
}

public extension [Part] {
    mutating func sortByProgression() {
        self = sortedByProgression()
    }
}
