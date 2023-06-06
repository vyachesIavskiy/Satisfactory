import SwiftUI

extension Gradient {
    static let itemSelection = Gradient(stops: [
        Gradient.Stop(color: Color("Item selection - step 0").opacity(0.7), location: 0),
        Gradient.Stop(color: Color("Item selection - step 1").opacity(0.7), location: 0.2),
        Gradient.Stop(color: Color("Item selection - step 2").opacity(0.2), location: 1)
    ])
    
    static let itemExtractable = Gradient(colors: [Color("Secondary").opacity(0.25)])
    
    static let empty = Gradient(colors: [])
}
