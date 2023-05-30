import Foundation

extension Bundle {
    var appVersion: String {
        infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
    }
    
    var appBuildNumber: String {
        infoDictionary?["CFBundleVersion"] as? String ?? ""
    }
}
