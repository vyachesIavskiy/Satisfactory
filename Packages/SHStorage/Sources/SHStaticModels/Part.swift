import Foundation
import SHModels

extension Part {
    package struct Static: Codable {
        package let id: String
        package let categoryID: String
        package var progressionIndex = 0
        package let formID: String
        package let isNaturalResource: Bool
        
        package init(id: String, categoryID: String, formID: String, isNaturalResource: Bool = false) {
            self.id = id
            self.categoryID = categoryID
            self.formID = formID
            self.isNaturalResource = isNaturalResource
        }
    }
    
    package init(_ part: Static) throws {
        try self.init(
            id: part.id,
            category: Category(fromID: part.categoryID), 
            progressionIndex: part.progressionIndex,
            form: Part.Form(fromID: part.formID),
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
    enum Error: LocalizedError {
        case invalidID(String)
        
        var errorDescription: String? {
            switch self {
            case let .invalidID(id): "Failed to initialized Part.Form with ID '\(id)'"
            }
        }
    }
}
