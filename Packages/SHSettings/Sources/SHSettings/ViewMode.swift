import Foundation

public enum ViewMode: Identifiable, Equatable {
    case icon
    case row
    
    public var id: String {
        switch self {
        case .icon: "item-view-style-icon"
        case .row: "item-view-style-row"
        }
    }
    
    public var localizedName: String {
        NSLocalizedString(id, bundle: .module, comment: "")
    }
}

extension ViewMode: Codable {
    init?(id: String) {
        switch id {
        case Self.icon.id: self = .icon
        case Self.row.id: self = .row
            
        default: return nil
        }
    }
    
    public init(from decoder: any Decoder) throws {
        let container = try decoder.singleValueContainer()
        let id = try container.decode(String.self)
        self = if let value = ViewMode(id: id) {
            value
        } else {
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: container.codingPath,
                debugDescription: "ItemViewStyle cannot be constructed from ID '\(id)'"
            ))
        }
    }
    
    public func encode(to encoder: any Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(id)
    }
}
