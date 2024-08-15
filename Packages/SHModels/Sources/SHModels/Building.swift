
public struct Building: Item {
    public let id: String
    public let category: Category
    
    public var description: String {
        "Building: \(localizedName)"
    }
    
    public init(id: String, category: Category) {
        self.id = id
        self.category = category
    }
}
