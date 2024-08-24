import SwiftUI

struct AngledRectangle: Shape {
    enum Corner: Int8, CaseIterable {
        case topLeft
        case topRight
        case bottomLeft
        case bottomRight
        
        struct Set: OptionSet {
            static let topLeft = Corner.Set(.topLeft)
            static let topRight = Corner.Set(.topRight)
            static let bottomLeft = Corner.Set(.bottomLeft)
            static let bottomRight = Corner.Set(.bottomRight)
            
            static let left: Corner.Set = [.topLeft, .bottomLeft]
            static let right: Corner.Set = [.topRight, .bottomRight]
            static let top: Corner.Set = [.topLeft, .topRight]
            static let bottom: Corner.Set = [.bottomLeft, .bottomRight]
            
            static let diagonal: Corner.Set = [
                .topRight,
                .bottomLeft
            ]
            
            static let reverseDiagonal: Corner.Set = [
                .topLeft,
                .bottomRight
            ]
            
            static let all: Corner.Set = [
                .topLeft,
                .topRight,
                .bottomLeft,
                .bottomRight
            ]
            
            var rawValue: Int8
            
            init(_ corner: Corner) {
                self.init(rawValue: 1 << corner.rawValue)
            }
            
            init(rawValue: Int8) {
                self.rawValue = rawValue
            }
        }
    }
    
    var cornerRadius: CGFloat
    var corners: Corner.Set
    
    private var inset: CGFloat = 0
    
    var layoutDirectionBehavior: LayoutDirectionBehavior {
        .mirrors
    }
    
    init(cornerRadius: CGFloat, corners: Corner.Set = .diagonal) {
        self.cornerRadius = cornerRadius
        self.corners = corners
    }
    
    func path(in rect: CGRect) -> Path {
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
    func inset(by amount: CGFloat) -> some InsettableShape {
        var result = self
        result.inset = amount
        return result
    }
}

struct AngledRectangle_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            AngledRectangle(cornerRadius: 10, corners: [])
                .previewDisplayName("None")
            
            AngledRectangle(cornerRadius: 10)
                .previewDisplayName("Diagonal")
            
            AngledRectangle(cornerRadius: 10, corners: .all)
                .previewDisplayName("All")
        }
        .padding()
        
        AngledRectangle(cornerRadius: 10, corners: []).inset(by: 16)
            .previewDisplayName("Inset None")
        AngledRectangle(cornerRadius: 10).inset(by: 16)
            .previewDisplayName("Inset Diagonal")
        AngledRectangle(cornerRadius: 10, corners: .all).inset(by: 16)
            .previewDisplayName("Inset All")
    }
}
