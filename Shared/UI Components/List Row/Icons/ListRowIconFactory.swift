import SwiftUI
import SHModels

struct ListRowIconFactory: View {
    private let factory: Factory
    
    init(_ factory: Factory) {
        self.factory = factory
    }
    
    var body: some View {
        ListRowIcon(backgroundShape: .angledRectangle) {
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
    }
}

#if DEBUG
#Preview("Production icons") {
    HStack {
        _ListRowIconFactoryPreview(asset: .legacy)
        
        _ListRowIconFactoryPreview(asset: .abbreviation)
        
        _ListRowIconFactoryPreview(asset: .assetCatalog(name: "part-turbofuel"))
    }
}

private struct _ListRowIconFactoryPreview: View {
    private let factory: Factory
    
    init(asset: Asset) {
        factory = Factory(id: UUID(), name: "Preview Factory", asset: asset, productionIDs: [])
    }
    
    var body: some View {
        ListRowIconFactory(factory)
    }
}
#endif
