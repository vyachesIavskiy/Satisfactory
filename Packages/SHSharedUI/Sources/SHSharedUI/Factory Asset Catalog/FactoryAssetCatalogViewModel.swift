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
        let buildings = storageService.buildings().sortedByCategory()
        
        sections = [
            Section(id: .parts, assetNames: parts.map(\.id)),
            Section(id: .buildings, assetNames: buildings.map(\.id))
        ]
    }
}

extension FactoryAssetCatalogViewModel {
    struct Section: Identifiable {
        enum ID {
            case parts
            case buildings
        }
        
        let id: ID
        var assetNames: [String]
        var expanded = true
        
        var name: LocalizedStringKey {
            switch id {
            case .parts: "factory-asset-parts-section-name"
            case .buildings: "factory-asset-buildings-section-name"
            }
        }
    }
}
