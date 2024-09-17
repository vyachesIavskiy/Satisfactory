import SwiftUI
import SHModels
import SHStorage

@Observable
final class EditProductionViewModel {
    // MARK: Observed
    var productionName: String
    var selectedFactoryID: Factory.ID?
    var selectedAssetName: String?
    
    var showingFactoryPicker = false
    var showingDeleteConfirmation = false
    
    // MARK: Ignored
    private let mode: Mode
    private let production: Production
    
    @ObservationIgnored
    private var onSave: ((Production) -> Void)?
    
    @ObservationIgnored
    private var onDelete: (() -> Void)?
    
    var id: UUID {
        production.id
    }
    
    var navigationTitle: LocalizedStringKey {
        switch mode {
        case .new: "edit-production-new-production-navigation-title"
        case .edit: "edit-production-edit-production-navigation-title"
        }
    }
    
    var saveDisabled: Bool {
        productionName.isEmpty || selectedFactoryID == nil || selectedAssetName == nil
    }
    
    var canSelectAsset: Bool {
        production.canSelectAsset
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
    
    var confirmationTitle: LocalizedStringKey {
        switch mode {
        case .new: "general-save"
        case .edit: "general-apply"
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService

    init(_ mode: Mode, production: Production, onSave: ((Production) -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        @Dependency(\.storageService)
        var storageService
        
        self.mode = mode
        self.production = production
        self.onSave = onSave
        self.onDelete = onDelete
        
        switch mode {
        case .new:
            selectedAssetName = production.assetName
            
            switch production.content {
            case let .singleItem(content):
                productionName = content.part.localizedName
                
            case .fromResources:
                productionName = ""
                
            case .power:
                productionName = ""
            }
            
        case .edit:
            productionName = production.name
            selectedFactoryID = storageService.factoryID(for: production)
            selectedAssetName = production.assetName
        }
    }
    
    func saveProduction() {
        guard let selectedFactoryID else { return }
        
        var newProduction = production
        newProduction.name = productionName
        if canSelectAsset, let selectedAssetName {
            newProduction.assetName = selectedAssetName
        }
        
        if mode == .new {
            storageService.saveProduction(newProduction, selectedFactoryID)
        } else {
            storageService.saveProductionInformation(newProduction, selectedFactoryID)
        }
        
        onSave?(newProduction)
    }
    
    func deleteProduction() {
        guard mode == .edit else { return }
        
        storageService.deleteProduction(production)
        onDelete?()
    }
}

extension EditProductionViewModel {
    enum Mode {
        case new
        case edit
    }
}
