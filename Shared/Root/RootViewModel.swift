import SwiftUI
import SHDependencies
import SHModels
import SHPersistentModels
import SHStorage
import SHPersistentStorage
import SHSettings
import SHLogger

@Observable
final class RootViewModel {
    enum LoadingState {
        case loading
        case loaded
        case failed(Error)
    }
    
    // MARK: Ignored properties
    @ObservationIgnored
    private let logger = SHLogger(subsystemName: "Satisfactory", category: "Root")
    
    // MARK: Observed properties
    var showIngredientNames: Bool
    var loadingState: LoadingState
    var showErrorDetails: Bool
    
    // MARK: Dependencies
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    private var settingsService
    
    init(showIngredientNames: Bool = false, loadingState: LoadingState = LoadingState.loading, showErrorDetails: Bool = false) {
        self.showIngredientNames = showIngredientNames
        self.loadingState = loadingState
        self.showErrorDetails = showErrorDetails
    }
    
    @MainActor
    func load() async {
        let ironIngot1 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "iron-ingot",
            recipeID: "iron-ingot",
            children: []
        )
        
        let ironIngot2 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "iron-ingot",
            recipeID: "iron-ingot",
            children: []
        )
        
        let ironIngot3 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "iron-ingot",
            recipeID: "iron-ingot",
            children: []
        )
        
        let ironIngot4 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "iron-ingot",
            recipeID: "iron-ingot",
            children: []
        )
        
        let ironIngot5 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "iron-ingot",
            recipeID: "iron-ingot",
            children: []
        )
        
        let steelIngot1 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "steel-ingot",
            recipeID: "alternate-solid-steel-ingot",
            children: [
                ironIngot1.id
            ]
        )
        
        let steelIngot2 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "steel-ingot",
            recipeID: "alternate-solid-steel-ingot",
            children: [
                ironIngot2.id
            ]
        )
        
        let ironPlate = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "iron-plate",
            recipeID: "iron-plate",
            children: [
                ironIngot3.id
            ]
        )
        
        let screw = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "screw",
            recipeID: "alternate-cast screw",
            children: [
                ironIngot4.id
            ]
        )
        
        let reinforcedIronPlate = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "reinforced-iron-plate",
            recipeID: "reinforced-iron-plate",
            children: [
                ironPlate.id,
                screw.id
            ]
        )
        
        let ironRod = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "iron-rod",
            recipeID: "iron-rod",
            children: [
                ironIngot5.id
            ]
        )
        
        let steelPipe2 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "steel-pipe",
            recipeID: "steel-pipe",
            children: [
                steelIngot2.id
            ]
        )
        
        let concrete2 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "concrete",
            recipeID: "concrete",
            children: []
        )
        
        let modularFrame = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "modular-frame",
            recipeID: "modular-frame",
            children: [
                reinforcedIronPlate.id,
                ironRod.id
            ]
        )
        
        let eib = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "encased-industrial-beam",
            recipeID: "alternate-encased-industrial-pipe",
            children: [
                steelPipe2.id,
                concrete2.id
            ]
        )
        
        let steelPipe1 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "steel-pipe",
            recipeID: "steel-pipe",
            children: [
                steelIngot1.id
            ]
        )
        
        let concrete1 = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "concrete",
            recipeID: "concrete",
            children: []
        )
        
        let hmf = SingleItemProduction.Persistent.Legacy.Chain(
            id: UUID(),
            itemID: "heavy-modular-frame",
            recipeID: "alternate-heavy-encased-frame",
            children: [
                modularFrame.id,
                eib.id,
                steelPipe1.id,
                concrete1.id
            ]
        )
        
        let chain = [
            hmf,
            modularFrame,
            eib,
            steelPipe1,
            concrete1,
            reinforcedIronPlate,
            ironRod,
            steelPipe2,
            concrete2,
            ironPlate,
            screw,
            steelIngot1,
            steelIngot2,
            ironIngot1,
            ironIngot2,
            ironIngot3,
            ironIngot4,
            ironIngot5
        ]
        
        let production = SingleItemProduction.Persistent.Legacy(
            productionTreeRootID: hmf.id,
            amount: 12,
            productionChain: chain
        )
        
        do {
            showIngredientNames = settingsService.showIngredientNames
//            try storageService.load(LoadOptions(v1: LoadOptions.V1(
//                pinnedPartIDs: ["heavy-modular-frame"],
//                savedProductions: [production]
//            )))
            try storageService.load(LoadOptions())
            loadingState = .loaded
        } catch {
            logger.error(error)
            loadingState = .failed(error)
        }
    }
    
    @MainActor
    func observeSettings() async {
        for await showIngredientNames in settingsService.streamSettings().map(\.showIngredientNames) {
            guard !Task.isCancelled else { break }
            guard self.showIngredientNames != showIngredientNames else { continue }
            
            self.showIngredientNames = showIngredientNames
        }
    }
}
