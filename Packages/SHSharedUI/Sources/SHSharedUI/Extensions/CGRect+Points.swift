import CoreGraphics

extension CGRect {
    public var topLeft: CGPoint { CGPoint(x: minX, y: minY) }
    public var topRight: CGPoint { CGPoint(x: maxX, y: minY) }
    public var bottomLeft: CGPoint { CGPoint(x: minX, y: maxY) }
    public var bottomRight: CGPoint { CGPoint(x: maxX, y: maxY) }
    public var topCenter: CGPoint { CGPoint(x: midX, y: minY) }
    public var bottomCenter: CGPoint { CGPoint(x: midX, y: maxY) }
    public var centerLeft: CGPoint { CGPoint(x: minX, y: midY) }
    public var centerRight: CGPoint { CGPoint(x: maxX, y: midY) }
}
