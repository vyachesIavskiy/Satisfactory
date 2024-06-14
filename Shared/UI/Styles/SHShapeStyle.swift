import SwiftUI

struct SHShapeStyle: ShapeStyle {
    private let shColor: SHColor
    
    init(_ shColor: SHColor) {
        self.shColor = shColor
    }
    
    func resolve(in environment: EnvironmentValues) -> Color {
        shColor.color
    }
}

extension ShapeStyle where Self == SHShapeStyle {
    static func sh(_ shColor: SHColor) -> SHShapeStyle {
        SHShapeStyle(shColor)
    }
}

