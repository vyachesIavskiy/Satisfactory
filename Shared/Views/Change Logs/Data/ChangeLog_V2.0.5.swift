
extension ChangeLog {
    static var v2_0_5: ChangeLog {
        ChangeLog(
            version: .v2_0_5,
            updateMessage: "change-log-v2-0-5-update-message",
            changes: [
                Change(log: "change-log-v2-0-5-change-1", changeType: .removal),
                Change(log: "change-log-v2-0-5-change-2", changeType: .addition),
                Change(log: "change-log-v2-0-5-change-3", changeType: .fix),
                Change(log: "change-log-v2-0-5-change-4", changeType: .fix),
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0.5") {
    ChangeLogView(.v2_0_5)
}
#endif
