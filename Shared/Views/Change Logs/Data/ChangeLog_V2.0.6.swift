
extension ChangeLog {
    static var v2_0_6: ChangeLog {
        ChangeLog(
            version: .v2_0_6,
            updateMessage: "change-log-v2-0-6-update-message",
            changes: [
                Change(log: "change-log-v2-0-6-change-1", changeType: .fix),
                Change(log: "change-log-v2-0-6-change-2", changeType: .fix),
                Change(log: "change-log-v2-0-6-change-3", changeType: .addition),
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0.6") {
    ChangeLogView(.v2_0_6)
}
#endif
