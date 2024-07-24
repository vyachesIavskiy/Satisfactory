import Combine
import SHModels
import SHStaticStorage

extension SHStorageService {
    @dynamicMemberLookup
    final class Preview {
        private let staticStorage = SHStaticStorage()
        private let _pins = CurrentValueSubject<Pins, Never>(Pins())
        
        var streamPins: AsyncStream<Pins> {
            _pins.values.eraseToStream()
        }
        
        var pins: Pins {
            _pins.value
        }
        
        init() {
            try? staticStorage.load()
        }
        
        subscript<M>(dynamicMember keyPath: KeyPath<SHStaticStorage, M>) -> M {
            staticStorage[keyPath: keyPath]
        }
        
        func changePartPinStatus(_ partID: String) {
            if _pins.value.partIDs.contains(partID) {
                _pins.value.partIDs.remove(partID)
            } else {
                _pins.value.partIDs.insert(partID)
            }
        }
        
        func changeEquipmentPinStatus(_ equipmentID: String) {
            if _pins.value.equipmentIDs.contains(equipmentID) {
                _pins.value.equipmentIDs.remove(equipmentID)
            } else {
                _pins.value.equipmentIDs.insert(equipmentID)
            }
        }
        
        func changeRecipePinStatus(_ recipeID: String) {
            if _pins.value.recipeIDs.contains(recipeID) {
                _pins.value.recipeIDs.remove(recipeID)
            } else {
                _pins.value.recipeIDs.insert(recipeID)
            }
        }
    }
}
