import Foundation
import Observation
import SHModels
import SHStorage

@Observable
final class FactoryListViewModel {
    // MARK: Ignored properties
    @ObservationIgnored
    private var factories: [Factory]
    
    @ObservationIgnored
    private var productions: [Production]
    
    @MainActor @ObservationIgnored
    var searchText = "" {
        didSet {
            buildSections()
        }
    }
    
    // MARK: Observed properties
    var factoriesSection = FactoriesSection()
    var productionsSection = ProductionsSection()
    
    var factoryToEdit: Factory?
    var productionToEdit: Production?
    
    var showingNewFactoryModal = false
    
    var navigationPath = [UUID]() // Factories ID
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @MainActor
    init() {
        @Dependency(\.storageService)
        var storageService
        
        self.factories = storageService.factories()
        self.productions = storageService.productions()
        
        buildSections()
    }
    
    @MainActor
    func observeStorage() async {
        await withTaskGroup(of: Void.self) { group in
            group.addTask { [weak self] in
                guard let self else { return }
                
                for await factories in storageService.streamFactories() {
                    guard !Task.isCancelled else { break }
                    
                    self.factories = factories
                    await buildSections()
                }
            }
            
            group.addTask { [weak self] in
                guard let self else { return }
                
                for await productions in storageService.streamProductions() {
                    guard !Task.isCancelled else { break }
                    
                    self.productions = productions
                    await buildSections()
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
    
    func deleteFactory(_ factory: Factory) {
        storageService.deleteFactory(factory)
    }
    
    func deleteProduction(_ production: Production) {
        storageService.deleteProduction(production)
    }
}

// MARK: Private
private extension FactoryListViewModel {
    @MainActor
    func buildSections() {
        if searchText.isEmpty {
            factoriesSection.factories = factories
            productionsSection.productions = []
        } else {
            factoriesSection.factories = factories.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
            productionsSection.productions = productions.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
        
        factoriesSection.factories.sort(using: KeyPathComparator(\.name))
        productionsSection.productions.sort(using: KeyPathComparator(\.name))
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
