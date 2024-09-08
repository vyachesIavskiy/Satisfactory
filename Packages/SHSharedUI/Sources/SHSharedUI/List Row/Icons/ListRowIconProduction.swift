import SwiftUI
import SHModels

public struct ListRowIconProduction: View {
    private let production: Production
    
    public init(_ production: Production) {
        self.production = production
    }
    
    public var body: some View {
        ListRowIcon(imageName: production.assetName, backgroundShape: .angledRectangle)
    }
}

#if DEBUG
import SHStorage

#Preview("Production icons") {
    VStack {
        Text(verbatim: "Single item production")
        
        HStack {
            _ListRowIconSingleItemProductionPreview(itemID: "part-reinforced-iron-plate")
            
            _ListRowIconSingleItemProductionPreview(itemID: "part-crude-oil")
        }
        
        Text(verbatim: "From resources production")
        
        HStack {
            
        }
        
        Text(verbatim: "Power production")
        
        HStack {
            
        }
    }
}

private struct _ListRowIconSingleItemProductionPreview: View {
    private let production: Production
    
    init(itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        production = Production.singleItem(
            SingleItemProduction(
                id: UUID(),
                name: "",
                creationDate: Date(),
                item: storageService.item(id: itemID)!,
                amount: 0
            )
        )
    }
    
    var body: some View {
        ListRowIconProduction(production)
    }
}
#endif
