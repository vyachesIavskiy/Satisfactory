import SwiftUI
import SHSingleItemCalculatorUI

struct ProductionTypeSelectionView: View {
    @State
    private var viewModel = ProductionTypeSelectionViewModel()
    
    var body: some View {
        NavigationStack(path: $viewModel.navigationPath) {
            List {
                ForEach(viewModel.productionTypes) { productionType in
                    row(productionType)
                }
            }
            .listSectionSpacing(.compact)
            .navigationTitle("new-production-navigation-title")
            .navigationDestination(for: ProductionTypeSelectionViewModel.NavigationPath.self) { path in
                switch path {
                case let .productionType(productionType):
                    SHSingleItemCalculator.itemSelection(itemSelected: viewModel.singeItemSelected)
                    
                case let .production(productionType, item):
                    switch productionType {
                    case .singleItem:
                        SHSingleItemCalculator.newProduction(item)
                        
                    case .fromResources:
                        Text("From resources production view")
                        
                    case .power:
                        Text("Power production view")
                    }
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private func row(_ productionTypeRow: ProductionTypeSelectionViewModel.ProductionTypeRow) -> some View {
        Section {
            NavigationLink(value: ProductionTypeSelectionViewModel.NavigationPath.productionType(productionTypeRow.id)) {
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
