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
            self.factories = factories
        }
    }
    
    func createNewFactory() {
        showingNewFactoryModal = true
    }
    
    func createFactoryViewModel() -> EditFactoryViewModel {
        EditFactoryViewModel(.new) { [weak self] newFactory in
            self?.selectedFactoryID = newFactory.id
        }
    }
}
