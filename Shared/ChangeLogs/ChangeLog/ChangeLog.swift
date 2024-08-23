import SwiftUI

struct ChangeLog: Equatable, Identifiable {
    var version: Version
    var updateMessage: LocalizedStringKey
    var changes: [Change]
    
    var id: Version { version }
}

extension ChangeLog {
    static let previewValue = ChangeLog(
        version: .preview,
        updateMessage: "This is a preview of change log. This message appears on top of the change log and should describe what is the general purpose of the change.",
        changes: [
            ChangeLog.Change(log: "This is a fix", changeType: .fix),
            ChangeLog.Change(log: "This is an another fix", changeType: .fix),
            
            ChangeLog.Change(log: "This is an addition change", changeType: .addition),
            ChangeLog.Change(log: "This is an another addition change, probably very good addition", changeType: .addition),
            
            ChangeLog.Change(log: "This is a removal change", changeType: .removal),
            ChangeLog.Change(log: "This is an another removal change, sometimes this might now be exactly what users expect to see", changeType: .removal),
            
            ChangeLog.Change(log: "This is a very important change", changeType: .important),
            ChangeLog.Change(log: "This is an another very important change. Such changes appear in orange section.", changeType: .important)
        ]
    )
}

extension ChangeLog {
    static subscript(version: Version) -> ChangeLog {
        switch version {
        case .preview: .previewValue
        case .v1_4: .v1_4
        case .v1_5: .v1_5
        case .v1_5_1: .v1_5_1
        case .v1_6: .v1_6
        case .v1_7: .v1_7
        case .v1_7_1: .v1_7_1
        case .v2_0: .v2_0
        }
    }
}
