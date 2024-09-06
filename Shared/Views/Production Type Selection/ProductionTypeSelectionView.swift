import SwiftUI
import SHModels

struct ProductionTypeSelectionView: View {
    @State
    private var viewModel = ProductionTypeSelectionViewModel()
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(viewModel.productionTypes) { productionType in
                    row(productionType)
                }
            }
            .listSectionSpacing(.compact)
            .navigationTitle("new-production-navigation-title")
            .navigationDestination(for: ProductionType.self) { productionType in
                switch productionType {
                case .singleItem:
                    SingleItemCalculatorItemSelectionView()
                    
                case .fromResources:
                    FromResourcesCalculatorItemsSelectionView()
                    
                case .power:
                    Text("Power")
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func row(_ productionTypeRow: ProductionTypeSelectionViewModel.ProductionTypeRow) -> some View {
        Section {
            NavigationLink(value: productionTypeRow.id) {
                HStack {
                    VStack(alignment: .leading, spacing: 12) {
                        VStack(alignment: .leading) {
                            Text(productionTypeRow.title)
                            
                            Text(productionTypeRow.description)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        
                        HStack(spacing: 16) {
                            ForEach(productionTypeRow.previewItemIDs, id: \.self) { id in
                                Image(id)
                                    .resizable()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .trailing)
                    }
                }
            }
        }
    }
}

#if DEBUG
#Preview("New production selection") {
    ProductionTypeSelectionView()
}
#endif
