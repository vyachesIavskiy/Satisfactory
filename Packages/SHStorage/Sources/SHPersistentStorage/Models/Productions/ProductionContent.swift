import Foundation
import SHModels
import SHPersistentModels

extension Production.Content {
    init(
        _ v2: Production.Content.Persistent.V2,
        partProvider: (_ partID: String) -> Part,
        recipeProvider: (_ recipeID: String) -> Recipe
    ) {
        self = switch v2 {
        case let .singleItem(singleItemV2):
            .singleItem(
                Production.Content.SingleItem(
                    singleItemV2,
                    partProvider: partProvider,
                    recipeProvider: recipeProvider
                )
            )
            
        case let .fromResources(fromResourcesV2):
            .fromResources(Production.Content.FromResources(statistics: Statistics()))
            
        case let .power(powerV2):
            .power(Production.Content.Power())
        }
    }
}

extension Production.Content.Persistent.V2 {
    init(_ content: Production.Content) {
        self = switch content {
        case let .singleItem(singleItem): .singleItem(Production.Content.SingleItem.Persistent.V2(singleItem))
        case let .fromResources(fromResources): .fromResources(Production.Content.FromResources.Persistent.V2())
        case let .power(power): .power(Production.Content.Power.Persistent.V2())
        }
    }
}
