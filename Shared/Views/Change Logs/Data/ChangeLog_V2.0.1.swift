
extension ChangeLog {
    static var v2_0_1: ChangeLog {
        ChangeLog(
            version: .v2_0_1,
            updateMessage: "change-log-v2-0-1-update-message",
            changes: [
                Change(log: "change-log-v2-0-1-change-1", changeType: .fix),
                Change(log: "change-log-v2-0-1-change-2", changeType: .fix),
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0.1") {
    ChangeLogView(.v2_0_1)
}
#endif
