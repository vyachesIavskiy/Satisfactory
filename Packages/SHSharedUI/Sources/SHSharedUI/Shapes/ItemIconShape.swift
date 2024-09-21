import SwiftUI
import SHModels

public struct ItemIconShape: Shape {
    private let part: Part
    private let cornerRadius: Double
    private let corners: AngledRectangle.Corner.Set
    private var inset = 0.0
    
    public init(part: Part, cornerRadius: Double, corners: AngledRectangle.Corner.Set = .diagonal) {
        self.part = part
        self.cornerRadius = cornerRadius
        self.corners = corners
    }
    
    public var animatableData: AnimatablePair<Double, AnimatablePair<Double, Double>> {
        AnimatablePair(inset, AnimatablePair(cornerRadius, Double(corners.rawValue)))
    }
    
    public func path(in rect: CGRect) -> Path {
        switch part.form {
        case .solid: solidPath(in: rect)
        case .fluid, .gas, .matter: fluidPath(in: rect)
        }
    }
    
    private func solidPath(in rect: CGRect) -> Path {
        AngledRectangle(cornerRadius: cornerRadius, corners: corners)
            .inset(by: inset)
            .path(in: rect)
    }
    
    private func fluidPath(in rect: CGRect) -> Path {
        UnevenRoundedRectangle(
            topLeadingRadius: corners.contains(.topLeft) ? cornerRadius : 0,
            bottomLeadingRadius: corners.contains(.bottomLeft) ? cornerRadius : 0,
            bottomTrailingRadius: corners.contains(.bottomRight) ? cornerRadius : 0,
            topTrailingRadius: corners.contains(.topRight) ? cornerRadius : 0
        )
        .inset(by: inset)
        .path(in: rect)
    }
}

extension ItemIconShape: InsettableShape {
    public func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.inset = amount
        return copy
    }
}

#if DEBUG
import SHStorage

private struct _ItemIconShapePreview: View {
    let partID: String
    let cornerRadius: Double
    
    var part: Part? {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.part(id: partID)
    }
    
    var body: some View {
        if let part {
            ItemIconShape(part: part, cornerRadius: cornerRadius)
                .padding(20)
        } else {
            Text(verbatim: "'\(partID)' is not found")
        }
    }
}

#Preview("Iron plate") {
    _ItemIconShapePreview(partID: "part-iron-plate", cornerRadius: 8)
}

#Preview("Water") {
    _ItemIconShapePreview(partID: "part-water", cornerRadius: 12)
}

#Preview("Nitrogen Gas") {
    _ItemIconShapePreview(partID: "part-nitrogen-gas", cornerRadius: 12)
}

#Preview("Portable Miner") {
    _ItemIconShapePreview(partID: "part-portable-miner", cornerRadius: 8)
}
#endif
