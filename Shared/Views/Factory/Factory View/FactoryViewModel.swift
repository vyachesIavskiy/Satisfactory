import Foundation
import SHModels
import SHStorage

@Observable
final class FactoryViewModel {
    // MARK: Ignored properties
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
    
    // MARK: Observed properties
    var section = Section()
    var productionToEdit: Production?
    
    var showingStatisticsSheet = false
    var showingEditFactorySheet = false
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @MainActor
    init(factory: Factory) {
        @Dependency(\.storageService)
        var storageService
        
        self.factory = factory
        productions = storageService.produtions(inside: factory)
        
        buildSection()
    }
    
    @MainActor
    func observeProductions() async {
        for await productions in storageService.streamProductions(inside: factory) {
            guard !Task.isCancelled else { break }
            
            self.productions = productions
            buildSection()
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
