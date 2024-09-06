
extension ChangeLog {
    static var v1_5: ChangeLog {
        ChangeLog(
            version: .v1_5,
            updateMessage: "change-log-v1-5-update-message",
            changes: [
                ChangeLog.Change(
                    log: "change-log-v1-5-change-1",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-5-change-2",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-5-change-3",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-5-change-4",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-5-change-5",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-5-change-6",
                    changeType: .removal
                )
            ]
        )
    }
}
