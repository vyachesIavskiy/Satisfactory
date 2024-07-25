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
    
    var showIngredientNames: Bool
    var loadingState: LoadingState
    var showErrorDetails: Bool
    
    private let logger = SHLogger(subsystemName: "Satisfactory", category: "Root")
    
    // Dependencies
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
        
        Task { @MainActor [weak self] in
            guard let self else { return }
            
            for await showIngredientNames in settingsService.streamSettings().map(\.showIngredientNames) {
                guard !Task.isCancelled else { break }
                guard self.showIngredientNames != showIngredientNames else { continue }
                
                self.showIngredientNames = showIngredientNames
            }
        }
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
}
