
extension ChangeLog {
    static var v1_4: ChangeLog {
        ChangeLog(
            version: .v1_4,
            updateMessage: "change-log-v1-4-update-message",
            changes: [
                ChangeLog.Change(
                    log: "change-log-v1-4-change-1",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-4-change-2",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-4-change-3",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-4-change-4",
                    changeType: .addition
                ),
                ChangeLog.Change(
                    log: "change-log-v1-4-change-5",
                    changeType: .important
                )
            ]
        )
    }
}
