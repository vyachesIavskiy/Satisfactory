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
    var feedbackResult: FeedbackView.Result?
    
    var settings: Settings {
        didSet {
            settingsService.setSettings(settings)
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
        
        recipe = storageService.recipe(for: "recipe-alternate-instant-scrap")!
        settings = settingsService.currentSettings()
    }
}
