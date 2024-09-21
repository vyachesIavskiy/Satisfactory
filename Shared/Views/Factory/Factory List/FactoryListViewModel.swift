import Foundation
import Observation
import SHModels
import SHStorage

@Observable
final class FactoryListViewModel {
    // MARK: Observed
    var factoriesSection = FactoriesSection()
    var productionsSection = ProductionsSection()
    
    var selectedFactory: Factory?
    var selectedProduction: Production?
    
    var factoryToEdit: Factory?
    var productionToEdit: Production?
    
    var factoryToDelete: Factory?
    var productionToDelete: Production?
    
    var showingNewFactoryModal = false
    var showingDeleteFactoryConfirmation = false
    var showingDeleteProductionConfirmation = false
    
    // MARK: Ignored
    @ObservationIgnored
    private var factories = [Factory]()
    
    @ObservationIgnored
    private var productions = [Production]()
    
    @MainActor @ObservationIgnored
    var searchText = "" {
        didSet {
            buildFactoriesSection()
            buildProductionsSection()
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @MainActor
    init() {
        @Dependency(\.storageService)
        var storageService
        
        factories = storageService.factories()
        buildFactoriesSection()
    }
    
    @MainActor
    func observeStorage() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { [weak self] in
                guard let self else { return }
                
                for await factories in storageService.streamFactories() {
                    guard !Task.isCancelled else { break }
                    guard self.factories != factories else { continue }
                    
                    self.factories = factories
                    await buildFactoriesSection()
                }
            }
            
            group.addTask { [weak self] in
                guard let self else { return }
                
                for await productions in storageService.streamProductions() {
                    guard !Task.isCancelled else { break }
                    guard self.productions != productions else { continue }
                    
                    self.productions = productions
                    await buildProductionsSection()
                }
            }
        }
    }
    
    func factory(id factoryID: UUID) -> Factory? {
        storageService.factory(id: factoryID)
    }
    
    func production(id productionID: UUID) -> Production? {
        storageService.production(id: productionID)
    }
    
    func promptToDeleteFactory(_ factory: Factory) {
        factoryToDelete = factory
        showingDeleteFactoryConfirmation = true
    }
    
    func promptToDeleteProduction(_ production: Production) {
        productionToDelete = production
        showingDeleteProductionConfirmation = true
    }
    
    func deleteFactory(_ factory: Factory) {
        storageService.deleteFactory(factory)
    }
    
    func deleteProduction(_ production: Production) {
        storageService.deleteProduction(production)
    }
    
    func move(fromOffsets: IndexSet, toOffset: Int) {
        storageService.moveFactories(fromOffsets, toOffset)
    }
}

// MARK: Private
private extension FactoryListViewModel {
    @MainActor
    func buildFactoriesSection() {
        if searchText.isEmpty {
            factoriesSection.factories = factories
        } else {
            factoriesSection.factories = factories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
    
    @MainActor
    func buildProductionsSection() {
        if searchText.isEmpty {
            productionsSection.productions = []
        } else {
            productionsSection.productions = productions.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

extension FactoryListViewModel {
    struct FactoriesSection: Identifiable {
        let id = "factories-view-factories-section"
        var factories = [Factory]()
        var expanded = true
    }
    
    struct ProductionsSection: Identifiable {
        let id = "factories-view-productions-section"
        var productions = [Production]()
        var expanded = true
    }
}
