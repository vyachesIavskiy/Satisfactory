import SwiftUI

public struct SHColor: Sendable {
    private let name: String
    
    public var color: Color {
        Color(name, bundle: .module)
    }
    
    #if canImport(UIKit)
    public var uiColor: UIColor? {
        UIColor(named: name, in: .module, compatibleWith: nil)
    }
    #endif
    
    fileprivate init(name: String) {
        self.name = name
    }
}

// MARK: General
extension SHColor {
    public static let background1 = SHColor(name: "Colors/Background - 1")
}

// MARK: - Orange
extension SHColor {
    public static let orange10 = SHColor(name: "Colors/Orange/Orange - 10")
    public static let orange20 = SHColor(name: "Colors/Orange/Orange - 20")
    public static let orange30 = SHColor(name: "Colors/Orange/Orange - 30")
    public static let orange40 = SHColor(name: "Colors/Orange/Orange - 40")
    public static let orange50 = SHColor(name: "Colors/Orange/Orange - 50")
    public static let orange60 = SHColor(name: "Colors/Orange/Orange - 60")
    public static let orange70 = SHColor(name: "Colors/Orange/Orange - 70")
    public static let orange80 = SHColor(name: "Colors/Orange/Orange - 80")
    public static let orange90 = SHColor(name: "Colors/Orange/Orange - 90")
    public static let orange100 = SHColor(name: "Colors/Orange/Orange - 100")
    
    public static let orange = orange60
}

// MARK: Midnight
extension SHColor {
    public static let midnight10 = SHColor(name: "Colors/Midnight/Midnight - 10")
    public static let midnight20 = SHColor(name: "Colors/Midnight/Midnight - 20")
    public static let midnight30 = SHColor(name: "Colors/Midnight/Midnight - 30")
    public static let midnight40 = SHColor(name: "Colors/Midnight/Midnight - 40")
    public static let midnight50 = SHColor(name: "Colors/Midnight/Midnight - 50")
    public static let midnight60 = SHColor(name: "Colors/Midnight/Midnight - 60")
    public static let midnight70 = SHColor(name: "Colors/Midnight/Midnight - 70")
    public static let midnight80 = SHColor(name: "Colors/Midnight/Midnight - 80")
    public static let midnight90 = SHColor(name: "Colors/Midnight/Midnight - 90")
    public static let midnight100 = SHColor(name: "Colors/Midnight/Midnight - 100")
    
    public static let midnight = midnight60
}

// MARK: Cyan
extension SHColor {
    public static let cyan10 = SHColor(name: "Colors/Cyan/Cyan - 10")
    public static let cyan20 = SHColor(name: "Colors/Cyan/Cyan - 20")
    public static let cyan30 = SHColor(name: "Colors/Cyan/Cyan - 30")
    public static let cyan40 = SHColor(name: "Colors/Cyan/Cyan - 40")
    public static let cyan50 = SHColor(name: "Colors/Cyan/Cyan - 50")
    public static let cyan60 = SHColor(name: "Colors/Cyan/Cyan - 60")
    public static let cyan70 = SHColor(name: "Colors/Cyan/Cyan - 70")
    public static let cyan80 = SHColor(name: "Colors/Cyan/Cyan - 80")
    public static let cyan90 = SHColor(name: "Colors/Cyan/Cyan - 90")
    public static let cyan100 = SHColor(name: "Colors/Cyan/Cyan - 100")
    
    public static let cyan = cyan60
}

// MARK: Gray
extension SHColor {
    public static let gray10 = SHColor(name: "Colors/Gray/Gray - 10")
    public static let gray20 = SHColor(name: "Colors/Gray/Gray - 20")
    public static let gray30 = SHColor(name: "Colors/Gray/Gray - 30")
    public static let gray40 = SHColor(name: "Colors/Gray/Gray - 40")
    public static let gray50 = SHColor(name: "Colors/Gray/Gray - 50")
    public static let gray60 = SHColor(name: "Colors/Gray/Gray - 60")
    public static let gray70 = SHColor(name: "Colors/Gray/Gray - 70")
    public static let gray80 = SHColor(name: "Colors/Gray/Gray - 80")
    public static let gray90 = SHColor(name: "Colors/Gray/Gray - 90")
    public static let gray100 = SHColor(name: "Colors/Gray/Gray - 100")
    
    public static let gray = gray60
}

// MARK: Red
extension SHColor {
    public static let red10 = SHColor(name: "Colors/Red/Red - 10")
    public static let red20 = SHColor(name: "Colors/Red/Red - 20")
    public static let red30 = SHColor(name: "Colors/Red/Red - 30")
    public static let red40 = SHColor(name: "Colors/Red/Red - 40")
    public static let red50 = SHColor(name: "Colors/Red/Red - 50")
    public static let red60 = SHColor(name: "Colors/Red/Red - 60")
    public static let red70 = SHColor(name: "Colors/Red/Red - 70")
    public static let red80 = SHColor(name: "Colors/Red/Red - 80")
    public static let red90 = SHColor(name: "Colors/Red/Red - 90")
    public static let red100 = SHColor(name: "Colors/Red/Red - 100")
    
    public static let red = red60
}

// MARK: Green
extension SHColor {
    public static let green10 = SHColor(name: "Colors/Green/Green - 10")
    public static let green20 = SHColor(name: "Colors/Green/Green - 20")
    public static let green30 = SHColor(name: "Colors/Green/Green - 30")
    public static let green40 = SHColor(name: "Colors/Green/Green - 40")
    public static let green50 = SHColor(name: "Colors/Green/Green - 50")
    public static let green60 = SHColor(name: "Colors/Green/Green - 60")
    public static let green70 = SHColor(name: "Colors/Green/Green - 70")
    public static let green80 = SHColor(name: "Colors/Green/Green - 80")
    public static let green90 = SHColor(name: "Colors/Green/Green - 90")
    public static let green100 = SHColor(name: "Colors/Green/Green - 100")
    
    public static let green = green60
}

// MARK: Blue
extension SHColor {
    public static let blue10 = SHColor(name: "Colors/Blue/Blue - 10")
    public static let blue20 = SHColor(name: "Colors/Blue/Blue - 20")
    public static let blue30 = SHColor(name: "Colors/Blue/Blue - 30")
    public static let blue40 = SHColor(name: "Colors/Blue/Blue - 40")
    public static let blue50 = SHColor(name: "Colors/Blue/Blue - 50")
    public static let blue60 = SHColor(name: "Colors/Blue/Blue - 60")
    public static let blue70 = SHColor(name: "Colors/Blue/Blue - 70")
    public static let blue80 = SHColor(name: "Colors/Blue/Blue - 80")
    public static let blue90 = SHColor(name: "Colors/Blue/Blue - 90")
    public static let blue100 = SHColor(name: "Colors/Blue/Blue - 100")
    
    public static let blue = blue60
}

// MARK: Brown
extension SHColor {
    public static let brown10 = SHColor(name: "Colors/Brown/Brown - 10")
    public static let brown20 = SHColor(name: "Colors/Brown/Brown - 20")
    public static let brown30 = SHColor(name: "Colors/Brown/Brown - 30")
    public static let brown40 = SHColor(name: "Colors/Brown/Brown - 40")
    public static let brown50 = SHColor(name: "Colors/Brown/Brown - 50")
    public static let brown60 = SHColor(name: "Colors/Brown/Brown - 60")
    public static let brown70 = SHColor(name: "Colors/Brown/Brown - 70")
    public static let brown80 = SHColor(name: "Colors/Brown/Brown - 80")
    public static let brown90 = SHColor(name: "Colors/Brown/Brown - 90")
    public static let brown100 = SHColor(name: "Colors/Brown/Brown - 100")
    
    public static let brown = brown60
}

// MARK: Lime
extension SHColor {
    public static let lime10 = SHColor(name: "Colors/Lime/Lime - 10")
    public static let lime20 = SHColor(name: "Colors/Lime/Lime - 20")
    public static let lime30 = SHColor(name: "Colors/Lime/Lime - 30")
    public static let lime40 = SHColor(name: "Colors/Lime/Lime - 40")
    public static let lime50 = SHColor(name: "Colors/Lime/Lime - 50")
    public static let lime60 = SHColor(name: "Colors/Lime/Lime - 60")
    public static let lime70 = SHColor(name: "Colors/Lime/Lime - 70")
    public static let lime80 = SHColor(name: "Colors/Lime/Lime - 80")
    public static let lime90 = SHColor(name: "Colors/Lime/Lime - 90")
    public static let lime100 = SHColor(name: "Colors/Lime/Lime - 100")
    
    public static let lime = lime60
}

// MARK: Magenta
extension SHColor {
    public static let magenta10 = SHColor(name: "Colors/Magenta/Magenta - 10")
    public static let magenta20 = SHColor(name: "Colors/Magenta/Magenta - 20")
    public static let magenta30 = SHColor(name: "Colors/Magenta/Magenta - 30")
    public static let magenta40 = SHColor(name: "Colors/Magenta/Magenta - 40")
    public static let magenta50 = SHColor(name: "Colors/Magenta/Magenta - 50")
    public static let magenta60 = SHColor(name: "Colors/Magenta/Magenta - 60")
    public static let magenta70 = SHColor(name: "Colors/Magenta/Magenta - 70")
    public static let magenta80 = SHColor(name: "Colors/Magenta/Magenta - 80")
    public static let magenta90 = SHColor(name: "Colors/Magenta/Magenta - 90")
    public static let magenta100 = SHColor(name: "Colors/Magenta/Magenta - 100")
    
    public static let magenta = magenta60
}

// MARK: Pink
extension SHColor {
    public static let pink10 = SHColor(name: "Colors/Pink/Pink - 10")
    public static let pink20 = SHColor(name: "Colors/Pink/Pink - 20")
    public static let pink30 = SHColor(name: "Colors/Pink/Pink - 30")
    public static let pink40 = SHColor(name: "Colors/Pink/Pink - 40")
    public static let pink50 = SHColor(name: "Colors/Pink/Pink - 50")
    public static let pink60 = SHColor(name: "Colors/Pink/Pink - 60")
    public static let pink70 = SHColor(name: "Colors/Pink/Pink - 70")
    public static let pink80 = SHColor(name: "Colors/Pink/Pink - 80")
    public static let pink90 = SHColor(name: "Colors/Pink/Pink - 90")
    public static let pink100 = SHColor(name: "Colors/Pink/Pink - 100")
    
    public static let pink = pink60
}

// MARK: Purple
extension SHColor {
    public static let purple10 = SHColor(name: "Colors/Purple/Purple - 10")
    public static let purple20 = SHColor(name: "Colors/Purple/Purple - 20")
    public static let purple30 = SHColor(name: "Colors/Purple/Purple - 30")
    public static let purple40 = SHColor(name: "Colors/Purple/Purple - 40")
    public static let purple50 = SHColor(name: "Colors/Purple/Purple - 50")
    public static let purple60 = SHColor(name: "Colors/Purple/Purple - 60")
    public static let purple70 = SHColor(name: "Colors/Purple/Purple - 70")
    public static let purple80 = SHColor(name: "Colors/Purple/Purple - 80")
    public static let purple90 = SHColor(name: "Colors/Purple/Purple - 90")
    public static let purple100 = SHColor(name: "Colors/Purple/Purple - 100")
    
    public static let purple = purple60
}

// MARK: Turquoise
extension SHColor {
    public static let turquoise10 = SHColor(name: "Colors/Turquoise/Turquoise - 10")
    public static let turquoise20 = SHColor(name: "Colors/Turquoise/Turquoise - 20")
    public static let turquoise30 = SHColor(name: "Colors/Turquoise/Turquoise - 30")
    public static let turquoise40 = SHColor(name: "Colors/Turquoise/Turquoise - 40")
    public static let turquoise50 = SHColor(name: "Colors/Turquoise/Turquoise - 50")
    public static let turquoise60 = SHColor(name: "Colors/Turquoise/Turquoise - 60")
    public static let turquoise70 = SHColor(name: "Colors/Turquoise/Turquoise - 70")
    public static let turquoise80 = SHColor(name: "Colors/Turquoise/Turquoise - 80")
    public static let turquoise90 = SHColor(name: "Colors/Turquoise/Turquoise - 90")
    public static let turquoise100 = SHColor(name: "Colors/Turquoise/Turquoise - 100")
    
    public static let turquoise = turquoise60
}

// MARK: Yellow
extension SHColor {
    public static let yellow10 = SHColor(name: "Colors/Yellow/Yellow - 10")
    public static let yellow20 = SHColor(name: "Colors/Yellow/Yellow - 20")
    public static let yellow30 = SHColor(name: "Colors/Yellow/Yellow - 30")
    public static let yellow40 = SHColor(name: "Colors/Yellow/Yellow - 40")
    public static let yellow50 = SHColor(name: "Colors/Yellow/Yellow - 50")
    public static let yellow60 = SHColor(name: "Colors/Yellow/Yellow - 60")
    public static let yellow70 = SHColor(name: "Colors/Yellow/Yellow - 70")
    public static let yellow80 = SHColor(name: "Colors/Yellow/Yellow - 80")
    public static let yellow90 = SHColor(name: "Colors/Yellow/Yellow - 90")
    public static let yellow100 = SHColor(name: "Colors/Yellow/Yellow - 100")
    
    public static let yellow = yellow60
}
