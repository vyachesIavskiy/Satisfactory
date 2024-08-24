
extension ChangeLog {
    static var v2_0: ChangeLog {
        ChangeLog(
            version: .v2_0,
            updateMessage: "change-log-v2-0-update-message",
            changes: [
                Change(log: "change-log-v2-0-change-1", changeType: .important),
                Change(log: "change-log-v2-0-change-2", changeType: .important),
                Change(log: "change-log-v2-0-change-3", changeType: .important),
                Change(log: "change-log-v2-0-change-4", changeType: .important),
                
                Change(log: "change-log-v2-0-change-5", changeType: .addition),
                Change(log: "change-log-v2-0-change-6", changeType: .addition),
                Change(log: "change-log-v2-0-change-7", changeType: .addition),
                Change(log: "change-log-v2-0-change-8", changeType: .addition),
                Change(log: "change-log-v2-0-change-9", changeType: .addition),
                Change(log: "change-log-v2-0-change-10", changeType: .addition),
                Change(log: "change-log-v2-0-change-11", changeType: .addition),
                
                Change(log: "change-log-v2-0-change-12", changeType: .removal)
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0") {
    ChangeLogView(.v2_0)
}
#endif
