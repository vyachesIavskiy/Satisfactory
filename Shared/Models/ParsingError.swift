import Foundation

enum ParsingError: Error {
    case cannotParseUUIDFrom(String)
    case itemWithIdIsMissing(UUID)
    case buildingWithIdIsMissing(UUID)
}
