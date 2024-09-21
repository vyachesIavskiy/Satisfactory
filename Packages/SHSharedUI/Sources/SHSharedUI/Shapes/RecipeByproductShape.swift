import SwiftUI

public struct RecipeByproductShape: Shape {
    let lineWidth: CGFloat
    let spacing: CGFloat
    
    public init(lineWidth: CGFloat = 6, spacing: CGFloat = 9) {
        self.lineWidth = lineWidth
        self.spacing = spacing
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { path in
            guard rect.width > lineWidth || rect.height > lineWidth else {
                return
            }
            
            var subPaths = [SubPath]()
            var value = 0.0
            let bound = rect.width + rect.height
            
            while value < bound {
                let p1 = if value > rect.height {
                    CGPoint(x: value - rect.height, y: rect.height)
                } else {
                    CGPoint(x: 0.0, y: value)
                }
                
                let p2 = if value > rect.width {
                    CGPoint(x: rect.width, y: value - rect.width)
                } else {
                    CGPoint(x: value, y: 0.0)
                }
                
                let p3 = if value > rect.width || value + lineWidth > rect.width {
                    CGPoint(x: rect.width, y: min(value - rect.width + lineWidth, rect.height))
                } else {
                    CGPoint(x: value + lineWidth, y: 0.0)
                }
                
                let p4 = if value > rect.height || value + lineWidth > rect.height {
                    CGPoint(x: min(value - rect.height + lineWidth, rect.width), y: rect.height)
                } else {
                    CGPoint(x: 0.0, y: value + lineWidth)
                }
                
                subPaths.append(SubPath(
                    p1: p1,
                    p2: p2,
                    p3: p3,
                    p4: p4
                ))
                
                value += lineWidth + spacing
            }
            
            for subPath in subPaths {
                path.move(to: subPath.p1)
                path.addLine(to: subPath.p2)
                if subPath.p2.x < subPath.p3.x, subPath.p2.y < subPath.p3.y {
                    path.addLine(to: CGPoint(x: subPath.p3.x, y: subPath.p2.y))
                }
                path.addLine(to: subPath.p3)
                path.addLine(to: subPath.p4)
                if subPath.p4.x > subPath.p1.x, subPath.p4.y > subPath.p1.y {
                    path.addLine(to: CGPoint(x: subPath.p1.x, y: subPath.p4.y))
                }
            }
        }
    }
}

private extension RecipeByproductShape {
    struct SubPath {
        let p1: CGPoint
        let p2: CGPoint
        let p3: CGPoint
        let p4: CGPoint
    }
}

#if DEBUG
#Preview("Default") {
    RecipeByproductShape()
        .padding(20)
}
#endif
