import Foundation
import SHModels
import SHPersistentModels

extension Production {
    init(
        _ v2: Persistent.V2,
        itemProvider: (_ itemID: String) -> any Item,
        recipeProvider: (_ recipeID: String) -> Recipe
    ) {
        self = switch v2 {
        case let .singleItem(singleItemV2):
            .singleItem(
                SingleItemProduction(
                    singleItemV2,
                    itemProvider: itemProvider,
                    recipeProvider: recipeProvider
                )
            )
            
        case let .fromResources(fromResourcesV2):
            .fromResources(FromResourcesProduction(id: UUID(), name: "", assetName: "", statistics: Statistics()))
            
        case let .power(powerV2):
            .power(PowerProduction(id: UUID(), name: "", assetName: ""))
        }
    }
}

extension Production.Persistent.V2 {
    init(_ production: Production) {
        self = switch production {
        case let .singleItem(singleItem): .singleItem(SingleItemProduction.Persistent.V2(singleItem))
        case let .fromResources(fromResources):
            .fromResources(FromResourcesProduction.Persistent.V2(id: UUID(), name: "", asset: .abbreviation))
        case let .power(power):
            .power(PowerProduction.Persistent.V2(id: UUID(), name: "", asset: .abbreviation))
        }
    }
}
