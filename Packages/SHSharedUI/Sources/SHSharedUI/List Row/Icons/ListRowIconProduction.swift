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
            _ListRowIconSingleItemProductionPreview(partID: "part-reinforced-iron-plate")
            
            _ListRowIconSingleItemProductionPreview(partID: "part-crude-oil")
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
    
    init(partID: String) {
        @Dependency(\.storageService)
        var storageService
        
        production = Production(
            id: UUID(),
            name: "",
            creationDate: Date(),
            assetName: partID,
            content: .singleItem(Production.Content.SingleItem(
                part: storageService.part(id: partID)!,
                amount: 10
            ))
        )
    }
    
    var body: some View {
        ListRowIconProduction(production)
    }
}
#endif
