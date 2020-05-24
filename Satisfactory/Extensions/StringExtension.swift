import Foundation

extension String {
    func uuid() throws -> UUID {
        guard let uuid = UUID(uuidString: self) else {
            throw ParsingError.cannotParseUUIDFrom(self)
        }
        
        return uuid
    }
}
