import Foundation
import SHModels

extension Settings.Persistent {
    public struct Legacy {
        public let itemViewStyle: Settings.ItemViewStyle
        
        public init(itemViewStyle: Settings.ItemViewStyle) {
            self.itemViewStyle = itemViewStyle
        }
    }
}
