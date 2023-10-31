
public protocol BaseItem {
    var id: String { get }
    var localizedName: String { get }
}

public extension BaseItem {
    var localizedName: String {
        "<LOCALIZE ME>"
    }
}

public extension Equatable where Self: BaseItem {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
}

public extension Sequence where Element: BaseItem {
    func first(id: String) -> Element? {
        first { $0.id == id }
    }
}
