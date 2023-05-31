
extension Disclaimer {
    static var v1_5: Disclaimer {
        Disclaimer(
            version: .v1_5,
            updateMessage: """
            Hello again, folks!
            
            Today we have a small update with only two significant changes. But I wanted to talk about different topic.
            
            Starting with this update I plan to releaes updates from time to time with smaller changes, but more frequently. This is needed more for me, than for you, to be honest, so if you want to share your opinion with me, you can do so via Share Feedback button in **Settings**. I want to say beforehand, that some of my changes might break your current saved productions and pinned items/recipes, but there's small I can do about that. At least you will not loose any progress in game 😅
            """,
            changes: [
                Change(
                    log: "Brand new production screen. Only UI changes, functionality is the same",
                    changeType: .addition
                ),
                Change(
                    log: "Favorite is renamed to Pinned since it makes more sense to me.",
                    changeType: .addition
                ),
                Change(
                    log: "Settings is now a separate tab.",
                    changeType: .addition
                ),
                Change(
                    log: "From now on all change logs can be found in the settings screen.",
                    changeType: .addition
                ),
                Change(
                    log: "Removed items without recipes from production list.",
                    changeType: .removal
                ),
            ]
        )
    }
}
