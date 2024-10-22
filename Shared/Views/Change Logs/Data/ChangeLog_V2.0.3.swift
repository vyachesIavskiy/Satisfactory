
extension ChangeLog {
    static var v2_0_3: ChangeLog {
        ChangeLog(
            version: .v2_0_3,
            updateMessage: "change-log-v2-0-3-update-message",
            changes: [
                Change(log: "change-log-v2-0-3-change-1", changeType: .fix)
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0.3") {
    ChangeLogView(.v2_0_3)
}
#endif
