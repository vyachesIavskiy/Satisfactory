import UIKit
import SwiftUI

extension Color {
    static func sh(_ shColor: SHColor) -> Color {
        shColor.color
    }
}

extension UIColor {
    static func sh(_ shColor: SHColor) -> UIColor {
        shColor.uiColor
    }
}

extension CGColor {
    static func sh(_ shColor: SHColor) -> CGColor {
        shColor.uiColor.cgColor
    }
}
