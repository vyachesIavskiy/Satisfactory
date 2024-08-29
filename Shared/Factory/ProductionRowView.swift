import SwiftUI
import SHModels

struct ProductionRowView: View {
    let production: Production
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        HStack(spacing: 12) {
            ListRowIconProduction(production)
            
            HStack {
                Text(production.name)
                
                Spacer()
                
                switch production {
                case let .singleItem(production):
                    Text(production.amount, format: .shNumber)
                    
                case .fromResources:
                    EmptyView()
                    
                case .power:
                    Text("Consumed power here")
                }
                
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
import SHStorage

private struct ProductionRowPreview: View {
    let itemID: String
    let amount: Double
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            ProductionRowView(production: .singleItem(
                SingleItemProduction(id: UUID(), name: "Preview production", item: item, amount: amount, inputItems: [], byproducts: [])
            ))
        } else {
            Text(verbatim: "There is no item with id '\(itemID)'")
        }
    }
}

#Preview {
    List {
        ProductionRowPreview(itemID: "part-reinforced-iron-plate", amount: 20)
            .listRowSeparator(.hidden)
    }
    .listStyle(.plain)
}
#endif
