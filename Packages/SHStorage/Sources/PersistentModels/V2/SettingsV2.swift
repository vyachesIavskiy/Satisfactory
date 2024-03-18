import Foundation
import Models

extension Settings.Persistent {
    public struct V2: Codable {
        public var itemViewStyleID: String
        public var autoSelectSingleRecipe: Bool
        public var autoSelectSinglePinnedRecipe: Bool
        
        public init(
            itemViewStyleID: String = Settings.ItemViewStyle.icon.id,
            autoSelectSingleRecipe: Bool = true,
            autoSelectSinglePinnedRecipe: Bool = false
        ) {
            self.itemViewStyleID = itemViewStyleID
            self.autoSelectSingleRecipe = autoSelectSingleRecipe
            self.autoSelectSinglePinnedRecipe = autoSelectSinglePinnedRecipe
        }
    }
}
