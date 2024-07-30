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
        
        init() {
            persistentStorage = SHPersistentStorage(staticStorage: staticStorage)
        }
        
        // MARK: Dynamic members
        subscript<M>(dynamicMember keyPath: KeyPath<SHStaticStorage, M>) -> M {
            staticStorage[keyPath: keyPath]
        }
        
        // MARK: Loading
        func load() throws {
            try staticStorage.load()
            try persistentStorage.load()
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
    }
}
