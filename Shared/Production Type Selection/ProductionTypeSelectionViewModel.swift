import SwiftUI
import SHModels
import SHStorage

@Observable
final class ProductionTypeSelectionViewModel {
    var selectedProductionType: ProductionType?
    
    @MainActor
    var navigationPath = [NavigationPath]()
    
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
    
    @MainActor
    func singeItemSelected(_ item: any Item) {
        navigationPath.append(.production(.singleItem, item))
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

extension ProductionTypeSelectionViewModel {
    enum NavigationPath {
        case productionType(ProductionType)
        case production(ProductionType, any Item)
    }
}

extension ProductionTypeSelectionViewModel.NavigationPath: Hashable {
    static func == (lhs: ProductionTypeSelectionViewModel.NavigationPath, rhs: ProductionTypeSelectionViewModel.NavigationPath) -> Bool {
        switch (lhs, rhs) {
        case let (.productionType(lhs), .productionType(rhs)):
            lhs == rhs
            
        case let (.production(lhsProductionType, lhsItem), .production(rhsProductionType, rhsItem)):
            lhsProductionType == rhsProductionType && lhsItem.id == rhsItem.id
            
        default:
            false
        }
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case let .productionType(productionType):
            hasher.combine(productionType)
            
        case let .production(productionType, item):
            hasher.combine(productionType)
            hasher.combine(item.id)
        }
    }
}
