import Foundation
import Combine
import ConcurrencyExtras
import SHModels
import SHPersistentModels
import struct SHStaticModels.Migration
import SHStaticStorage
import SHLogger

package final class SHPersistentStorage {
    private let staticStorage: SHStaticStorage
    private let v2 = V2()
    private let logger = SHLogger(subsystemName: "SHStorage", category: "SHPersistentStorage")
    
    package var configuration: Configuration {
        get { Configuration(v2.configuration) }
        set { v2.configuration = Configuration.Persistent.V2(newValue) }
    }
    
    package var streamPins: AsyncStream<Pins> {
        v2.pins
            .map(Pins.init)
            .values
            .eraseToStream()
    }
    
    package var pins: Pins {
        Pins(v2.pins.value)
    }
    
    package var factories: [Factory] {
        v2.sortedFactories.map(Factory.init)
    }
    
    package var streamFactories: AsyncStream<[Factory]> {
        v2.sortedFactoriesStream
            .map { $0.map(Factory.init) }
            .eraseToStream()
    }
    
    package var productions: [Production] {
        v2.productions.value.map(map)
    }
    
    package var streamProductions: AsyncStream<[Production]> {
        v2.productions
            .map { [weak self] in
                guard let self else { return [] }
                
                return $0.map(map)
            }
            .values
            .eraseToStream()
    }
    
    package init(staticStorage: SHStaticStorage) {
        self.staticStorage = staticStorage
    }
    
    package func productions(inside factory: Factory) -> [Production] {
        v2.productions(inside: factory.id)
            .map(map)
    }
    
    package func streamProductions(inside factory: Factory) -> AsyncStream<[Production]> {
        v2.streamProductions(inside: factory.id)
            .map { [weak self] in
                guard let self else { return [] }
                
                return $0.map(map)
            }
            .eraseToStream()
    }
    
    // MARK: Loading
    package func load() throws {
        logger.info("Loading Persistent storage.")
        
        // Check if storage can be loaded
        let legacy = Legacy()
        let canLegacyBeLoaded = legacy.canBeLoaded()
        guard canLegacyBeLoaded || v2.canBeLoaded() else {
            logger.info("Persistent storage is not detected, saving initial data.")
            
            try v2.saveInitial()
            return
        }
        
        if !v2.canBeLoaded() {
            // Migrate
            let migration = createContentMigration()
            try migrateIfNeeded(legacy: legacy, migration: migration)
        } else {
            // Load v2 Storage
            try v2.load()
        }
        
        logger.info("Persistent Storage is loaded.")
    }
    
    // MARK: IsPinned
    package func isPartPinned(_ partID: String, productionType: ProductionType) -> Bool {
        v2.isPartPinned(partID, productionType: productionType)
    }
        
    package func isBuildingPinned(_ buildingID: String, productionType: ProductionType) -> Bool {
        v2.isBuildingPinned(buildingID, productionType: productionType)
    }
    
    package func isRecipePinned(_ recipeID: String) -> Bool {
        v2.isRecipePinned(recipeID)
    }
    
    // MARK: Change pin status
    package func changePartPinStatus(_ partID: String, productionType: ProductionType) throws {
        try v2.changePartPinStatus(partID, productionType: productionType)
    }
    
    package func changeBuildingPinStatus(_ buildingID: String, productionType: ProductionType) throws {
        try v2.changeBuildingPinStatus(buildingID, productionType: productionType)
    }
    
    package func changeRecipePinStatus(_ recipeID: String) throws {
        try v2.changeRecipePinStatus(recipeID)
    }
    
    // MARK: Save
    package func saveFactory(_ factory: Factory) throws {
        try v2.saveFactory(Factory.Persistent.V2(factory))
    }
    
    package func saveProduction(_ production: Production, to factoryID: UUID) throws {
        try v2.saveProduction(Production.Persistent.V2(production), to: factoryID)
    }
    
    package func saveProductionInformation(_ production: Production, to factoryID: UUID) throws {
        try v2.saveProductionInformation(Production.Persistent.V2(production), to: factoryID)
    }
    
    package func saveProductionContent(_ production: Production) throws {
        try v2.saveProductionContent(Production.Persistent.V2(production))
    }
    
    // MARK: Delete
    package func deleteFactory(_ factory: Factory) throws {
        try v2.deleteFactory(Factory.Persistent.V2(factory))
    }
    
    package func deleteProduction(_ production: Production) throws {
        try v2.deleteProduction(Production.Persistent.V2(production))
    }
    
    // MARK: Move
    package func moveFactories(fromOffsets: IndexSet, toOffset: Int) throws {
        try v2.moveFactories(fromOffsets: fromOffsets, toOffset: toOffset)
    }
    
    package func moveProductions(factory: Factory, fromOffsets: IndexSet, toOffset: Int) throws {
        try v2.moveProductions(factoryID: factory.id, fromOffsets: fromOffsets, toOffset: toOffset)
    }
}

// MARK: Migration
private extension SHPersistentStorage {
    func migrateIfNeeded(legacy: Legacy, migration: Migration?) throws {
        logger.info("Migrating Persistent storage.")
        
        func migrateLegacy() throws {
            if legacy.canBeLoaded() {
                logger.debug("Legacy storage detected. Migrating from Legacy to V2.")
                try legacy.load()
                try v2.migrate(legacy: legacy, migration: migration)
                try legacy.remove()
            }
        }
        
        // Handle each version separately
        try migrateLegacy()
        
        // Migrate next versions
        // try migrateV2()
    }
    
    func createContentMigration() -> Migration? {
        logger.info("Creating migration.")
        
        let contentVersion = configuration.version
        
        let remainingMigrations = staticStorage.migrations
            .filter { $0.version > contentVersion }
            .sorted()
        
        guard !remainingMigrations.isEmpty else {
            // There is no new migration, exit
            logger.info("Content does not require migration, skipping.")
            return nil
        }
        
        var migrationPlan = remainingMigrations[0]
        if remainingMigrations.count > 1 {
            for migration in remainingMigrations.dropLast() {
                migrationPlan.version = max(migrationPlan.version, migration.version)
                
                for (mergedIndex, partID) in migrationPlan.partIDs.enumerated() {
                    guard let migrationIndex = migration.partIDs.firstIndex(oldID: partID.newID)
                    else { continue }
                    
                    migrationPlan.partIDs[mergedIndex].newID = migration.partIDs[migrationIndex].newID
                }
                
                for (mergedIndex, recipeID) in migrationPlan.recipeIDs.enumerated() {
                    guard let migrationIndex = migration.recipeIDs.firstIndex(oldID: recipeID.newID)
                    else { continue }
                    
                    migrationPlan.recipeIDs[mergedIndex].newID = migration.recipeIDs[migrationIndex].newID
                }
            }
        }
        
        return migrationPlan
    }
}

// MARK: Mapping

private extension SHPersistentStorage {
    func map(_ savedProduction: Production.Persistent.V2) -> Production {
        Production(savedProduction, partProvider: part(id:), recipeProvider: recipe(id:))
    }
    
    func part(id: String) -> Part {
        guard let part = staticStorage[partID: id] else {
            fatalError("No part with id '\(id)'")
        }
        return part
    }
    
    func recipe(id: String) -> Recipe {
        guard let recipe = staticStorage[recipeID: id] else {
            fatalError("No recipe with id '\(id)'")
        }
        return recipe
    }
}

// MARK: - Errors
private extension SHPersistentStorage {
    enum Error: LocalizedError {
        case productionNotFound(UUID, factoryID: UUID)
        
        var errorDescription: String? {
            switch self {
            case .productionNotFound: "Production is not found."
            }
        }
        
        var failureReason: String? {
            switch self {
            case let .productionNotFound(id, factoryID):
                "Production '\(id)' cannot be found as a part of Factory '\(factoryID)'."
            }
        }
    }
}
