import SwiftUI
import SHModels

public struct ListRowFactory: View {
    private let factory: Factory
    private let accessory: ListRowAccessory?
    
    public init(_ factory: Factory, accessory: ListRowAccessory? = nil) {
        self.factory = factory
        self.accessory = accessory
    }
    
    public var body: some View {
        let icon = { ListRowIconFactory(factory) }
        let label = {
            VStack(alignment: .leading) {
                Text(factory.name)
                
                if !factory.productionIDs.isEmpty {
                    Text("factories-\(factory.productionIDs.count)-amount-of-produictions")
                        .font(.caption)
                        .foregroundStyle(.secondary)
                }
            }
        }
        
        if let accessory {
            ListRow(accessory: accessory, icon: icon, label: label)
        } else {
            ListRow(icon: icon, label: label)
        }
    }
}

#if DEBUG
#Preview("Factory rows") {
    List {
        Group {
            ListRowFactory(Factory(
                id: UUID(),
                name: "Legacy",
                asset: .legacy,
                productionIDs: []
            ))
            
            ListRowFactory(Factory(
                id: UUID(),
                name: "Abbreviated factory name",
                asset: .abbreviation,
                productionIDs: []
            ))
            
            ListRowFactory(Factory(
                id: UUID(),
                name: "Reinforced Iron Plate",
                asset: .assetCatalog(name: "part-reinforced-iron-plate"),
                productionIDs: []
            ))
            
            ListRowFactory(Factory(
                id: UUID(),
                name: "Modular Frame",
                asset: .assetCatalog(name: "part-modular-frame"),
                productionIDs: [UUID(), UUID()]
            ))
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    .listStyle(.plain)
}
#endif
