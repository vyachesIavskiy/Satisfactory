import SwiftUI

struct Disclaimer: Equatable, Identifiable {
    enum Version: Equatable, CaseIterable {
        case preview
        case v1_4
        case v1_5
        case v1_5_1
        
        static var validVersions: [Version] = Array(allCases.dropFirst())
    }
    
    struct Change: Equatable, Identifiable {
        enum ChangeType: Equatable {
            case fix
            case addition
            case removal
            case important
        }
        
        let id = UUID()
        var log: LocalizedStringKey
        var changeType: ChangeType
    }
    
    var version: Version
    var updateMessage: LocalizedStringKey
    var changes: [Change]
    
    var id: Version { version }
}

extension Disclaimer {
    static var previewValue: Disclaimer {
        Disclaimer(
            version: .preview,
            updateMessage: "This is a preview of disclaimer",
            changes: [
                Change(log: "This is a fix", changeType: .fix),
                Change(log: "This is an addition change", changeType: .addition),
                Change(log: "This is a removal change", changeType: .removal),
                Change(log: "This is a very important change", changeType: .important)
            ]
        )
    }
}

extension Sequence where Element == Disclaimer.Change {
    subscript(changeType: Disclaimer.Change.ChangeType) -> [Element] {
        filter { $0.changeType == changeType }
    }
}

extension Disclaimer {
    static var allDisclaimersAreShown: Bool {
        get {
            Version.validVersions.reduce(false) { $0 ? $0 : self[shownFor: $1] }
        }
        set {
            Version.validVersions.forEach {
                self[shownFor: $0] = newValue
            }
        }
    }
    
    static var latestVersion: Version? {
        Version.validVersions.reversed().first { version in
            !self[shownFor: version]
        }
    }
    
    static var latest: Disclaimer? {
        latestVersion.map { version in
            self[version]
        }
    }
    
    static subscript(version: Version) -> Disclaimer {
        switch version {
        case .preview: return .previewValue
        case .v1_4: return .v1_4
        case .v1_5: return .v1_5
        case .v1_5_1: return .v1_5_1
        }
    }
    
    private static let userDefaults = UserDefaults.standard
    
    private static subscript(shownFor version: Version) -> Bool {
        get {
            userDefaults.bool(forKey: key(for: version))
        }
        set {
            userDefaults.set(newValue, forKey: key(for: version))
        }
    }
    
    private static func key(for version: Version) -> String {
        var key = "disclaimer.shown."
        switch version {
        case .v1_4: key.append("v1_4")
        case .v1_5: key.append("v1_5")
        case .v1_5_1: key.append("v1_5_1")
            
        case .preview: break
        }
        
        return key
    }
}
