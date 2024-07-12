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
    
    var viewMode = ViewMode.icon
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
            viewMode = settingsService.currentSettings().viewMode
            try storageService.load()
            loadingState = .loaded
        } catch {
            logger.error(error)
            loadingState = .failed(error)
        }
    }
    
    @MainActor
    func observeViewMode() async {
        for await viewMode in settingsService.settings().map(\.viewMode) {
            self.viewMode = viewMode
        }
    }
}
