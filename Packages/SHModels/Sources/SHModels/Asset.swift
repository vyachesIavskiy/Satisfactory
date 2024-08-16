
public enum Asset: Hashable, Sendable {
    case legacy
    case abbreviation
    case assetCatalog(name: String)
}
