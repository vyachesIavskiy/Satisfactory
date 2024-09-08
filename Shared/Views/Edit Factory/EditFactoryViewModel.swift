import SwiftUI
import SHStorage
import SHModels

@Observable
public final class EditFactoryViewModel {
    // MARK: Observed properties
    var factoryName: String
    var provideAssetImage: Bool {
        didSet {
            selectedAssetName = nil
        }
    }
    var selectedAssetName: String?
    var showingDeleteConfirmation = false
    
    var saveDisabled: Bool {
        factoryName.isEmpty
    }
    
    var canDeleteFactory: Bool {
        switch mode {
        case .new: false
        case .edit: true
        }
    }
    
    var navigationTitle: LocalizedStringKey {
        switch mode {
        case .new: "edit-factory-new-factory-navigation-title"
        case .edit: "edit-factory-edit-factory-navigation-title"
        }
    }
    
    private let mode: Mode
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored @Dependency(\.uuid)
    private var uuid
    
    @ObservationIgnored @Dependency(\.date)
    private var date
    
    public convenience init() {
        self.init(mode: .new)
    }
    
    public convenience init(
        factory: Factory,
        onSave: ((Factory) -> Void)? = nil,
        onDelete: (() -> Void)? = nil
    ) {
        self.init(mode: .edit(factory, onSave: onSave, onDelete: onDelete))
    }
    
    private init(mode: Mode) {
        self.mode = mode
        
        switch mode {
        case .new:
            factoryName = ""
            provideAssetImage = false
            
        case let .edit(factory, _, _):
            factoryName = factory.name
            switch factory.asset {
            case .abbreviation, .legacy:
                provideAssetImage = false
                
            case let .assetCatalog(name: assetName):
                provideAssetImage = true
                selectedAssetName = assetName
            }
        }
    }
    
    func saveFactory() {
        let asset: Asset = if provideAssetImage, let selectedAssetName {
            .assetCatalog(name: selectedAssetName)
        } else {
            .abbreviation
        }
        
        switch mode {
        case .new:
            let factory = Factory(
                id: uuid(),
                name: factoryName,
                creationDate: date(),
                asset: asset,
                productionIDs: []
            )
            
            storageService.saveFactory(factory)
            
        case let .edit(factory, onSave, _):
            var copy = factory
            copy.name = factoryName
            copy.asset = asset
            
            storageService.saveFactory(copy)
            
            onSave?(copy)
        }
    }
    
    func deleteFactory() {
        guard case let .edit(factory, _, onDelete) = mode else { return }
        
        storageService.deleteFactory(factory)
        onDelete?()
    }
}

extension EditFactoryViewModel {
    enum Mode {
        case new
        case edit(Factory, onSave: ((Factory) -> Void)?, onDelete: (() -> Void)?)
    }
}

extension EditFactoryViewModel {
    enum AssetType {
        case assetCatalog
        case abbreviation
    }
}
