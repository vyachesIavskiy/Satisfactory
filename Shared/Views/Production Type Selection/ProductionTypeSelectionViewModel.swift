import SwiftUI
import SHModels
import SHStorage

@Observable
final class ProductionTypeSelectionViewModel {
    // MARK: Ignored
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    var productionTypes: [ProductionTypeRow] {
        [
            ProductionTypeRow(
                id: .singleItem,
                title: "new-production-single-item-production-title",
                description: "new-production-single-item-production-description",
                previewItemIDs: [
                    "part-iron-plate",
                    "part-modular-frame",
                    "part-turbofuel",
                    "part-aluminum-casing",
                    "part-turbo-motor",
                    "part-nuclear-pasta"
                ]
            ),
            ProductionTypeRow(
                id: .fromResources,
                title: "new-production-from-resources-production-title",
                description: "new-production-from-resources-production-description",
                previewItemIDs: [
                    "part-iron-ore",
                    "part-limestone",
                    "part-crude-oil",
                    "part-raw-quartz",
                    "part-nitrogen-gas"
                ]
            ),
            ProductionTypeRow(
                id: .power,
                title: "new-production-power-production-title",
                description: "new-production-power-production-description",
                previewItemIDs: [
                    "building-biomass-burner",
                    "building-coal-generator",
                    "building-fuel-generator",
                    "building-nuclear-power-plant"
                ]
            )
        ]
    }
    
    func item(_ itemID: String) -> (any Item)? {
        storageService.item(id: itemID)
    }
}

extension ProductionTypeSelectionViewModel {
    struct ProductionTypeRow: Identifiable {
        let id: ProductionType
        let title: LocalizedStringKey
        let description: LocalizedStringKey
        let previewItemIDs: [String]
    }
}
