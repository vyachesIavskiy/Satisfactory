import Foundation
import Observation
import SHModels
import SHStorage

@Observable
final class EditProductionViewModel {
    // MARK: Observed properties
    var productionName: String
    var selectedFactoryID: Factory.ID?
    var selectedAssetName: String?
    var navigationPath = [NavigationPath]()
    
    var showingDeleteConfirmation = false
    
    var id: UUID {
        switch mode {
        case let .new(production), let .edit(production, _, _): production.id
        }
    }
    
    var saveDisabled: Bool {
        productionName.isEmpty || selectedFactoryID == nil || selectedAssetName == nil
    }
    
    var canSelectAsset: Bool {
        switch mode {
        case let .new(production), let .edit(production, _, _): production.canSelectAsset
        }
    }
    
    var canDeleteProduction: Bool {
        switch mode {
        case .new: false
        case .edit: true
        }
    }
    
    var selectedFactory: Factory? {
        selectedFactoryID.flatMap(storageService.factory(id:))
    }
    
    // MARK: Ignored properties
    let mode: Mode
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    convenience init(newProduction: Production) {
        self.init(mode: .new(newProduction))
    }
    
    convenience init(
        editProduction: Production,
        onSave: ((Production) -> Void)? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self.init(mode: .edit(editProduction, onSave: onSave, onDelete: onDelete))
    }
    
    private init(mode: Mode) {
        @Dependency(\.storageService)
        var storageService
        
        self.mode = mode
        
        switch mode {
        case let .new(production):
            selectedAssetName = production.assetName
            
            switch production {
            case let .singleItem(production):
                productionName = production.item.localizedName
                
            case let .fromResources(production):
                productionName = ""
                
            case let .power(production):
                productionName = ""
            }
            
        case let .edit(production, _, _):
            productionName = production.name
            selectedFactoryID = storageService.factoryID(for: production)
            selectedAssetName = production.assetName
        }
    }
    
    func saveProduction() {
        guard let selectedFactoryID else { return }
        
        var newProduction = switch mode {
        case let .new(production): production
        case let .edit(production, _, _): production
        }
        newProduction.name = productionName
        
        storageService.saveProduction(newProduction, selectedFactoryID)
    }
    
    func deleteProduction() {
        guard case let .edit(production, _, onDelete) = mode
        else { return }
        
        storageService.deleteProduction(production)
        onDelete?()
    }
}

extension EditProductionViewModel {
    enum Mode {
        case new(Production)
        case edit(Production, onSave: ((Production) -> Void)?, onDelete: (() -> Void)?)
    }
}

extension EditProductionViewModel {
    enum NavigationPath {
        case selectFactory
    }
}
