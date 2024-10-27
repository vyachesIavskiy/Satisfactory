
extension ChangeLog {
    static var v2_0_4: ChangeLog {
        ChangeLog(
            version: .v2_0_4,
            updateMessage: "change-log-v2-0-4-update-message",
            changes: [
                Change(log: "change-log-v2-0-4-change-1", changeType: .fix),
                Change(log: "change-log-v2-0-4-change-2", changeType: .fix)
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0.4") {
    ChangeLogView(.v2_0_4)
}
#endif
