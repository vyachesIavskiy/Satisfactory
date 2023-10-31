import Foundation
import PersistentModels

final class PersistentStorageV2: VersionedPersistentStorage {
    let version = PersistentStorage.Version.v2
    
    private(set) var configuration = PersistentConfigurationV2()
    private(set) var pins = PersistentPinsV2()
    private(set) var productions = [PersistentProductionV2]()
    private(set) var factories = [PersistentFactoryV2]()
    
    private let persistence = _Persistence(directoryName: "V2")
    
    func canBeLoaded() throws -> Bool {
        try persistence.exists()
    }
    
    func load() throws {
        configuration = try persistence.load(PersistentConfigurationV2.self, fromFileName: .configuration)
        pins = try persistence.load(PersistentPinsV2.self, fromFileName: .pins)
        productions = try persistence.load(PersistentProductionV2.self, fromDirectoryName: .productions)
        factories = try persistence.load(PersistentFactoryV2.self, fromDirectoryName: .factories)
    }
    
    func save() throws {
        try persistence.save(pins, toFileName: .pins)
        try persistence.save(productions, toDirectoryName: .productions)
        try persistence.save(factories, toDirectoryName: .factories)
    }
    
    func erase() throws {
        try persistence.remove()
    }
    
    func saveInitial() throws {
        try persistence.save(PersistentPinsV2(), toFileName: .pins)
        try persistence.save([PersistentProductionV2](), toDirectoryName: .productions)
        try persistence.save([PersistentFactoryV2](), toDirectoryName: .factories)
    }
    
    func migrate(from legacy: PersistentStorageLegacy) throws {
        let pinnedParts = legacy.parts.filter(\.isPinned)
        let pinnedEquipment = legacy.equipment.filter(\.isPinned)
        let pinnedRecipes = legacy.recipes.filter(\.isPinned)
        
        pins = PersistentPinsV2(
            partIDs: pinnedParts.map(\.id),
            equipmentIDs: pinnedEquipment.map(\.id),
            recipeIDs: pinnedRecipes.map(\.id)
        )
        
        productions = [] // TODO: Migrate productions
        
        // TODO: Change UUID to uuid from TCA
        factories = [
            PersistentFactoryV2(id: UUID(), name: "Legacy", productionIDs: productions.map(\.id))
        ]
    }
}

private extension String {
    static let configuration = "Configuration"
    static let pins = "Pins"
    static let productions = "Productions"
    static let factories = "Factories"
}
