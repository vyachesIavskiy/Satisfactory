import Combine
import SHModels
import SHStaticStorage

extension SHStorageService {
    @dynamicMemberLookup
    final class Preview {
        private let staticStorage = SHStaticStorage()
        private let _pins = CurrentValueSubject<Pins, Never>(Pins())
        private let _productions = CurrentValueSubject<[SingleItemProduction], Never>([])
        private let _factories = CurrentValueSubject<[Factory], Never>([])
        
        var pins: Pins {
            _pins.value
        }
        
        var streamPins: AsyncStream<Pins> {
            _pins.values.eraseToStream()
        }
        
        var factories: [Factory] {
            _factories.value
        }
        
        var streamFactories: AsyncStream<[Factory]> {
            _factories.values.eraseToStream()
        }
        
        var productions: [SingleItemProduction] {
            _productions.value
        }
        
        var streamProductions: AsyncStream<[SingleItemProduction]> {
            _productions.values.eraseToStream()
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
        
        func saveFactory(_ factory: Factory) {
            if let index = _factories.value.firstIndex(id: factory.id) {
                _factories.value[index] = factory
            } else {
                _factories.value.append(factory)
            }
        }
        
        func saveProduction(_ production: SingleItemProduction) {
            if let index = _productions.value.firstIndex(id: production.id) {
                _productions.value[index] = production
            } else {
                _productions.value.append(production)
            }
        }
        
        func deleteFactory(_ factory: Factory) {
            if let index = _factories.value.firstIndex(id: factory.id) {
                _factories.value.remove(at: index)
            }
        }
        
        func deleteProduction(_ production: SingleItemProduction) {
            if let index = _productions.value.firstIndex(id: production.id) {
                _productions.value.remove(at: index)
            }
        }
    }
}
