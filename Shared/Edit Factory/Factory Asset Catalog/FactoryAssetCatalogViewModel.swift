import SwiftUI
import SHStorage

@Observable
final class FactoryAssetCatalogViewModel {
    // MARK: Observed properties
    var sections = [Section]()
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    init() {
        buildSections()
    }
    
    private func buildSections() {
        let parts = storageService.parts().sorted(using: [
            KeyPathComparator(\.category),
            KeyPathComparator(\.progressionIndex)
        ])
        let equipment = storageService.equipment().sortedByProgression()
        let buildings = storageService.buildings().sortedByCategory()
        
        sections = [
            Section(id: .parts, assetNames: parts.map(\.id)),
            Section(id: .equipment, assetNames: equipment.map(\.id)),
            Section(id: .buildings, assetNames: buildings.map(\.id))
        ]
    }
}

extension FactoryAssetCatalogViewModel {
    struct Section: Identifiable {
        enum ID {
            case parts
            case equipment
            case buildings
        }
        
        let id: ID
        var assetNames: [String]
        var expanded = true
        
        var name: LocalizedStringKey {
            switch id {
            case .parts: "factory-asset-parts-section-name"
            case .equipment: "factory-asset-equipment-section-name"
            case .buildings: "factory-asset-buildings-section-name"
            }
        }
    }
}
