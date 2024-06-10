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
    
    var loadingState = LoadingState.loading
    var showErrorDetails = false
    private let logger = SHLogger(subsystemName: "Satisfactory", category: "Root")
    
    // Dependencies
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
    
    @MainActor
    func load() async {
        do {
            try storageService.load()
            loadingState = .loaded
        } catch {
            logger.error(error)
            loadingState = .failed(error)
        }
    }
}
