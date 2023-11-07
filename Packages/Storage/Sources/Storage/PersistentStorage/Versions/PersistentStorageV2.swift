import Foundation
import PersistentModels
import StorageLogger
import Dependencies

struct PersistentStorageV2Client: VersionedPersistentStorage {
    let version = PersistentStorage.Version.v2
    
    var configuration: () -> PersistentConfigurationV2
    var pins: () -> PersistentPinsV2
    var productions: () -> [PersistentProductionV2]
    var factories: () -> [PersistentFactoryV2]
    
    var setPins: (PersistentPinsV2) -> Void
    var setProductions: ([PersistentProductionV2]) -> Void
    var setFactories: ([PersistentFactoryV2]) -> Void
    
    var canBeLoaded: () throws -> Bool
    var load: () throws -> Void
    var save: () throws -> Void
    var saveInitial: () throws -> Void
    var remove: () throws -> Void
    
    func migrateFromLegacy() throws {
        let (pins, productions, factories) = migrate()
        
        setPins(pins)
        setProductions(productions)
        setFactories(factories)
        
        try save()
    }
}

extension PersistentStorageV2Client {
    static let live = {
        let live = Live()
        
        return PersistentStorageV2Client(
            configuration: { live.configuration },
            pins: { live.pins },
            productions: { live.productions },
            factories: { live.factories },
            setPins: { live.pins = $0 },
            setProductions: { live.productions = $0 },
            setFactories: { live.factories = $0 },
            canBeLoaded: live.canBeLoaded,
            load: live.load,
            save: live.save,
            saveInitial: live.saveInitial,
            remove: live.remove
        )
    }()
    
    static let failing = PersistentStorageV2Client(
        configuration: unimplemented("\(Self.self).configuration"),
        pins: unimplemented("\(Self.self).pins"),
        productions: unimplemented("\(Self.self).productions"),
        factories: unimplemented("\(Self.self).factories"),
        setPins: unimplemented("\(Self.self).setPins"),
        setProductions: unimplemented("\(Self.self).setProductions"),
        setFactories: unimplemented("\(Self.self).setFactories"),
        canBeLoaded: unimplemented("\(Self.self).canBeLoaded"),
        load: unimplemented("\(Self.self).load"),
        save: unimplemented("\(Self.self).save"),
        saveInitial: unimplemented("\(Self.self).saveInitial"),
        remove: unimplemented("\(Self.self).remove")
    )
    
    static let noop = PersistentStorageV2Client(
        configuration: { PersistentConfigurationV2() },
        pins: { PersistentPinsV2() },
        productions: { [] },
        factories: { [] },
        setPins: { _ in },
        setProductions: { _ in },
        setFactories: { _ in },
        canBeLoaded: { true },
        load: { },
        save: { },
        saveInitial: { },
        remove: { }
    )
    
    static func inMemory(
        configuration: PersistentConfigurationV2 = PersistentConfigurationV2(),
        pins: PersistentPinsV2 = PersistentPinsV2(),
        productions: [PersistentProductionV2] = [],
        factories: [PersistentFactoryV2] = []
    ) -> PersistentStorageV2Client {
        let inMemory = InMemory(
            configuration: PersistentConfigurationV2(),
            pins: pins,
            productions: productions,
            factories: factories
        )
        
        return PersistentStorageV2Client(
            configuration: { inMemory.configuration },
            pins: { inMemory.pins },
            productions: { inMemory.productions },
            factories: { inMemory.factories },
            setPins: { inMemory.pins = $0 },
            setProductions: { inMemory.productions = $0 },
            setFactories: { inMemory.factories = $0 },
            canBeLoaded: { true },
            load: { },
            save: { },
            saveInitial: { },
            remove: { }
        )
    }
}

extension PersistentStorageV2Client: DependencyKey {
    static let liveValue = live
    static let testValue = failing
    static let previewValue = noop
}

extension DependencyValues {
    var persistentStorageV2Client: PersistentStorageV2Client {
        get { self[PersistentStorageV2Client.self] }
        set { self[PersistentStorageV2Client.self] = newValue }
    }
}

private extension PersistentStorageV2Client {
    final class Live {
        var configuration = PersistentConfigurationV2()
        var pins = PersistentPinsV2()
        var productions = [PersistentProductionV2]()
        var factories = [PersistentFactoryV2]()
        
        private let persistence = Persistence(homeDirectoryName: "V2")
        private let logger = Logger(category: .persistentV2)
        
        func canBeLoaded() throws -> Bool {
            try persistence.canBeLoaded()
        }
        
        func load() throws {
            logger.log("Start loading PersistentStorageV2Client.Live")
            
            configuration = try persistence.load(modelType: PersistentConfigurationV2.self, from: .configuration)
            pins = try persistence.load(modelType: PersistentPinsV2.self, from: .pins)
            productions = try persistence.load(modelType: PersistentProductionV2.self, from: .productions)
            factories = try persistence.load(modelType: PersistentFactoryV2.self, from: .factories)
            
            logger.log("Finish loading PersistentStorageV2Client.Live")
        }
        
        func save() throws {
            logger.log("Start saving PersistentStorageV2Client.Live")
            
            try persistence.save(model: configuration, to: .configuration)
            try persistence.save(model: pins, to: .pins)
            try persistence.save(models: productions, to: .productions)
            try persistence.save(models: factories, to: .factories)
            
            logger.log("Finish saving PersistentStorageV2Client.Live")
        }
        
        func saveInitial() throws {
            logger.log("Start saving initial PersistentStorageV2Client.Live")
            
            try persistence.save(model: PersistentConfigurationV2(version: 1), to: .configuration)
            try persistence.save(model: PersistentPinsV2(), to: .pins)
            try persistence.save(models: [PersistentProductionV2](), to: .productions)
            try persistence.save(models: [PersistentFactoryV2](), to: .factories)
            
            logger.log("Finish saving initial PersistentStorageV2Client.Live")
        }
        
        func remove() throws {
            logger.log("Start removing PersistentStorageV2Client.Live")
            
            try persistence.remove()
            
            logger.log("Finish removing PersistentStorageV2Client.Live")
        }
    }
    
    final class InMemory {
        var configuration: PersistentConfigurationV2
        var pins: PersistentPinsV2
        var productions: [PersistentProductionV2]
        var factories: [PersistentFactoryV2]
        
        init(
            configuration: PersistentConfigurationV2 = PersistentConfigurationV2(),
            pins: PersistentPinsV2 = PersistentPinsV2(),
            productions: [PersistentProductionV2] = [],
            factories: [PersistentFactoryV2] = []
        ) {
            self.configuration = configuration
            self.pins = pins
            self.productions = productions
            self.factories = factories
        }
        
        func canBeLoaded() throws -> Bool {
            !pins.isEmpty || !productions.isEmpty || !factories.isEmpty
        }
        
        func load() throws { }
        func save() throws { }
        func saveInitial() throws { }
        
        func remove() throws {
            configuration = PersistentConfigurationV2()
            pins = PersistentPinsV2()
            productions.removeAll()
            factories.removeAll()
        }
    }
}

private func migrate() -> (PersistentPinsV2, [PersistentProductionV2], [PersistentFactoryV2]) {
    @Dependency(\.persistentStorageLegacyClient) var legacy
    
    let pinnedParts = legacy.parts().filter(\.isPinned)
    let pinnedEquipment = legacy.equipment().filter(\.isPinned)
    let pinnedRecipes = legacy.recipes().filter(\.isPinned)
    
    let pins = PersistentPinsV2(
        partIDs: Set(pinnedParts.map(\.id)),
        equipmentIDs: Set(pinnedEquipment.map(\.id)),
        recipeIDs: Set(pinnedRecipes.map(\.id))
    )
    
    let productions = [PersistentProductionV2]() // TODO: Migrate productions
    
    @Dependency(\.uuid) var uuid
    let factories = [
        PersistentFactoryV2(id: uuid(), name: "Legacy", productionIDs: productions.map(\.id))
    ]
    
    return (pins, productions, factories)
}

private extension String {
    static let configuration = "Configuration"
    static let pins = "Pins"
    static let productions = "Productions"
    static let factories = "Factories"
}
