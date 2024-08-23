
extension ChangeLog {
    static var v2_0: ChangeLog {
        ChangeLog(
            version: .v2_0,
            updateMessage: """
            A good day to everybody! 

            On behalf of the whole **Satisfactory Helper** team I would like to thank you for using this app and waiting so patiently for this big release.
            """,
            changes: [
                Change(log: "A new fresh design for the whole app.", changeType: .important),
                Change(log: "Organise your productions into Factories with a new Factories tab.", changeType: .important),
                Change(log: "Take more control over your production lines with a whole new production calculator.", changeType: .important),
                Change(log: "Do not forget to share your feedback via a corresponding button in a Settings tab.", changeType: .important),
                
                Change(log: "Added categories for New Production screen.", changeType: .addition),
                Change(log: "Added ability to disable Seasonal event content.", changeType: .addition),
                Change(log: "Added ability to adjust recipes for items with 3 different modes: **Auto**, **Fraction** and **Fixed amount**.", changeType: .addition),
                Change(log: "Added ability to use byproducts in production lines.", changeType: .addition),
                Change(log: "Added Factories tab.", changeType: .addition),
                Change(log: "Added ability to see production statistics for a Factory.", changeType: .addition),
                Change(log: "Added power consumption for production building information to Production Statistics.", changeType: .addition),
                
                Change(log: "Removed support for **iOS 16** with this release.", changeType: .removal)
            ]
        )
    }
}

#if DEBUG
import SwiftUI

#Preview("2.0") {
    ChangeLogView(.v2_0)
}
#endif
