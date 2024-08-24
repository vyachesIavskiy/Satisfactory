
extension ChangeLog {
    static var v1_7: ChangeLog {
        ChangeLog(
            version: .v1_7,
            updateMessage: "change-log-v1-7-update-message",
            changes: [
                ChangeLog.Change(
                    log: "change-log-v1-7-change-1",
                    changeType: .fix
                ),
                ChangeLog.Change(
                    log: "change-log-v1-7-change-2",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-7-change-3",
                    changeType: .addition
                )
            ]
        )
    }
}
