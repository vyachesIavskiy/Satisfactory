import SwiftUI
import SHModels

struct ProductionRowView: View {
    let production: Production
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        HStack(spacing: 12) {
            iconView
            
            ZStack {
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
                
                LinearGradient(
                    colors: [.sh(.midnight40), .sh(.gray10)],
                    startPoint: .leading,
                    endPoint: UnitPoint(x: 0.85, y: 0.5)
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    @MainActor @ViewBuilder
    private var iconView: some View {
        ZStack {
            switch production.asset {
            case .legacy:
                // This should never happen
                EmptyView()
                
            case .abbreviation:
                Text(production.name.abbreviated())
                
            case let .assetCatalog(name):
                Image(name)
                    .resizable()
            }
        }
        .frame(width: 40, height: 40)
        .padding(6)
        .background {
            AngledRectangle(cornerRadius: 5)
                .fill(.sh(.gray20))
                .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
        }
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
            Text("There is no item with id '\(itemID)'")
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
