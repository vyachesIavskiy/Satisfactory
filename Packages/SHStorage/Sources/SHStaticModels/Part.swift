import Foundation
import SHModels

extension Part {
    public struct Static: Codable {
        public let id: String
        public let categoryID: String
        public var progressionIndex = 0
        public let formID: String
        public let isNaturalResource: Bool
        
        public init(id: String, categoryID: String, formID: String, isNaturalResource: Bool = false) {
            self.id = id
            self.categoryID = categoryID
            self.formID = formID
            self.isNaturalResource = isNaturalResource
        }
    }
    
    public init(_ part: Static) throws {
        try self.init(
            id: part.id,
            category: Category(fromID: part.categoryID), 
            progressionIndex: part.progressionIndex,
            form: SHModels.Part.Form(fromID: part.formID),
            isNaturalResource: part.isNaturalResource
        )
    }
}

private extension Part.Form {
    init(fromID id: String) throws {
        self = switch id {
        case Self.solid.id: .solid
        case Self.fluid.id: .fluid
        case Self.gas.id: .gas
            
        default: throw Error.invalidID(id)
        }
    }
}

private extension Part.Form {
    enum Error: Swift.Error, CustomDebugStringConvertible {
        case invalidID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidID(id): "Failed to initialized Part.Form with ID '\(id)'"
            }
        }
    }
}
