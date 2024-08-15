
public enum SHProductionProportion: Hashable, Codable, Sendable {
    case auto
    case fraction(Double)
    case fixed(Double)
}
