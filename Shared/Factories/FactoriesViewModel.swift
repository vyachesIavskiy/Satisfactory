import Observation
import SHModels
import SHStorage

@Observable
final class FactoriesViewModel {
    // MARK: Ignored properties
    @ObservationIgnored
    private var factories: [Factory]
    
    @ObservationIgnored
    private var productions: [SingleItemProduction]
    
    @MainActor @ObservationIgnored
    var searchText = "" {
        didSet {
            buildSections()
        }
    }
    
    // MARK: Observed properties
    var factoriesSection = FactoriesSection()
    var productionsSection = ProductionsSection()
    var selectedFactory: Factory?
    var factoryToDelete: Factory?
    
    var factoriesSectionExpanded = true
    var productionsSectionExpanded = true
    
    var showingDeleteFactoryAlert = false
    var showingNewFactoryModal = false
    
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
    
    func showDeleteFactoryAlert() {
        
    }
    
    func deleteFactory(_ factory: Factory) {
        storageService.deleteFactory(factory)
    }
}

// MARK: Private
private extension FactoriesViewModel {
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
    }
}

extension FactoriesViewModel {
    struct FactoriesSection: Identifiable {
        let id = "factories-view-factories-section"
        var factories = [Factory]()
    }
    
    struct ProductionsSection: Identifiable {
        let id = "factories-view-productions-section"
        var productions = [SingleItemProduction]()
    }
}
