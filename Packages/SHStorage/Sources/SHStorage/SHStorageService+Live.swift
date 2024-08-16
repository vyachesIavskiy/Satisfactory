import Combine
import SHModels
import SHPersistentStorage
import SHStaticStorage
import SHLogger

extension SHStorageService {
    @dynamicMemberLookup
    final class Live {
        private let staticStorage = SHStaticStorage()
        private let persistentStorage: SHPersistentStorage
        
        var staticConfiguration: Configuration {
            staticStorage.configuration
        }
        
        var persistentConfiguration: Configuration {
            persistentStorage.configuration
        }
        
        var pins: Pins {
            persistentStorage.pins
        }
        
        var streamPins: AsyncStream<Pins> {
            persistentStorage.streamPins
        }
        
        var factories: [Factory] {
            persistentStorage.factories
        }
        
        var streamFactories: AsyncStream<[Factory]> {
            persistentStorage.streamFactories
        }
        
        var productions: [SingleItemProduction] {
            persistentStorage.productions
        }
        
        var streamProductions: AsyncStream<[SingleItemProduction]> {
            persistentStorage.streamProductions
        }
        
        init() {
            persistentStorage = SHPersistentStorage(staticStorage: staticStorage)
        }
        
        // MARK: Dynamic members
        subscript<M>(dynamicMember keyPath: KeyPath<SHStaticStorage, M>) -> M {
            staticStorage[keyPath: keyPath]
        }
        
        // MARK: Loading
        func load(_ options: LoadOptions) throws {
            try staticStorage.load()
            try persistentStorage.load(options)
        }
        
        func loadForMigration() throws {
            try staticStorage.load()
        }
        
        // MARK: Change pin status
        func changePartPinStatus(_ partID: String) {
            try? persistentStorage.changePartPinStatus(partID)
        }
        
        func changeEquipmentPinStatus(_ equipmentID: String) {
            try? persistentStorage.changeEquipmentPinStatus(equipmentID)
        }
        
        func changeRecipePinStatus(_ recipeID: String) {
            try? persistentStorage.changeRecipePinStatus(recipeID)
        }
        
        // MARK: Saving
        func saveFactory(_ factory: Factory) {
            try? persistentStorage.saveFactory(factory)
        }
        
        func saveProduction(_ production: SingleItemProduction) {
            try? persistentStorage.saveProduction(production)
        }
        
        // MARK: Deleting
        func deleteFactory(_ factory: Factory) {
            try? persistentStorage.deleteFactory(factory)
        }
        
        func deleteProduction(_ production: SingleItemProduction) {
            try? persistentStorage.deleteProduction(production)
        }
    }
}
