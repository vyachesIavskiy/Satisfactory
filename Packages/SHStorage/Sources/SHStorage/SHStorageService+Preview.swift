import Foundation
import Combine
import SHModels
import SHStaticStorage
import SHPersistentModels

extension SHStorageService {
    @dynamicMemberLookup
    final class Preview {
        private let staticStorage = SHStaticStorage()
        private let _pins = CurrentValueSubject<Pins, Never>(Pins())
        private let _productions = CurrentValueSubject<[Production], Never>([])
        private let _factories = CurrentValueSubject<[Factory], Never>([])
        private let _orders = CurrentValueSubject<OrdersV2, Never>(OrdersV2())
        
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
        
        func productions(inside factory: Factory) -> [Production] {
            _orders.value.productionOrders
                .first(factoryID: factory.id)
                .map { productionOrder in
                    productionOrder.order.compactMap {
                        _productions.value.first(id: $0)
                    }
                } ?? []
        }
        
        func streamProductions(inside factory: Factory) -> AsyncStream<[Production]> {
            _orders.map { [weak self] orders in
                guard let self else { return [] }
                
                return orders.productionOrders
                    .first(factoryID: factory.id)
                    .map { productionOrder in
                        productionOrder.order.compactMap {
                            self._productions.value.first(id: $0)
                        }
                    } ?? []
            }
            .values
            .eraseToStream()
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
            
            _orders.value.factoryOrder = _factories.value.map(\.id)
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
            
            let factoryProductionIDs = _factories.value
                .first { $0.id == factoryID }
                .map { factory in
                    _productions.value.filter { factory.productionIDs.contains($0.id) }.map(\.id)
                } ?? []
            
            if let index = _orders.value.productionOrders.firstIndex(factoryID: factoryID) {
                _orders.value.productionOrders[index].order = factoryProductionIDs
            } else {
                _orders.value.productionOrders.append(OrdersV2.ProductionOrder(factoryID: factoryID, order: factoryProductionIDs))
            }
        }
        
        func saveProductionInformation(_ production: Production, to factoryID: UUID) {
            guard let index = _productions.value.firstIndex(id: production.id) else { return }
            
            _productions.value[index].name = production.name
            _productions.value[index].assetName = production.assetName

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
            
            let factoryProductionIDs = _factories.value
                .first { $0.id == factoryID }
                .map { factory in
                    _productions.value.filter { factory.productionIDs.contains($0.id) }.map(\.id)
                } ?? []
            
            if let index = _orders.value.productionOrders.firstIndex(factoryID: factoryID) {
                _orders.value.productionOrders[index].order = factoryProductionIDs
            } else {
                _orders.value.productionOrders.append(OrdersV2.ProductionOrder(factoryID: factoryID, order: factoryProductionIDs))
            }
        }
        
        func saveProductionContent(_ production: Production) {
            guard let index = _productions.value.firstIndex(id: production.id) else { return }
            
            _productions.value[index].content = production.content
        }
        
        func deleteFactory(_ factory: Factory) {
            if let index = _factories.value.firstIndex(id: factory.id) {
                _factories.value.remove(at: index)
            }
            
            _orders.value.factoryOrder = _factories.value.map(\.id)
        }
        
        func deleteProduction(_ production: Production) {
            if let index = _productions.value.firstIndex(id: production.id) {
                _productions.value.remove(at: index)
            }
            
            guard let index = _factories.value.firstIndex(where: { $0.productionIDs.contains(production.id) })
            else { return }
            
            let factoryProductionIDs = _productions.value.filter {
                _factories.value[index].productionIDs.contains($0.id)
            }.map(\.id)
            
            let factoryID = _factories.value[index].id
            if let index = _orders.value.productionOrders.firstIndex(factoryID: factoryID) {
                _orders.value.productionOrders[index].order = factoryProductionIDs
            } else {
                _orders.value.productionOrders.append(OrdersV2.ProductionOrder(factoryID: factoryID, order: factoryProductionIDs))
            }
        }
        
        func moveFactories(fromOffsets: IndexSet, toOffset: Int) {
            _factories.value.move(fromOffsets: fromOffsets, toOffset: toOffset)
        }
        
        func moveProductions(factory: Factory, fromOffsets: IndexSet, toOffset: Int) {
            let factoryProductions = _productions.value.filter { factory.productionIDs.contains($0.id) }
            
            guard let index = _orders.value.productionOrders.firstIndex(factoryID: factory.id) else { return }
            
            _orders.value.productionOrders[index].order.move(fromOffsets: fromOffsets, toOffset: toOffset)
        }
    }
}
