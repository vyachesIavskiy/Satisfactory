import SwiftUI

public struct AngledRectangle: Shape {
    public enum Corner: Int8, CaseIterable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        
        public struct Set: OptionSet, Sendable {
            public static let topLeft = Corner.Set(.topLeft)
            public static let topRight = Corner.Set(.topRight)
            public static let bottomLeft = Corner.Set(.bottomLeft)
            public static let bottomRight = Corner.Set(.bottomRight)
            
            public static let left: Corner.Set = [.topLeft, .bottomLeft]
            public static let right: Corner.Set = [.topRight, .bottomRight]
            public static let top: Corner.Set = [.topLeft, .topRight]
            public static let bottom: Corner.Set = [.bottomLeft, .bottomRight]
            
            public static let diagonal: Corner.Set = [
                .topRight,
                .bottomLeft
            ]
            
            public static let reverseDiagonal: Corner.Set = [
                .topLeft,
                .bottomRight
            ]
            
            public static let all: Corner.Set = [
                .topLeft,
                .topRight,
                .bottomLeft,
                .bottomRight
            ]
            
            public var rawValue: Int8
            
            public init(_ corner: Corner) {
                self.init(rawValue: 1 << corner.rawValue)
            }
            
            public init(rawValue: Int8) {
                self.rawValue = rawValue
            }
        }
    }
    
    private var cornerRadius: CGFloat
    private var corners: Corner.Set
    
    private var inset: CGFloat = 0
    
    public var layoutDirectionBehavior: LayoutDirectionBehavior {
        .mirrors
    }
    
    public init(cornerRadius: CGFloat, corners: Corner.Set = .diagonal) {
        self.cornerRadius = cornerRadius
        self.corners = corners
    }
    
    public func path(in rect: CGRect) -> Path {
        Path { p in
            // Top left
            if corners.contains(.topLeft) {
                p.move(to: rect.topLeft.offsetBy(x: inset, y: inset + cornerRadius))
                p.addLine(to: rect.topLeft.offsetBy(x: inset + cornerRadius, y: inset))
            } else {
                p.move(to: rect.topLeft.offsetBy(x: inset, y: inset))
            }
            
            // Top right
            if corners.contains(.topRight) {
                p.addLine(to: rect.topRight.offsetBy(x: -inset - cornerRadius, y: inset))
                p.addLine(to: rect.topRight.offsetBy(x: -inset, y: inset + cornerRadius))
            } else {
                p.addLine(to: rect.topRight.offsetBy(x: -inset, y: inset))
            }
            
            // Bottom right
            if corners.contains(.bottomRight) {
                p.addLine(to: rect.bottomRight.offsetBy(x: -inset, y: -inset - cornerRadius))
                p.addLine(to: rect.bottomRight.offsetBy(x: -inset - cornerRadius, y: -inset))
            } else {
                p.addLine(to: rect.bottomRight.offsetBy(x: -inset, y: -inset))
            }
            
            // Bottom left
            if corners.contains(.bottomLeft) {
                p.addLine(to: rect.bottomLeft.offsetBy(x: inset + cornerRadius, y: -inset))
                p.addLine(to: rect.bottomLeft.offsetBy(x: inset, y: -inset - cornerRadius))
            } else {
                p.addLine(to: rect.bottomLeft.offsetBy(x: inset, y: -inset))
            }
            
            p.closeSubpath()
        }
    }
}

extension AngledRectangle: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var result = self
        result.inset = amount
        return result
    }
}

#if DEBUG
#Preview("None") {
    AngledRectangle(cornerRadius: 10, corners: [])
        .padding()
}

#Preview("Diagonal") {
    AngledRectangle(cornerRadius: 10)
        .padding()
}

#Preview("All") {
    AngledRectangle(cornerRadius: 10, corners: .all)
        .padding()
}

#Preview("Inset None") {
    AngledRectangle(cornerRadius: 10, corners: []).inset(by: 16)
        .padding()
}

#Preview("Inset Diagonal") {
    AngledRectangle(cornerRadius: 10).inset(by: 16)
        .padding()
}

#Preview("Inset All") {
    AngledRectangle(cornerRadius: 10, corners: .all).inset(by: 16)
        .padding()
}
#endif
