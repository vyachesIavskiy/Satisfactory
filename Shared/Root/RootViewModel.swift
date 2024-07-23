import SwiftUI
import SHDependencies
import SHStorage
import SHSettings
import SHLogger

@Observable
final class RootViewModel {
    enum LoadingState {
        case loading
        case loaded
        case failed(Error)
    }
    
    var showIngredientNames = false
    var loadingState = LoadingState.loading
    var showErrorDetails = false
    
    private let logger = SHLogger(subsystemName: "Satisfactory", category: "Root")
    
    // Dependencies
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    private var settingsService
    
    @MainActor
    func load() async {
        do {
            showIngredientNames = settingsService.currentSettings().showIngredientNames
            try storageService.load()
            loadingState = .loaded
        } catch {
            logger.error(error)
            loadingState = .failed(error)
        }
    }
    
    @MainActor
    func observeSettings() async {
        for await showIngredientNames in settingsService.settings().map(\.showIngredientNames) {
            self.showIngredientNames = showIngredientNames
        }
    }
}
