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
        switch production.content {
        case let .singleItem(production):
            Text(production.amount, format: .shNumber())
            
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
    let partID: String
    let amount: Double
    let accessory: ListRowAccessory?
    
    @Dependency(\.storageService)
    private var storageService
    
    private var part: Part? {
        storageService.part(id: partID)
    }
    
    var body: some View {
        if let part {
            ListRowProduction(
                Production(
                    id: UUID(),
                    name: "Preview production",
                    creationDate: Date(),
                    assetName: part.id,
                    content: .singleItem(
                        Production.Content.SingleItem(
                            part: part,
                            amount: amount,
                            inputParts: [],
                            byproducts: []
                        )
                    )
                ),
                showFactory: false,
                accessory: accessory
            )
        } else {
            Text(verbatim: "There is no item with id '\(partID)'")
        }
    }
}

#Preview {
    List {
        Group {
            ProductionRowPreview(partID: "part-reinforced-iron-plate", amount: 20, accessory: nil)
            ProductionRowPreview(partID: "part-modular-frame", amount: 45, accessory: .chevron)
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    .listStyle(.plain)
}
#endif
