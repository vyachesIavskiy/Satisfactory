import Foundation
import Models
import PersistentModels
import Dependencies
import SHLogger

extension Storage.Persistent {
    final class V2: VersionedPersistentStorage {
        let version = Storage.Persistent.Version.v2
        
        var configuration = Configuration.Persistent.V2()
        var pins = Pins.Persistent.V2()
        var productions = [Production.Persistent.V2]()
        var factories = [Factory.Persistent.V2]()
        var settings = Settings.Persistent.V2()
        
        private let persistence = Persistence(homeDirectoryName: "V2")
        private let _logger = SHLogger(category: "Persistent.V2")
        
        func canBeLoaded() throws -> Bool {
            try persistence.canBeLoaded()
        }
        
        func load() throws {
            _logger {
                $0.info("Loading Storage.Persistent.V2")
            }
            
            configuration = try persistence.load(modelType: Configuration.Persistent.V2.self, from: .configuration)
            pins = try persistence.load(modelType: Pins.Persistent.V2.self, from: .pins)
            productions = try persistence.load(modelType: Production.Persistent.V2.self, from: .productions)
            factories = try persistence.load(modelType: Factory.Persistent.V2.self, from: .factories)
            settings = try persistence.load(modelType: Settings.Persistent.V2.self, from: .settings)
            
            _logger {
                $0.info("Storage.Persistent.V2 loaded")
            }
        }
        
        func save() throws {
            _logger {
                $0.info("Saving Storage.Persistent.V2")
            }
            
            try persistence.save(model: configuration, to: .configuration)
            try persistence.save(model: pins, to: .pins)
            try persistence.save(models: productions, to: .productions)
            try persistence.save(models: factories, to: .factories)
            try persistence.save(model: settings, to: .settings)
            
            _logger {
                $0.info("Storage.Persistent.V2 saved")
            }
        }
        
        func saveInitial() throws {
            _logger {
                $0.info("Saving initial Storage.Persistent.V2")
            }
            
            try persistence.createHomeDirectory()
            try persistence.save(model: Configuration.Persistent.V2(version: 1), to: .configuration)
            try persistence.save(model: Pins.Persistent.V2(), to: .pins)
            try persistence.save(models: [Production.Persistent.V2](), to: .productions)
            try persistence.save(models: [Factory.Persistent.V2](), to: .factories)
            try persistence.save(model: Settings.Persistent.V2(), to: .settings)
            
            _logger {
                $0.info("Initial Storage.Persistent.V2 saved")
            }
        }
        
        func remove() throws {
            _logger {
                $0.info("Removing Storage.Persistent.V2")
            }
            
            try persistence.remove()
            
            _logger {
                $0.info("Storage.Persistent.V2 removed")
            }
        }
        
        func migrate(from legacy: Storage.Persistent.Legacy) throws {
            _logger {
                $0.info("Migrating from Storage.Persistent.Legacy to Storage.Persistent.V2")
            }
            
            let pinnedParts = legacy.parts.filter(\.isPinned)
            let pinnedEquipment = legacy.equipment.filter(\.isPinned)
            let pinnedRecipes = legacy.recipes.filter(\.isPinned)
            
            pins = Pins.Persistent.V2(
                partIDs: Set(pinnedParts.map(\.id)),
                equipmentIDs: Set(pinnedEquipment.map(\.id)),
                recipeIDs: Set(pinnedRecipes.map(\.id))
            )
            
            productions = [Production.Persistent.V2]() // TODO: Migrate productions
            
            @Dependency(\.uuid) var uuid
            factories = [
                Factory.Persistent.V2(id: uuid(), name: "Legacy", productionIDs: productions.map(\.id))
            ]
            
            settings = Settings.Persistent.V2(itemViewStyleID: legacy.settings.itemViewStyle.id)
            
            try save()
            
            _logger {
                $0.info("Storage.Persistent.Legacy migrated to Storage.Persistent.V2")
            }
        }
    }
}

private extension String {
    static let configuration = "Configuration"
    static let pins = "Pins"
    static let productions = "Productions"
    static let factories = "Factories"
    static let settings = "Settings"
}
