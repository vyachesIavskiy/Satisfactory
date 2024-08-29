import SwiftUI
import SHModels

struct ListRowProduction: View {
    private let production: Production
    private let accessory: ListRowAccessory?
    
    init(_ production: Production, accessory: ListRowAccessory? = nil) {
        self.production = production
        self.accessory = accessory
    }
    
    var body: some View {
        ListRow {
            ListRowIconProduction(production)
        } label: {
            Text(production.name)
        } accessory: {
            productionAccessory
            
            if let accessory {
                accessory.view
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var productionAccessory: some View {
        switch production {
        case let .singleItem(production):
            Text(production.amount, format: .shNumber)
            
        case .fromResources:
            EmptyView()
            
        case .power:
            Text("Consumed power here")
        }
    }
}

#if DEBUG
import SHStorage

private struct ProductionRowPreview: View {
    let itemID: String
    let amount: Double
    let accessory: ListRowAccessory?
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            ListRowProduction(
                .singleItem(
                    SingleItemProduction(
                        id: UUID(),
                        name: "Preview production",
                        item: item,
                        amount: amount,
                        inputItems: [],
                        byproducts: []
                    )
                ),
                accessory: accessory
            )
        } else {
            Text(verbatim: "There is no item with id '\(itemID)'")
        }
    }
}

#Preview {
    List {
        Group {
            ProductionRowPreview(itemID: "part-reinforced-iron-plate", amount: 20, accessory: nil)
            ProductionRowPreview(itemID: "part-modular-frame", amount: 45, accessory: .chevron)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    .listStyle(.plain)
}
#endif
