import CoreGraphics

extension CGRect {
    var topLeft: CGPoint { CGPoint(x: minX, y: minY) }
    var topRight: CGPoint { CGPoint(x: maxX, y: minY) }
    var bottomLeft: CGPoint { CGPoint(x: minX, y: maxY) }
    var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }
}
