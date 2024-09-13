import Foundation
import Combine
import SHModels
import SHStaticStorage

extension SHStorageService {
    @dynamicMemberLookup
    final class Preview {
        private let staticStorage = SHStaticStorage()
        private let _pins = CurrentValueSubject<Pins, Never>(Pins())
        private let _productions = CurrentValueSubject<[Production], Never>([])
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
        
        var productions: [Production] {
            _productions.value
        }
        
        var streamProductions: AsyncStream<[Production]> {
            _productions.values.eraseToStream()
        }
        
        init() {
            try? staticStorage.load()
        }
        
        subscript<M>(dynamicMember keyPath: KeyPath<SHStaticStorage, M>) -> M {
            staticStorage[keyPath: keyPath]
        }
        
        func changePinStatus(partID: String, productionType: ProductionType) {
            switch productionType {
            case .singleItem:
                if _pins.value.singleItemPartIDs.contains(partID) {
                    _pins.value.singleItemPartIDs.remove(partID)
                } else {
                    _pins.value.singleItemPartIDs.insert(partID)
                }
            case .fromResources:
                if _pins.value.fromResourcesPartIDs.contains(partID) {
                    _pins.value.fromResourcesPartIDs.remove(partID)
                } else {
                    _pins.value.fromResourcesPartIDs.insert(partID)
                }
            case .power:
                if _pins.value.power.partIDs.contains(partID) {
                    _pins.value.power.partIDs.remove(partID)
                } else {
                    _pins.value.power.partIDs.insert(partID)
                }
            }
        }
        
        func changePinStatus(buildingID: String, productionType: ProductionType) {
            switch productionType {
            case .singleItem:
                break
            case .fromResources:
                break
            case .power:
                if _pins.value.power.buildingIDs.contains(buildingID) {
                    _pins.value.power.buildingIDs.remove(buildingID)
                } else {
                    _pins.value.power.buildingIDs.insert(buildingID)
                }
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
        
        func saveProduction(_ production: Production, to factoryID: UUID) {
            if let index = _productions.value.firstIndex(id: production.id) {
                _productions.value[index] = production
            } else {
                _productions.value.append(production)
            }
            
            if
                let index = _factories.value.firstIndex(where: { $0.id == factoryID }),
                !_factories.value[index].productionIDs.contains(factoryID)
            {
                _factories.value[index].productionIDs.append(production.id)
            } else if
                let index = _factories.value.firstIndex(where: { $0.productionIDs.contains(production.id) })
            {
                _factories.value[index].productionIDs.removeAll { $0 == production.id }
            }
        }
        
        func deleteFactory(_ factory: Factory) {
            if let index = _factories.value.firstIndex(id: factory.id) {
                _factories.value.remove(at: index)
            }
        }
        
        func deleteProduction(_ production: Production) {
            if let index = _productions.value.firstIndex(id: production.id) {
                _productions.value.remove(at: index)
            }
        }
    }
}
