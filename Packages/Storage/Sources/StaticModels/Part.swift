import Foundation

public struct Part: Codable {
    public let id: String
    public let categoryID: String
    public let formID: String
    public let isNaturalResource: Bool
    
    public init(id: String, categoryID: String, formID: String, isNaturalResource: Bool = false) {
        self.id = id
        self.categoryID = categoryID
        self.formID = formID
        self.isNaturalResource = isNaturalResource
    }
}
