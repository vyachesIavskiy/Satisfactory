import Foundation

enum ParsingError: Error {
    case cannotParseUUIDFrom(String)
    case partWithIdIsNotPresent(UUID)
}
