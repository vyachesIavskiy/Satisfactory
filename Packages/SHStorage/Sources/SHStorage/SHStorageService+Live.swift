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
        
        var streamPinnedPartIDs: AsyncStream<Set<String>> {
            persistentStorage.pins
                .removeDuplicates()
                .map(\.partIDs)
                .values
                .eraseToStream()
        }
        
        var streamPinnedEquipmentIDs: AsyncStream<Set<String>> {
            persistentStorage.pins
                .removeDuplicates()
                .map(\.equipmentIDs)
                .values
                .eraseToStream()
        }
        
        var streamPinnedRecipeIDs: AsyncStream<Set<String>> {
            persistentStorage.pins
                .removeDuplicates()
                .map(\.recipeIDs)
                .values
                .eraseToStream()
        }
        
        var pinnedPartIDs: Set<String> {
            persistentStorage.pins.value.partIDs
        }
        
        var pinnedEquipmentIDs: Set<String> {
            persistentStorage.pins.value.equipmentIDs
        }
        
        var pinnedRecipeIDs: Set<String> {
            persistentStorage.pins.value.recipeIDs
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
        
        // MARK: IsPinned
        func isPartPinned(_ partID: String) -> Bool {
            persistentStorage.isPartPinned(partID)
        }
        
        func isEquipmentPinned(_ equipmentID: String) -> Bool {
            persistentStorage.isEquipmentPinned(equipmentID)
        }
        
        func isRecipePinned(_ recipeID: String) -> Bool {
            persistentStorage.isRecipePinned(recipeID)
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
