
public protocol Item: BaseItem {
    var category: Category { get }
    var localizedDescription: String { get }
}

public extension Item {
    var localizedDescription: String {
        "<LOCALIZE ME>"
    }
}
