import Foundation
import PersistentModels
import StorageLogger
import Dependencies

struct PersistentStorageLegacyClient: VersionedPersistentStorage {
    let version = PersistentStorage.Version.legacy
    
    var parts: () -> [PersistentPartLegacy]
    var equipment: () -> [PersistentEquipmentLegacy]
    var recipes: () -> [PersistentRecipeLegacy]
    var productions: () -> [PersistentProductionLegacy]
    
    var setParts: ([PersistentPartLegacy]) -> Void
    var setEquipment: ([PersistentEquipmentLegacy]) -> Void
    var setRecipes: ([PersistentRecipeLegacy]) -> Void
    var setProductions: ([PersistentProductionLegacy]) -> Void
    
    var canBeLoaded: () throws -> Bool
    var load: () throws -> Void
    var remove: () throws -> Void
}

extension PersistentStorageLegacyClient: DependencyKey {
    static let liveValue = live
    static let testValue = failing
    static let previewValue = noop
}

extension DependencyValues {
    var persistentStorageLegacyClient: PersistentStorageLegacyClient {
        get { self[PersistentStorageLegacyClient.self] }
        set { self[PersistentStorageLegacyClient.self] = newValue }
    }
}

extension PersistentStorageLegacyClient {
    static let live = {
        let live = Live()
        
        return PersistentStorageLegacyClient(
            parts: { live.parts },
            equipment: { live.equipment },
            recipes: { live.recipes },
            productions: { live.productions },
            setParts: { live.parts = $0 },
            setEquipment: { live.equipment = $0 },
            setRecipes: { live.recipes = $0 },
            setProductions: { live.productions = $0 },
            canBeLoaded: live.canBeLoaded,
            load: live.load,
            remove: live.remove
        )
    }()
    
    static let failing = PersistentStorageLegacyClient(
        parts: unimplemented("\(Self.self).parts"),
        equipment: unimplemented("\(Self.self).equipment"),
        recipes: unimplemented("\(Self.self).recipes"),
        productions: unimplemented("\(Self.self).productions"),
        setParts: unimplemented("\(Self.self).setParts"),
        setEquipment: unimplemented("\(Self.self).setEquipment"),
        setRecipes: unimplemented("\(Self.self).setRecipes"),
        setProductions: unimplemented("\(Self.self).setProductions"),
        canBeLoaded: unimplemented("\(Self.self).canBeLoaded"),
        load: unimplemented("\(Self.self).load"),
        remove: unimplemented("\(Self.self).remove")
    )
    
    static let noop = PersistentStorageLegacyClient(
        parts: { [] },
        equipment: { [] },
        recipes: { [] },
        productions: { [] },
        setParts: { _ in },
        setEquipment: { _ in },
        setRecipes: { _ in },
        setProductions: { _ in },
        canBeLoaded: { true },
        load: { },
        remove: { }
    )
    
    static func inMemory(
        parts: [PersistentPartLegacy] = [],
        equipment: [PersistentEquipmentLegacy] = [],
        recipes: [PersistentRecipeLegacy] = [],
        productions: [PersistentProductionLegacy] = []
    ) -> PersistentStorageLegacyClient {
        let inMemory = InMemory(parts: parts, equipment: equipment, recipes: recipes, productions: productions)
        
        return PersistentStorageLegacyClient(
            parts: { inMemory.parts },
            equipment: { inMemory.equipment },
            recipes: { inMemory.recipes },
            productions: { inMemory.productions },
            setParts: { inMemory.parts = $0 },
            setEquipment: { inMemory.equipment = $0 },
            setRecipes: { inMemory.recipes = $0 },
            setProductions: { inMemory.productions = $0 },
            canBeLoaded: inMemory.canBeLoaded,
            load: { },
            remove: { }
        )
    }
}

private extension PersistentStorageLegacyClient {
    final class Live {
        var parts = [PersistentPartLegacy]()
        var equipment = [PersistentEquipmentLegacy]()
        var recipes = [PersistentRecipeLegacy]()
        var productions = [PersistentProductionLegacy]()
        
        private let persistence = Persistence()
        private let logger = Logger(category: .persistentLegacy)
        
        @Dependency(\.fileManagerClient) private var fileManager
        
        func canBeLoaded() throws -> Bool {
            // PersistenceStorageLegacy did not store it's content under a respected folder,
            // so we need to check for 'version.json' file.
            try fileManager.fileExistsAt(.version, .json)
        }
        
        func load() throws {
            logger.log("Start loading PersistentStorageLegacyClient.Live")
            
            parts = try persistence.load(modelType: [PersistentPartLegacy].self, from: .parts)
            equipment = try persistence.load(modelType: [PersistentEquipmentLegacy].self, from: .equipment)
            recipes = try persistence.load(modelType: [PersistentRecipeLegacy].self, from: .recipes)
            productions = try persistence.load(modelType: [PersistentProductionLegacy].self, from: .productions)
            
            logger.log("Finished loading PersistentStorageLegacyClient.Live")
        }
        
        func remove() throws {
            logger.log("Start removing PersistentStorageLegacyClient.Live")
            
            try fileManager.removeFileAt(.version, .json)
            try fileManager.removeFileAt(.parts, .json)
            try fileManager.removeFileAt(.equipment, .json)
            try fileManager.removeFileAt(.buildings, .json)
            try fileManager.removeFileAt(.vehicles, .json)
            try fileManager.removeFileAt(.recipes, .json)
            try fileManager.removeFileAt(.productions, .json)
            
            logger.log("Finished removing PersistentStorageLegacyClient.Live")
        }
    }
    
    final class InMemory {
        var parts: [PersistentPartLegacy]
        var equipment: [PersistentEquipmentLegacy]
        var recipes: [PersistentRecipeLegacy]
        var productions: [PersistentProductionLegacy]
        
        init(
            parts: [PersistentPartLegacy] = [],
            equipment: [PersistentEquipmentLegacy] = [],
            recipes: [PersistentRecipeLegacy] = [],
            productions: [PersistentProductionLegacy] = []
        ) {
            self.parts = parts
            self.equipment = equipment
            self.recipes = recipes
            self.productions = productions
        }
        
        func canBeLoaded() throws -> Bool {
            !parts.isEmpty || !equipment.isEmpty || !recipes.isEmpty || !productions.isEmpty
        }
        
        func load() throws { }
        func save() throws { }
        func saveInitial() throws { }
        
        func remove() throws {
            parts.removeAll()
            equipment.removeAll()
            recipes.removeAll()
            productions.removeAll()
        }
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
