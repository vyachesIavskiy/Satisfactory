
extension Disclaimer {
    static var v1_6: Disclaimer {
        Disclaimer(
            version: .v1_6,
            updateMessage: """
            Good day, folks!
            
            Today we have another small update without any changes in functionality. I just updated recipes UI for more mature feel and look. Any feedback about new style and design is very appreciated.
            """,
            changes: [
                Change(
                    log: "Recipe view for both icon and row style are now updated to use new UI style.",
                    changeType: .addition
                )
            ]
        )
    }
}