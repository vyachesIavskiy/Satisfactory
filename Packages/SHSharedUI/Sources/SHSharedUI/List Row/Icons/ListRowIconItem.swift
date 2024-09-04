import SwiftUI
import SHModels

public struct ListRowIconItem: View {
    private let item: any Item
    
    private var backgroundShape: ListRowIconBackgroundShape {
        switch (item as? Part)?.form {
        case .solid, nil:
            ListRowIconBackgroundShape.angledRectangle
            
        case .fluid, .gas:
            ListRowIconBackgroundShape.roundedRectangle
        }
    }
    
    public init(_ item: any Item) {
        self.item = item
    }
    
    public var body: some View {
        ListRowIcon(imageName: item.id, backgroundShape: backgroundShape)
    }
}

#if DEBUG
import SHStorage

#Preview("Item icons") {
    HStack {
        _ListRowIconItemPreview(itemID: "part-reinforced-iron-plate")
        
        _ListRowIconItemPreview(itemID: "part-crude-oil")
        
        _ListRowIconItemPreview(itemID: "equipment-boombox")
        
        _ListRowIconItemPreview(itemID: "building-assembler")
    }
}

private struct _ListRowIconItemPreview: View {
    private let item: any Item
    
    init(itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        item = storageService.item(id: itemID)!
    }
    
    var body: some View {
        ListRowIconItem(item)
    }
}
#endif
