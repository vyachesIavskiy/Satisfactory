import SwiftUI
import SHModels

struct FactoryRowView: View {
    let factory: Factory
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        HStack(spacing: 12) {
            ListRowIcon(factory: factory)
            
            HStack {
                VStack(alignment: .leading) {
                    Text(factory.name)
                    
                    if !factory.productionIDs.isEmpty {
                        Text("factories-\(factory.productionIDs.count)-amount-of-produictions")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }
                }
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .fontWeight(.light)
                    .foregroundColor(.sh(.gray40))
            }
            .addListGradientSeparator()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

#if DEBUG
#Preview {
    List {
        Group {
            FactoryRowView(factory: Factory(
                id: UUID(),
                name: "Legacy",
                asset: .legacy,
                productionIDs: []
            ))
            
            FactoryRowView(factory: Factory(
                id: UUID(),
                name: "Abbreviated factory name",
                asset: .abbreviation,
                productionIDs: []
            ))
            
            FactoryRowView(factory: Factory(
                id: UUID(),
                name: "Reinforced Iron Plate",
                asset: .assetCatalog(name: "part-reinforced-iron-plate"),
                productionIDs: []
            ))
        }
        .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
}
#endif
