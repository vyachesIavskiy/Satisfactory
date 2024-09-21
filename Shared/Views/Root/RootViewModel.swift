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
        do {
            showIngredientNames = settingsService.showIngredientNames
            try storageService.load()
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
