
extension Disclaimer {
    static var v1_4: Disclaimer {
        Disclaimer(
            version: .v1_4,
            updateMessage: """
            It's been a while since you saw an update here. I promised on **reddit**, on **AppStore** and other places that you should expect a lot of changes in the next version, including a new design.
            
            Well... This is not an update we were talking about. Unfortunatelly, I'm still working on it and I don't have even rough estimation on when it will be available. What bothered me very much all this time is that currently my app does not represent relaity of **Satisfactory** and I constantly thought that I need to fix it. So that's why we have this update.
            """,
            changes: [
                Disclaimer.Change(
                    log: "All recipes and items are updated to the latest data in the game",
                    changeType: .addition
                ),
                Disclaimer.Change(
                    log: "It's now possible to hide items that do not have recipes.",
                    changeType: .addition
                ),
                Disclaimer.Change(
                    log: "Fixed a bug with keyboard is not able to hide when you type amount of produced item.",
                    changeType: .addition
                ),
                Disclaimer.Change(
                    log: "In **Settings** menu there is now a new entry for sending your feedback. With this you can have more direct contact with me. All proposals, issues or anything else related to this app is much appreciated.",
                    changeType: .addition
                ),
                Disclaimer.Change(
                    log: "Unfortunately if you had any saved production chains for items that are no longer in game (primarely weapons), these production chains are no longer available and you will have to create new ones.",
                    changeType: .important
                )
            ]
        )
    }
}
