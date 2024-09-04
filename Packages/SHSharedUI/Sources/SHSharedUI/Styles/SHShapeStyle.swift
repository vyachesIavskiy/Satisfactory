import SwiftUI

public struct SHShapeStyle: ShapeStyle {
    private let shColor: SHColor
    
    public init(_ shColor: SHColor) {
        self.shColor = shColor
    }
    
    public func resolve(in environment: EnvironmentValues) -> Color {
        shColor.color
    }
}

extension ShapeStyle where Self == SHShapeStyle {
    public static func sh(_ shColor: SHColor) -> SHShapeStyle {
        SHShapeStyle(shColor)
    }
}

extension SHShapeStyle {
    public var gradient: AnyGradient {
        shColor.color.gradient
    }
}
