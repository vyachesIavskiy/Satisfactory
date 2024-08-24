import SwiftUI
import SHModels

struct FactoryRowView: View {
    let factory: Factory
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        HStack(spacing: 12) {
            iconView
            
            ZStack {
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
