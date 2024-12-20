import Foundation
import SHModels
import SHStorage

@Observable
final class FactoryViewModel {
    // MARK: Observed
    var section = Section()
    var productionToEdit: Production?
    var selectedProduction: Production?    
    
    var showingStatisticsSheet = false
    var showingEditFactorySheet = false
    var dismissAfterFactoryDeletion = false
    
    // MARK: Ignored
    @ObservationIgnored
    var factory: Factory
    
    @MainActor @ObservationIgnored
    private var productions: [Production]
    
    @MainActor @ObservationIgnored
    var searchText = "" {
        didSet {
            buildSection()
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @MainActor
    init(factory: Factory) {
        @Dependency(\.storageService)
        var storageService
        
        self.factory = factory
        productions = storageService.productionsInside(factory)
        
        buildSection()
    }
    
    @MainActor
    func observeProductions() async {
        for await productions in storageService.streamProductionsInside(factory) {
            guard !Task.isCancelled else { break }
            
            self.productions = productions
            buildSection()
        }
    }
    
    func deleteProduction(_ production: Production) {
        storageService.deleteProduction(production)
    }
    
    func move(fromOffsets: IndexSet, toOffset: Int) {
        storageService.moveProductions(factory, fromOffsets, toOffset)
    }
    
    func statisticsViewModel() -> StatisticsViewModel {
        StatisticsViewModel(factory: factory)
    }
    
    func editFactoryViewModel() -> EditFactoryViewModel {
        EditFactoryViewModel(.edit(factory)) { [weak self] newFactory in
            self?.factory = newFactory
        } onDelete: { [weak self] in
            self?.dismissAfterFactoryDeletion = true
        }
    }
}

// MARK: Private
private extension FactoryViewModel {
    @MainActor
    func buildSection() {
        if searchText.isEmpty {
            section.productions = productions
        } else {
            section.productions = productions.filter {
                $0.name.localizedCaseInsensitiveContains(searchText)
            }
        }
    }
}

extension FactoryViewModel {
    struct Section {
        var productions = [Production]()
    }
}
