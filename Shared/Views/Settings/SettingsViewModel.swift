import Observation
import SHStorage
import SHSettings
import SHModels

@Observable
final class SettingsViewModel {
    enum FeedbackState {
        case sending
        case sent
    }
    
    let recipe: Recipe
    var showFeedback = false
    #if canImport(UIKit)
    var feedbackResult: FeedbackView.Result?
    #endif
    
    var settings: Settings {
        didSet {
            settingsService.settings = settings
        }
    }
    
    // Dependencies
    @ObservationIgnored
    @Dependency(\.settingsService)
    private var settingsService
    
    init() {
        @Dependency(\.settingsService)
        var settingsService
        
        @Dependency(\.storageService)
        var storageService
        
        recipe = storageService.recipe(id: "recipe-alternate-instant-scrap")!
        settings = settingsService.settings
    }
}
