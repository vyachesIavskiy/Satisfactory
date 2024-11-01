import CoreGraphics

extension CGPoint {
    public func offsetBy(x deltaX: CGFloat = 0, y deltaY: CGFloat = 0) -> CGPoint {
        CGPoint(x: x + deltaX, y: y + deltaY)
    }
}
