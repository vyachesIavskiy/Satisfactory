import Foundation
import Observation

@Observable
final class TabsViewModel {
    // MARK: Observed properties
    var selectedTab = TabValue.newProduction
    var shouldPresentWhatsNew = false
    
    // MARK: Ignored properties
    private let userDefaults = UserDefaults.standard
    
    func checkWhatsNewStatus() {
        guard
            let latestVersion = ChangeLog.Version.validVersions.last,
            let key = userDefaultKey(for: latestVersion)
        else { return }
        
        shouldPresentWhatsNew = !userDefaults.bool(forKey: key)
    }
    
    func didShowWhatsNew() {
        guard
            let latestVersion = ChangeLog.Version.validVersions.last,
            let key = userDefaultKey(for: latestVersion)
        else { return }
        
        shouldPresentWhatsNew = false
        userDefaults.set(true, forKey: key)
    }
    
    private func userDefaultKey(for version: ChangeLog.Version) -> String? {
        let keyPrefix = "whats-new.shown-for-version."
        
        return switch version {
        #if DEBUG
        case .preview:
            nil // Never save Preview version
        #endif
            
        case .v1_4, .v1_5, .v1_5_1, .v1_6, .v1_7, .v1_7_1:
            nil // What's new is not available for versions lower than 2.0
        case .v2_0:
            "\(keyPrefix)v2-0"
        case .v2_0_1, .v2_0_2, .v2_0_3, .v2_0_4:
            nil // What's new is not available for hot fixes
        }
    }
}

extension TabsViewModel {
    enum TabValue {
        case newProduction
        case factories
        case settings
    }
}
