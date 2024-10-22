
extension ChangeLog {
    static var v2_0_2: ChangeLog {
        ChangeLog(
            version: .v2_0_2,
            updateMessage: "change-log-v2-0-2-update-message",
            changes: [
                Change(log: "change-log-v2-0-2-change-1", changeType: .fix)
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0.2") {
    ChangeLogView(.v2_0_2)
}
#endif
