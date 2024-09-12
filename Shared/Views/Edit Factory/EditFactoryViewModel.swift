import SwiftUI
import SHStorage
import SHModels

@Observable
final class EditFactoryViewModel {
    // MARK: Observed
    var factoryName: String
    var provideAssetImage: Bool {
        didSet {
            selectedAssetName = nil
        }
    }
    var selectedAssetName: String?
    var showingDeleteConfirmation = false
    
    // MARK: Ignored
    private let mode: Mode
    
    @ObservationIgnored
    private var onSave: ((Factory) -> Void)?
    
    @ObservationIgnored
    private var onDelete: (() -> Void)?
    
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
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored @Dependency(\.uuid)
    private var uuid
    
    @ObservationIgnored @Dependency(\.date)
    private var date
    
    init(_ mode: Mode, onSave: ((Factory) -> Void)? = nil, onDelete: (() -> Void)? = nil) {
        self.mode = mode
        self.onSave = onSave
        self.onDelete = onDelete
        
        switch mode {
        case .new:
            factoryName = ""
            provideAssetImage = false
            
        case let .edit(factory):
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
        
        var newFactory: Factory
        switch mode {
        case .new:
            newFactory = Factory(
                id: uuid(),
                name: factoryName,
                creationDate: date(),
                asset: asset,
                productionIDs: []
            )
        case let .edit(factory):
            newFactory = factory
            newFactory.name = factoryName
            newFactory.asset = asset
        }
        
        storageService.saveFactory(newFactory)
        
        onSave?(newFactory)
    }
    
    func deleteFactory() {
        guard case let .edit(factory) = mode else { return }
        
        storageService.deleteFactory(factory)
        onDelete?()
    }
}

extension EditFactoryViewModel {
    enum Mode {
        case new
        case edit(Factory)
    }
}

extension EditFactoryViewModel {
    enum AssetType {
        case assetCatalog
        case abbreviation
    }
}
