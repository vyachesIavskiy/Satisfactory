import SwiftUI
import SHModels

struct RecipeItemAmountShape: Shape {
    let part: Part
    let cornerRadius: Double
    private var inset: CGFloat = 0
    
    init(part: Part, cornerRadius: Double) {
        self.part = part
        self.cornerRadius = cornerRadius
    }
    
    func path(in rect: CGRect) -> Path {
        switch part.form {
        case .solid: solidPath(in: rect)
        case .fluid, .gas, .matter: fluidPath(in: rect)
        }
    }
    
    private func solidPath(in rect: CGRect) -> Path {
        Path { p in
            // Top left
            p.move(to: rect.topLeft.offsetBy(x: inset, y: inset))
            p.addLine(to: rect.topLeft.offsetBy(x: inset + cornerRadius, y: inset + cornerRadius))
            
            // Top right
            p.addLine(to: rect.topRight.offsetBy(x: -inset, y: inset + cornerRadius))
            
            // Bottom right
            p.addLine(to: rect.bottomRight.offsetBy(x: -inset, y: -inset))
            
            // Bottom left
            p.addLine(to: rect.bottomLeft.offsetBy(x: inset + cornerRadius, y: -inset))
            p.addLine(to: rect.bottomLeft.offsetBy(x: inset, y: -inset - cornerRadius))
            
            p.closeSubpath()
        }
    }
    
    private func fluidPath(in rect: CGRect) -> Path {
        Path { p in
            // Top left
            p.move(to: rect.topLeft.offsetBy(x: inset, y: inset))
            p.addRelativeArc(
                center: rect.topLeft.offsetBy(x: inset + cornerRadius, y: inset),
                radius: cornerRadius,
                startAngle: .degrees(180),
                delta: .degrees(-90)
            )
            
            // Top right
            p.addLine(to: rect.topRight.offsetBy(x: -inset, y: inset + cornerRadius))
            
            // Bottom right
            p.addLine(to: rect.bottomRight.offsetBy(x: -inset, y: -inset))
            
            // Bottom left
            p.addLine(to: rect.bottomLeft.offsetBy(x: inset + cornerRadius, y: -inset))
            p.addRelativeArc(
                center: rect.bottomLeft.offsetBy(x: inset + cornerRadius, y: -inset - cornerRadius),
                radius: cornerRadius,
                startAngle: .degrees(90),
                delta: .degrees(90)
            )
            
            p.closeSubpath()
        }
    }
}

extension RecipeItemAmountShape: InsettableShape {
    func inset(by amount: CGFloat) -> some InsettableShape {
        var result = self
        result.inset = amount
        return result
    }
}

#if DEBUG
// Add previews
#endif
