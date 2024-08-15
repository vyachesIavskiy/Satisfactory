import SwiftUI

struct ChangeLog: Equatable, Identifiable {
    enum Version: Equatable, CaseIterable {
        case preview
        case v1_4
        case v1_5
        case v1_5_1
        case v1_6
        case v1_7
        case v1_7_1
        
        static let validVersions = Array(allCases.dropFirst())
        
        var title: String {
            switch self {
            case .preview: "Preview"
            case .v1_4: "v 1.4"
            case .v1_5: "v 1.5"
            case .v1_5_1: "v 1.5.1"
            case .v1_6: "v 1.6"
            case .v1_7: "v 1.7"
            case .v1_7_1: "v 1.7.1"
            }
        }
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

extension ChangeLog {
    static var previewValue: ChangeLog {
        ChangeLog(
            version: .preview,
            updateMessage: "This is a preview of change log. This message appears on top of the change log and should describe what is the general purpose of the change.",
            changes: [
                Change(log: "This is a fix", changeType: .fix),
                Change(log: "This is an another fix", changeType: .fix),
                
                Change(log: "This is an addition change", changeType: .addition),
                Change(log: "This is an another addition change, probably very good addition", changeType: .addition),
                
                Change(log: "This is a removal change", changeType: .removal),
                Change(log: "This is an another removal change, sometimes this might now be exactly what users expect to see", changeType: .removal),
                
                Change(log: "This is a very important change", changeType: .important),
                Change(log: "This is an another very important change. Such changes appear in orange section.", changeType: .important)
            ]
        )
    }
}

extension Sequence where Element == ChangeLog.Change {
    subscript(changeType: ChangeLog.Change.ChangeType) -> [Element] {
        filter { $0.changeType == changeType }
    }
}

extension ChangeLog {
    static var allChangeLogsAreShown: Bool {
        get {
            Version.validVersions.allSatisfy {
                self[shownFor: $0]
            }
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
    
    static var latest: ChangeLog? {
        latestVersion.map { version in
            self[version]
        }
    }
    
    static subscript(version: Version) -> ChangeLog {
        switch version {
        case .preview: .previewValue
        case .v1_4: .v1_4
        case .v1_5: .v1_5
        case .v1_5_1: .v1_5_1
        case .v1_6: .v1_6
        case .v1_7: .v1_7
        case .v1_7_1: .v1_7_1
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
        case .v1_6: key.append("v1_6")
        case .v1_7: key.append("v1_7")
        case .v1_7_1: key.append("v1_7_1")
            
        case .preview: break
        }
        
        return key
    }
}
