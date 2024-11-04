import SwiftUI

struct ChangeLog: Equatable, Identifiable {
    var version: Version
    var updateMessage: LocalizedStringKey
    var changes: [Change]
    
    var id: Version { version }
}

#if DEBUG
extension ChangeLog {
    static let previewValue = ChangeLog(
        version: .preview,
        updateMessage: "change-log-preview-update-message",
        changes: [
            ChangeLog.Change(log: "change-log-preview-change-1", changeType: .fix),
            ChangeLog.Change(log: "change-log-preview-change-2", changeType: .fix),
            
            ChangeLog.Change(log: "change-log-preview-change-3", changeType: .addition),
            ChangeLog.Change(log: "change-log-preview-change-4", changeType: .addition),
            
            ChangeLog.Change(log: "change-log-preview-change-5", changeType: .removal),
            ChangeLog.Change(log: "change-log-preview-change-6", changeType: .removal),
            
            ChangeLog.Change(log: "change-log-preview-change-7", changeType: .important),
            ChangeLog.Change(log: "change-log-preview-change-8", changeType: .important)
        ]
    )
}
#endif

extension ChangeLog {
    static subscript(version: Version) -> ChangeLog {
        switch version {
        #if DEBUG
        case .preview: .previewValue
        #endif
        case .v1_4: .v1_4
        case .v1_5: .v1_5
        case .v1_5_1: .v1_5_1
        case .v1_6: .v1_6
        case .v1_7: .v1_7
        case .v1_7_1: .v1_7_1
        case .v2_0: .v2_0
        case .v2_0_1: .v2_0_1
        case .v2_0_2: .v2_0_2
        case .v2_0_3: .v2_0_3
        case .v2_0_4: .v2_0_4
        case .v2_0_5: .v2_0_5
        case .v2_0_6: .v2_0_6
        }
    }
}
