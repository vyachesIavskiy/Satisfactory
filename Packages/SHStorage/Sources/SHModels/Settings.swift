import Foundation

public struct Settings {
    public var itemViewStyle: ItemViewStyle
    public var autoSelectSingleRecipe: Bool
    public var autoSelectSinglePinnedRecipe: Bool
    
    public init(
        itemViewStyle: ItemViewStyle = .icon,
        autoSelectSingleRecipe: Bool = true,
        autoSelectSinglePinnedRecipe: Bool = false
    ) {
        self.itemViewStyle = itemViewStyle
        self.autoSelectSingleRecipe = autoSelectSingleRecipe
        self.autoSelectSinglePinnedRecipe = autoSelectSinglePinnedRecipe
    }
}

public extension Settings {
    func updating(
        itemViewStyle: ItemViewStyle? = nil,
        autoSelectSingleRecipe: Bool? = nil,
        autoSelectSinglePinnedRecipe: Bool? = nil
    ) -> Settings {
        Settings(
            itemViewStyle: itemViewStyle ?? self.itemViewStyle,
            autoSelectSingleRecipe: autoSelectSingleRecipe ?? self.autoSelectSingleRecipe,
            autoSelectSinglePinnedRecipe: autoSelectSinglePinnedRecipe ?? self.autoSelectSinglePinnedRecipe
        )
    }
}

extension Settings {
    public enum ItemViewStyle {
        case icon
        case row
        
        public var id: String {
            switch self {
            case .icon: "item-view-style-icon"
            case .row: "item-view-style-row"
            }
        }
        
        public var localizedName: String {
            NSLocalizedString(id, tableName: "Settings", bundle: .module, comment: "")
        }
        
        public init(fromID id: String) throws {
            self = switch id {
            case Self.icon.id: .icon
            case Self.row.id: .row
                
            default: throw Error.invalidID(id)
            }
        }
    }
}

private extension Settings.ItemViewStyle {
    enum Error: Swift.Error, CustomDebugStringConvertible {
        case invalidID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidID(id): "Failed to initialized Settings.ItemViewStyle with ID '\(id)'"
            }
        }
    }
}
