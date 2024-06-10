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
    
    let recipe: SHModels.Recipe
    
    var settings: SHSettings.Settings {
        didSet {
            settingsService.setSettings(settings)
        }
    }
    
    var showFeedback = false
    var feedbackResult: FeedbackView.Result?
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    private var settingsService
    
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        recipe = storageService.recipes().filter {
            $0.input.count > 3 && !$0.byproducts.isEmpty
        }.randomElement()!
        
        settings = settingsService.currentSettings()
    }
}
