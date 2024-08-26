import SwiftUI
import SHModels

struct ListRowIcon<Icon: View>: View {
    private let icon: Icon
    private let backgroundShape: BackgroundShape
    
    @Environment(\.displayScale)
    private var displayScale
    
    private var backgroundIconShape: AnyShape {
        switch backgroundShape {
        case .angledRectangle:
            AnyShape(AngledRectangle(cornerRadius: 5).inset(by: 1 / displayScale))
            
        case .roundedRectangle:
            AnyShape(UnevenRoundedRectangle(
                bottomLeadingRadius: 10,
                topTrailingRadius: 10
            ).inset(by: 1 / displayScale))
        }
    }
    
    var body: some View {
        icon
            .frame(width: 40, height: 40)
            .padding(6)
            .background {
                backgroundIconShape
                    .fill(.sh(.gray20))
                    .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
            }
    }
    
    init(backgroundShape: BackgroundShape, @ViewBuilder icon: () -> Icon) {
        self.icon = icon()
        self.backgroundShape = backgroundShape
    }
    
    init(imageName: String, backgroundShape: BackgroundShape) where Icon == Image {
        self.init(backgroundShape: backgroundShape) {
            Image(imageName)
                .resizable()
        }
    }
    
    init(item: some Item) where Icon == Image {
        let backgroundShape = switch (item as? Part)?.form {
        case .solid, nil:
            BackgroundShape.angledRectangle
            
        case .fluid, .gas:
            BackgroundShape.roundedRectangle
        }
        
        self.init(imageName: item.id, backgroundShape: backgroundShape)
    }
    
    init(production: Production) where Icon == Image {
        self.init(imageName: production.assetName, backgroundShape: .angledRectangle)
    }
    
    init(factory: Factory) where Icon == AnyView {
        self.init(backgroundShape: .angledRectangle) {
            AnyView(
                Group {
                    switch factory.asset {
                    case .abbreviation:
                        Text(factory.name.abbreviated())
                            .font(.title2)
                            .foregroundStyle(.sh(.midnight))
                        
                    case let .assetCatalog(name):
                        Image(name)
                            .resizable()
                        
                    case .legacy:
                        Image(systemName: "exclamationmark.triangle.fill")
                            .symbolRenderingMode(.multicolor)
                            .font(.title)
                    }
                }
            )
        }
    }
}

extension ListRowIcon {
    enum BackgroundShape {
        case angledRectangle
        case roundedRectangle
    }
}

#if DEBUG
import SHStorage

private struct _ListRowIconItemPreview: View {
    private let item: any Item
    
    init(itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        item = storageService.item(id: itemID)!
    }
    
    var body: some View {
        ListRowIcon(item: item)
    }
}

private struct _ListRowIconProductionPreview: View {
    private let item: any Item
    
    init(itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        item = storageService.item(id: itemID)!
    }
    
    var body: some View {
        ListRowIcon(production: Production.singleItem(SingleItemProduction(
            id: UUID(),
            name: item.localizedName,
            item: item,
            amount: 0
        )))
    }
}

private struct _ListRowIconFactoryPreview: View {
    private let asset: Asset
    
    init(asset: Asset) {
        self.asset = asset
    }
    
    var body: some View {
        ListRowIcon(factory: Factory(
            id: UUID(),
            name: "Preview Factory",
            asset: asset,
            productionIDs: []
        ))
    }
}

#Preview("Icons") {
    VStack {
        Text("Icons")
        
        HStack {
            ListRowIcon(imageName: "part-iron-plate", backgroundShape: .angledRectangle)
            
            ListRowIcon(imageName: "part-water", backgroundShape: .roundedRectangle)
        }
        
        Text("Items")
        
        HStack {
            _ListRowIconItemPreview(itemID: "part-reinforced-iron-plate")
            
            _ListRowIconItemPreview(itemID: "part-crude-oil")
        }
        
        Text("Productions")
        
        HStack {
            _ListRowIconProductionPreview(itemID: "part-modular-frame")
            
            _ListRowIconProductionPreview(itemID: "part-fuel")
        }
        
        Text("Factories")
        
        HStack {
            _ListRowIconFactoryPreview(asset: .legacy)
            
            _ListRowIconFactoryPreview(asset: .abbreviation)
            
            _ListRowIconFactoryPreview(asset: .assetCatalog(name: "part-fused-modular-frame"))
            
            _ListRowIconFactoryPreview(asset: .assetCatalog(name: "part-turbofuel"))
        }
    }
}
#endif
