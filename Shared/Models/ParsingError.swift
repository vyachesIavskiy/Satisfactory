import Foundation

enum ParsingError: Error {
    case cannotParseUUIDFrom(String)
    case itemWithIdIsMissing(UUID)
    case buildingWithIdIsMissing(UUID)
    
    var localizedDescription: String { description }
}

extension ParsingError: CustomStringConvertible {
    var description: String {
        switch self {
        case .cannotParseUUIDFrom(let uuidString):
            return "Satisfactory Parsing Error: Cannot parse UUID from \(uuidString)"
            
        case .itemWithIdIsMissing(let uuid):
            return "Satisfactory Parsing Error: Cannot find an item with \(uuid.uuidString)"
            
        case .buildingWithIdIsMissing(let uuid):
            return "Satisfactory Parsing Error: Cannot find a building with \(uuid.uuidString)"
        }
    }
}
