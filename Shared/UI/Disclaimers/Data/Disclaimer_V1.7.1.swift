
extension Disclaimer {
    static var v1_7_1: Disclaimer {
        Disclaimer(
            version: .v1_7_1,
            updateMessage: """
            A very big thanks this time goes to **Christopher Notley-Smith** for pointing out that a most recent change in UI removed an ability to change the amount of production while selecting recipes. This update fixes this issue.
            """,
            changes: [
                Change(
                    log: "Restored ability to change production amount while selecting recipes.",
                    changeType: .fix
                )
            ]
        )
    }
}
