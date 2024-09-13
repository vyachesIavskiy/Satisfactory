import Foundation
import SHModels

extension Pins.Persistent {
    package struct V2: Codable, Equatable {
        package var singleItemPartIDs: Set<String>
        package var fromResourcesPartIDs: Set<String>
        package var powerPartIDs: Set<String>
        package var powerBuildingIDs: Set<String>
        package var recipeIDs: Set<String>
        
        package init(
            singleItemPartIDs: Set<String> = [],
            fromResourcesPartIDs: Set<String> = [],
            powerPartIDs: Set<String> = [],
            powerBuildingIDs: Set<String> = [],
            recipeIDs: Set<String> = []
        ) {
            self.singleItemPartIDs = singleItemPartIDs
            self.fromResourcesPartIDs = fromResourcesPartIDs
            self.powerPartIDs = powerPartIDs
            self.powerBuildingIDs = powerBuildingIDs
            self.recipeIDs = recipeIDs
        }
    }
}
