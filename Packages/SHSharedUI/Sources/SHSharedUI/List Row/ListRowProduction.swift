import SwiftUI
import SHModels
import SHUtils
import SHStorage

public struct ListRowProduction: View {
    private let production: Production
    private let showFactory: Bool
    private let accessory: ListRowAccessory?
    
    @Dependency(\.storageService)
    private var storageService
    
    public init(_ production: Production, showFactory: Bool, accessory: ListRowAccessory? = nil) {
        self.production = production
        self.showFactory = showFactory
        self.accessory = accessory
    }
    
    public var body: some View {
        ListRow {
            ListRowIconProduction(production)
        } label: {
            VStack(alignment: .leading, spacing: 4) {
                Text(production.name)
                
                if showFactory, let factory = storageService.factory(for: production) {
                    Text(factory.name)
                        .foregroundStyle(.secondary)
                        .font(.caption)
                }
            }
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
                        creationDate: Date(),
                        item: item,
                        amount: amount,
                        inputItems: [],
                        byproducts: []
                    )
                ),
                showFactory: false,
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
