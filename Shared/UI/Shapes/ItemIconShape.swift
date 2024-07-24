import SwiftUI
import SHModels

struct ItemIconShape: Shape {
    let item: any Item
    let cornerRadius: Double
    let corners: AngledRectangle.Corner.Set
    private var inset = 0.0
    
    init(item: any Item, cornerRadius: Double, corners: AngledRectangle.Corner.Set = .diagonal) {
        self.item = item
        self.cornerRadius = cornerRadius
        self.corners = corners
    }
    
    var animatableData: AnimatablePair<Double, AnimatablePair<Double, Double>> {
        AnimatablePair(inset, AnimatablePair(cornerRadius, Double(corners.rawValue)))
    }
    
    func path(in rect: CGRect) -> Path {
        switch (item as? Part)?.form {
        case .solid, nil: solidPath(in: rect)
        case .fluid, .gas: fluidPath(in: rect)
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
    func inset(by amount: CGFloat) -> some InsettableShape {
        var copy = self
        copy.inset = amount
        return copy
    }
}

#if DEBUG
import SHStorage

private struct _ItemIconShapePreview: View {
    let itemID: String
    let cornerRadius: Double
    
    var item: (any Item)? {
        @Dependency(\.storageService) 
        var storageService
        
        return storageService.item(withID: itemID)
    }
    
    var body: some View {
        if let item {
            ItemIconShape(item: item, cornerRadius: cornerRadius)
                .padding(20)
        } else {
            Text("'\(itemID)' is not found")
        }
    }
}

#Preview("Iron plate") {
    _ItemIconShapePreview(itemID: "part-iron-plate", cornerRadius: 8)
}

#Preview("Water") {
    _ItemIconShapePreview(itemID: "part-water", cornerRadius: 12)
}

#Preview("Nitrogen Gas") {
    _ItemIconShapePreview(itemID: "part-nitrogen-gas", cornerRadius: 12)
}

#Preview("Portable Miner") {
    _ItemIconShapePreview(itemID: "part-portable-miner", cornerRadius: 8)
}
#endif
