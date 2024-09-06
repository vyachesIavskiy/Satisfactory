import Foundation
import Observation

@Observable
final class TabsViewModel {
    // MARK: Observed properties
    var selectedTabIndex = 0
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
        case .preview:
            nil // Never save Preview version
            
        case .v1_4, .v1_5, .v1_5_1, .v1_6, .v1_7, .v1_7_1:
            nil // What's new is not available for versions lower than 2.0
        case .v2_0:
            "\(keyPrefix)v2-0"
        }
    }
}
