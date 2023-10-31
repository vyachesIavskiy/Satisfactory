import Foundation
import PersistentModels

final class PersistentStorageLegacy: VersionedPersistentStorage {
    let version = PersistentStorage.Version.legacy
    
    var parts = [PersistentPartLegacy]()
    var equipment = [PersistentEquipmentLegacy]()
    var recipes = [PersistentRecipeLegacy]()
    var productions = [PersistentProductionLegacy]()
    
    private let persistence = _Persistence(directoryName: "")
    
    func canBeLoaded() throws -> Bool {
        // PersistenceStorageLegacy did not store it's content under a respected folder,
        // so we need to check for 'version.json' file.
        let versionURL = try persistence.url(for: .version)
        return persistence.urlExists(versionURL)
    }
    
    func load() throws {
        parts = try persistence.load([PersistentPartLegacy].self, fromFileName: .parts)
        equipment = try persistence.load([PersistentEquipmentLegacy].self, fromFileName: .equipment)
        recipes = try persistence.load([PersistentRecipeLegacy].self, fromFileName: .recipes)
        productions = try persistence.load([PersistentProductionLegacy].self, fromFileName: .productions)
    }
    
    func erase() throws {
        let urlsToRemove = try [
            persistence.url(for: .version),
            persistence.url(for: .parts),
            persistence.url(for: .equipment),
            persistence.url(for: .buildings),
            persistence.url(for: .vehicles),
            persistence.url(for: .recipes),
            persistence.url(for: .productions)
        ]
        
        try persistence.remove(urls: urlsToRemove)
    }
}

private extension String {
    static let version = "version"
    static let parts = "Parts"
    static let equipment = "Equipments"
    static let buildings = "Buildings"
    static let vehicles = "Vehicles"
    static let recipes = "Recipes"
    static let productions = "Productions"
}
