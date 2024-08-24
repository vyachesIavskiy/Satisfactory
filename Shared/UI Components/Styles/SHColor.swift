import UIKit
import SwiftUI

struct SHColor {
    private let name: String
    
    var color: Color {
        Color(name)
    }
    
    var uiColor: UIColor {
        UIColor(named: name) ?? .gray
    }
    
    fileprivate init(name: String) {
        self.name = name
    }
}

// MARK: General
extension SHColor {
    static let background1 = SHColor(name: "Colors/Background - 1")
}

// MARK: - Orange
extension SHColor {
    static let orange10 = SHColor(name: "Colors/Orange/Orange - 10")
    static let orange20 = SHColor(name: "Colors/Orange/Orange - 20")
    static let orange30 = SHColor(name: "Colors/Orange/Orange - 30")
    static let orange40 = SHColor(name: "Colors/Orange/Orange - 40")
    static let orange50 = SHColor(name: "Colors/Orange/Orange - 50")
    static let orange60 = SHColor(name: "Colors/Orange/Orange - 60")
    static let orange70 = SHColor(name: "Colors/Orange/Orange - 70")
    static let orange80 = SHColor(name: "Colors/Orange/Orange - 80")
    static let orange90 = SHColor(name: "Colors/Orange/Orange - 90")
    static let orange100 = SHColor(name: "Colors/Orange/Orange - 100")
    
    static let orange = orange60
}

// MARK: Midnight
extension SHColor {
    static let midnight10 = SHColor(name: "Colors/Midnight/Midnight - 10")
    static let midnight20 = SHColor(name: "Colors/Midnight/Midnight - 20")
    static let midnight30 = SHColor(name: "Colors/Midnight/Midnight - 30")
    static let midnight40 = SHColor(name: "Colors/Midnight/Midnight - 40")
    static let midnight50 = SHColor(name: "Colors/Midnight/Midnight - 50")
    static let midnight60 = SHColor(name: "Colors/Midnight/Midnight - 60")
    static let midnight70 = SHColor(name: "Colors/Midnight/Midnight - 70")
    static let midnight80 = SHColor(name: "Colors/Midnight/Midnight - 80")
    static let midnight90 = SHColor(name: "Colors/Midnight/Midnight - 90")
    static let midnight100 = SHColor(name: "Colors/Midnight/Midnight - 100")
    
    static let midnight = midnight60
}

// MARK: Cyan
extension SHColor {
    static let cyan10 = SHColor(name: "Colors/Cyan/Cyan - 10")
    static let cyan20 = SHColor(name: "Colors/Cyan/Cyan - 20")
    static let cyan30 = SHColor(name: "Colors/Cyan/Cyan - 30")
    static let cyan40 = SHColor(name: "Colors/Cyan/Cyan - 40")
    static let cyan50 = SHColor(name: "Colors/Cyan/Cyan - 50")
    static let cyan60 = SHColor(name: "Colors/Cyan/Cyan - 60")
    static let cyan70 = SHColor(name: "Colors/Cyan/Cyan - 70")
    static let cyan80 = SHColor(name: "Colors/Cyan/Cyan - 80")
    static let cyan90 = SHColor(name: "Colors/Cyan/Cyan - 90")
    static let cyan100 = SHColor(name: "Colors/Cyan/Cyan - 100")
    
    static let cyan = cyan60
}

// MARK: Gray
extension SHColor {
    static let gray10 = SHColor(name: "Colors/Gray/Gray - 10")
    static let gray20 = SHColor(name: "Colors/Gray/Gray - 20")
    static let gray30 = SHColor(name: "Colors/Gray/Gray - 30")
    static let gray40 = SHColor(name: "Colors/Gray/Gray - 40")
    static let gray50 = SHColor(name: "Colors/Gray/Gray - 50")
    static let gray60 = SHColor(name: "Colors/Gray/Gray - 60")
    static let gray70 = SHColor(name: "Colors/Gray/Gray - 70")
    static let gray80 = SHColor(name: "Colors/Gray/Gray - 80")
    static let gray90 = SHColor(name: "Colors/Gray/Gray - 90")
    static let gray100 = SHColor(name: "Colors/Gray/Gray - 100")
    
    static let gray = gray60
}

// MARK: Red
extension SHColor {
    static let red10 = SHColor(name: "Colors/Red/Red - 10")
    static let red20 = SHColor(name: "Colors/Red/Red - 20")
    static let red30 = SHColor(name: "Colors/Red/Red - 30")
    static let red40 = SHColor(name: "Colors/Red/Red - 40")
    static let red50 = SHColor(name: "Colors/Red/Red - 50")
    static let red60 = SHColor(name: "Colors/Red/Red - 60")
    static let red70 = SHColor(name: "Colors/Red/Red - 70")
    static let red80 = SHColor(name: "Colors/Red/Red - 80")
    static let red90 = SHColor(name: "Colors/Red/Red - 90")
    static let red100 = SHColor(name: "Colors/Red/Red - 100")
    
    static let red = red60
}

// MARK: Green
extension SHColor {
    static let green10 = SHColor(name: "Colors/Green/Green - 10")
    static let green20 = SHColor(name: "Colors/Green/Green - 20")
    static let green30 = SHColor(name: "Colors/Green/Green - 30")
    static let green40 = SHColor(name: "Colors/Green/Green - 40")
    static let green50 = SHColor(name: "Colors/Green/Green - 50")
    static let green60 = SHColor(name: "Colors/Green/Green - 60")
    static let green70 = SHColor(name: "Colors/Green/Green - 70")
    static let green80 = SHColor(name: "Colors/Green/Green - 80")
    static let green90 = SHColor(name: "Colors/Green/Green - 90")
    static let green100 = SHColor(name: "Colors/Green/Green - 100")
    
    static let green = green60
}

// MARK: Blue
extension SHColor {
    static let blue10 = SHColor(name: "Colors/Blue/Blue - 10")
    static let blue20 = SHColor(name: "Colors/Blue/Blue - 20")
    static let blue30 = SHColor(name: "Colors/Blue/Blue - 30")
    static let blue40 = SHColor(name: "Colors/Blue/Blue - 40")
    static let blue50 = SHColor(name: "Colors/Blue/Blue - 50")
    static let blue60 = SHColor(name: "Colors/Blue/Blue - 60")
    static let blue70 = SHColor(name: "Colors/Blue/Blue - 70")
    static let blue80 = SHColor(name: "Colors/Blue/Blue - 80")
    static let blue90 = SHColor(name: "Colors/Blue/Blue - 90")
    static let blue100 = SHColor(name: "Colors/Blue/Blue - 100")
    
    static let blue = blue60
}

// MARK: Brown
extension SHColor {
    static let brown10 = SHColor(name: "Colors/Brown/Brown - 10")
    static let brown20 = SHColor(name: "Colors/Brown/Brown - 20")
    static let brown30 = SHColor(name: "Colors/Brown/Brown - 30")
    static let brown40 = SHColor(name: "Colors/Brown/Brown - 40")
    static let brown50 = SHColor(name: "Colors/Brown/Brown - 50")
    static let brown60 = SHColor(name: "Colors/Brown/Brown - 60")
    static let brown70 = SHColor(name: "Colors/Brown/Brown - 70")
    static let brown80 = SHColor(name: "Colors/Brown/Brown - 80")
    static let brown90 = SHColor(name: "Colors/Brown/Brown - 90")
    static let brown100 = SHColor(name: "Colors/Brown/Brown - 100")
    
    static let brown = brown60
}

// MARK: Lime
extension SHColor {
    static let lime10 = SHColor(name: "Colors/Lime/Lime - 10")
    static let lime20 = SHColor(name: "Colors/Lime/Lime - 20")
    static let lime30 = SHColor(name: "Colors/Lime/Lime - 30")
    static let lime40 = SHColor(name: "Colors/Lime/Lime - 40")
    static let lime50 = SHColor(name: "Colors/Lime/Lime - 50")
    static let lime60 = SHColor(name: "Colors/Lime/Lime - 60")
    static let lime70 = SHColor(name: "Colors/Lime/Lime - 70")
    static let lime80 = SHColor(name: "Colors/Lime/Lime - 80")
    static let lime90 = SHColor(name: "Colors/Lime/Lime - 90")
    static let lime100 = SHColor(name: "Colors/Lime/Lime - 100")
    
    static let lime = lime60
}

// MARK: Magenta
extension SHColor {
    static let magenta10 = SHColor(name: "Colors/Magenta/Magenta - 10")
    static let magenta20 = SHColor(name: "Colors/Magenta/Magenta - 20")
    static let magenta30 = SHColor(name: "Colors/Magenta/Magenta - 30")
    static let magenta40 = SHColor(name: "Colors/Magenta/Magenta - 40")
    static let magenta50 = SHColor(name: "Colors/Magenta/Magenta - 50")
    static let magenta60 = SHColor(name: "Colors/Magenta/Magenta - 60")
    static let magenta70 = SHColor(name: "Colors/Magenta/Magenta - 70")
    static let magenta80 = SHColor(name: "Colors/Magenta/Magenta - 80")
    static let magenta90 = SHColor(name: "Colors/Magenta/Magenta - 90")
    static let magenta100 = SHColor(name: "Colors/Magenta/Magenta - 100")
    
    static let magenta = magenta60
}

// MARK: Pink
extension SHColor {
    static let pink10 = SHColor(name: "Colors/Pink/Pink - 10")
    static let pink20 = SHColor(name: "Colors/Pink/Pink - 20")
    static let pink30 = SHColor(name: "Colors/Pink/Pink - 30")
    static let pink40 = SHColor(name: "Colors/Pink/Pink - 40")
    static let pink50 = SHColor(name: "Colors/Pink/Pink - 50")
    static let pink60 = SHColor(name: "Colors/Pink/Pink - 60")
    static let pink70 = SHColor(name: "Colors/Pink/Pink - 70")
    static let pink80 = SHColor(name: "Colors/Pink/Pink - 80")
    static let pink90 = SHColor(name: "Colors/Pink/Pink - 90")
    static let pink100 = SHColor(name: "Colors/Pink/Pink - 100")
    
    static let pink = pink60
}

// MARK: Purple
extension SHColor {
    static let purple10 = SHColor(name: "Colors/Purple/Purple - 10")
    static let purple20 = SHColor(name: "Colors/Purple/Purple - 20")
    static let purple30 = SHColor(name: "Colors/Purple/Purple - 30")
    static let purple40 = SHColor(name: "Colors/Purple/Purple - 40")
    static let purple50 = SHColor(name: "Colors/Purple/Purple - 50")
    static let purple60 = SHColor(name: "Colors/Purple/Purple - 60")
    static let purple70 = SHColor(name: "Colors/Purple/Purple - 70")
    static let purple80 = SHColor(name: "Colors/Purple/Purple - 80")
    static let purple90 = SHColor(name: "Colors/Purple/Purple - 90")
    static let purple100 = SHColor(name: "Colors/Purple/Purple - 100")
    
    static let purple = purple60
}

// MARK: Turquoise
extension SHColor {
    static let turquoise10 = SHColor(name: "Colors/Turquoise/Turquoise - 10")
    static let turquoise20 = SHColor(name: "Colors/Turquoise/Turquoise - 20")
    static let turquoise30 = SHColor(name: "Colors/Turquoise/Turquoise - 30")
    static let turquoise40 = SHColor(name: "Colors/Turquoise/Turquoise - 40")
    static let turquoise50 = SHColor(name: "Colors/Turquoise/Turquoise - 50")
    static let turquoise60 = SHColor(name: "Colors/Turquoise/Turquoise - 60")
    static let turquoise70 = SHColor(name: "Colors/Turquoise/Turquoise - 70")
    static let turquoise80 = SHColor(name: "Colors/Turquoise/Turquoise - 80")
    static let turquoise90 = SHColor(name: "Colors/Turquoise/Turquoise - 90")
    static let turquoise100 = SHColor(name: "Colors/Turquoise/Turquoise - 100")
    
    static let turquoise = turquoise60
}

// MARK: Yellow
extension SHColor {
    static let yellow10 = SHColor(name: "Colors/Yellow/Yellow - 10")
    static let yellow20 = SHColor(name: "Colors/Yellow/Yellow - 20")
    static let yellow30 = SHColor(name: "Colors/Yellow/Yellow - 30")
    static let yellow40 = SHColor(name: "Colors/Yellow/Yellow - 40")
    static let yellow50 = SHColor(name: "Colors/Yellow/Yellow - 50")
    static let yellow60 = SHColor(name: "Colors/Yellow/Yellow - 60")
    static let yellow70 = SHColor(name: "Colors/Yellow/Yellow - 70")
    static let yellow80 = SHColor(name: "Colors/Yellow/Yellow - 80")
    static let yellow90 = SHColor(name: "Colors/Yellow/Yellow - 90")
    static let yellow100 = SHColor(name: "Colors/Yellow/Yellow - 100")
    
    static let yellow = yellow60
}
