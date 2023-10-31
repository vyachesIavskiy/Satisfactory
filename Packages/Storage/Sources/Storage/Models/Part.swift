import StaticModels
import Models

extension Models.Part {
    init(_ part: StaticModels.Part) throws {
        try self.init(
            id: part.id,
            category: Category(fromID: part.categoryID),
            form: Models.Part.Form(fromID: part.formID),
            isNaturalResource: part.isNaturalResource
        )
    }
}

private extension Models.Part.Form {
    init(fromID id: String) throws {
        self = switch id {
        case Self.solid.id: .solid
        case Self.fluid.id: .fluid
        case Self.gas.id: .gas
            
        default: throw Error.invalidID(id)
        }
    }
}

private extension Models.Part.Form {
    enum Error: Swift.Error, CustomDebugStringConvertible {
        case invalidID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidID(id): "Failed to initialized Part.Form with ID '\(id)'"
            }
        }
    }
}
