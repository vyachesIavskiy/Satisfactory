
extension ChangeLog {
    static var v1_7: ChangeLog {
        ChangeLog(
            version: .v1_7,
            updateMessage: """
            Ahoj!
            
            Another small update that does not break anything 🤞. Although there are some fixes in UI. Hope you enjoy! In any case you can let us know via a feedback in settings!
            """,
            changes: [
                Change(
                    log: "Saved productions are no longer visible in recipe selection screen for production.",
                    changeType: .fix
                ),
                Change(
                    log: "Items list has a new UI (again).",
                    changeType: .addition
                ),
                Change(
                    log: "Production screen is now a separate full screen view. We hope this way it will not so confusing.",
                    changeType: .addition
                )
            ]
        )
    }
}
