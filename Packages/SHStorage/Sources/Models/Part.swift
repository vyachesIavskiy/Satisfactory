import Foundation

// MARK: Model

public struct Part: Item {
    public let id: String
    public let category: Category
    public let form: Form
    public let isNaturalResource: Bool
    
    public init(id: String, category: Category, form: Form, isNaturalResource: Bool = false) {
        self.id = id
        self.category = category
        self.form = form
        self.isNaturalResource = isNaturalResource
    }
}

public extension Part {
    enum Form {
        case solid
        case fluid
        case gas
        
        public var id: String {
            switch self {
            case .solid: "part-form-solid"
            case .fluid: "part-form-fluid"
            case .gas: "part-form-gas"
            }
        }
    }
}
