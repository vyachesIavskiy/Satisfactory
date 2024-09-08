import Foundation
import Observation
import SHModels
import SHStorage

@Observable
final class FactoryPickerViewModel {
    // MARK: Observed
    var factories = [Factory]()
    var selectedFactoryID: UUID?
    var showingNewFactoryModal = false
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    init(selectedFactoryID: UUID?) {
        @Dependency(\.storageService)
        var storageService
        
        self.factories = storageService.factories()
        self.selectedFactoryID = selectedFactoryID
    }
    
    @MainActor
    func observeFactories() async {
        for await factories in storageService.streamFactories() {
            defer {
                self.factories = factories
            }
            
            guard showingNewFactoryModal else { continue }
            
            if self.factories.isEmpty, let newFactory = factories.last {
                selectedFactoryID = newFactory.id
            } else if let newFactory = factories.first(where: { factory in
                self.factories.contains { $0.id != factory.id }
            }) {
                selectedFactoryID = newFactory.id
            }
        }
    }
    
    func createNewFactory() {
        showingNewFactoryModal = true
    }
    
    func selectNewlyAddedFactory() {
        
    }
}
