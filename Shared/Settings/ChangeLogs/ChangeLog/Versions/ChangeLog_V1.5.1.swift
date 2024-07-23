
extension ChangeLog {
    static var v1_5_1: ChangeLog {
        ChangeLog(
            version: .v1_5_1,
            updateMessage: """
            Long time no see!
            
            Today we have a very small update that fixes a significant crash.
            
            Shotout to Alexander, who sent me a feedback about this issue.
            """,
            changes: [
                Change(
                    log: "Fixed a crash when you try to access Uranium or Plutonium waste.",
                    changeType: .fix
                )
            ]
        )
    }
}
