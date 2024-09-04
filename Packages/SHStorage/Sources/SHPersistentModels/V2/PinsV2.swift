import Foundation
import SHModels

extension Pins.Persistent {
    public struct V2: Codable, Equatable {
        public var singleItemPartIDs: Set<String>
        public var fromResourcesPartIDs: Set<String>
        public var powerPartIDs: Set<String>
        public var singleItemEquipmentIDs: Set<String>
        public var fromResourcesEquipmentIDs: Set<String>
        public var powerBuildingIDs: Set<String>
        public var recipeIDs: Set<String>
        
        public init(
            singleItemPartIDs: Set<String> = [],
            fromResourcesPartIDs: Set<String> = [],
            powerPartIDs: Set<String> = [],
            singleItemEquipmentIDs: Set<String> = [],
            fromResourcesEquipmentIDs: Set<String> = [],
            powerBuildingIDs: Set<String> = [],
            recipeIDs: Set<String> = []
        ) {
            self.singleItemPartIDs = singleItemPartIDs
            self.fromResourcesPartIDs = fromResourcesPartIDs
            self.powerPartIDs = powerPartIDs
            self.singleItemEquipmentIDs = singleItemEquipmentIDs
            self.fromResourcesEquipmentIDs = fromResourcesEquipmentIDs
            self.powerBuildingIDs = powerBuildingIDs
            self.recipeIDs = recipeIDs
        }
    }
}
