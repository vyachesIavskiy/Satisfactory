import SwiftUI
import SHModels

struct ItemRowIcon: View {
    let item: any Item
    
    @Environment(\.displayScale)
    private var displayScale
    
    @ScaledMetric(relativeTo: .body)
    private var imageSize = 40.0
    
    @ScaledMetric(relativeTo: .body)
    private var paddingSize = 6.0
    
    @ScaledMetric(relativeTo: .body)
    private var cornerRadius = 5.0
    
    private var resolvedImageSize: Double {
        min(imageSize, 90)
    }
    
    private var resolvedPaddingSize: Double {
        min(paddingSize, 10)
    }
    
    private var resolvedCornerRadius: Double {
        min(cornerRadius, 10)
    }
    
    private var backgroundIconShape: AnyShape {
        switch (item as? Part)?.form {
        case .solid, nil:
            AnyShape(AngledRectangle(cornerRadius: resolvedCornerRadius).inset(by: 1 / displayScale))
            
        case .fluid, .gas:
            AnyShape(UnevenRoundedRectangle(
                bottomLeadingRadius: resolvedCornerRadius * 2,
                topTrailingRadius: resolvedCornerRadius * 2
            ).inset(by: 1 / displayScale))
        }
    }
    
    init(_ item: any Item) {
        self.item = item
    }
    
    var body: some View {
        Image(item.id)
            .resizable()
            .frame(width: resolvedImageSize, height: resolvedImageSize)
            .padding(resolvedPaddingSize)
            .background {
                backgroundIconShape
                    .fill(.sh(.gray20))
                    .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
            }
    }
}

#if DEBUG
import SHStorage

private struct _ItemRowPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            ItemRowIcon(item)
        } else {
            Text("There is no item with ID\n'\(itemID)'")
                .multilineTextAlignment(.center)
                .font(.title3)
                .padding()
        }
    }
}

#Preview("Iron Plate") {
    _ItemRowPreview(itemID: "part-iron-plate")
}

#Preview("Water") {
    _ItemRowPreview(itemID: "part-water")
}

#Preview("Portable miner") {
    _ItemRowPreview(itemID: "equipment-portable-miner")
}

#Preview("Constructor") {
    _ItemRowPreview(itemID: "building-constructor")
}
#endif