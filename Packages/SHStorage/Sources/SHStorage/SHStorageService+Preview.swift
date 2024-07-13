import Combine
import SHModels
import SHStaticStorage

extension SHStorageService {
    @dynamicMemberLookup
    final class Preview {
        private let staticStorage = SHStaticStorage()
        private let pins = CurrentValueSubject<Pins, Never>(Pins())
        
        var streamPinnedPartIDs: AsyncStream<Set<String>> {
            pins.map(\.partIDs).values.eraseToStream()
        }
        
        var streamPinnedEquipmentIDs: AsyncStream<Set<String>> {
            pins.map(\.equipmentIDs).values.eraseToStream()
        }
        
        var streamPinnedRecipeIDs: AsyncStream<Set<String>> {
            pins.map(\.recipeIDs).values.eraseToStream()
        }
        
        var pinnedPartIDs: Set<String> {
            pins.value.partIDs
        }
        
        var pinnedEquipmentIDs: Set<String> {
            pins.value.equipmentIDs
        }
        
        var pinnedRecipeIDs: Set<String> {
            pins.value.recipeIDs
        }
        
        init() {
            try? staticStorage.load()
        }
        
        subscript<M>(dynamicMember keyPath: KeyPath<SHStaticStorage, M>) -> M {
            staticStorage[keyPath: keyPath]
        }
        
        func isPartPinned(_ partID: String) -> Bool {
            pins.value.partIDs.contains(partID)
        }
        
        func isEquipmentPinned(_ equipmentID: String) -> Bool {
            pins.value.equipmentIDs.contains(equipmentID)
        }
        
        func isRecipePinned(_ recipeID: String) -> Bool {
            pins.value.recipeIDs.contains(recipeID)
        }
        
        func changePartPinStatus(_ partID: String) {
            if isPartPinned(partID) {
                pins.value.partIDs.remove(partID)
            } else {
                pins.value.partIDs.insert(partID)
            }
        }
        
        func changeEquipmentPinStatus(_ equipmentID: String) {
            if isEquipmentPinned(equipmentID) {
                pins.value.equipmentIDs.remove(equipmentID)
            } else {
                pins.value.equipmentIDs.insert(equipmentID)
            }
        }
        
        func changeRecipePinStatus(_ recipeID: String) {
            if isRecipePinned(recipeID) {
                pins.value.recipeIDs.remove(recipeID)
            } else {
                pins.value.recipeIDs.insert(recipeID)
            }
        }
    }
}
