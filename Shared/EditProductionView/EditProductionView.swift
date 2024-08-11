import SwiftUI
import SHStorage
import SHModels
import SHSingleItemProduction

@Observable
final class EditProductionViewModel {
    // MARK: Ignored properties
    @ObservationIgnored
    private let singleItemProduction: SHSingleItemProduction
    
    // MARK: Observed properties
    var productionName = ""
    var provideAssetImage = false {
        didSet {
            selectedAssetName = nil
        }
    }
    var selectedAssetName: String?
    
    var saveDisabled: Bool {
        productionName.isEmpty
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    init(singleItemProduction: SHSingleItemProduction) {
        self.singleItemProduction = singleItemProduction
    }
    
    func saveProduction() {
//        let assetType: Factory.AssetType = if provideAssetImage, let selectedAssetName {
//            .assetCatalog(name: selectedAssetName)
//        } else {
//            .abbreviation
//        }
        
        let production = Production(
            id: UUID(),
            name: productionName,
            item: singleItemProduction.item,
            amount: singleItemProduction.amount,
            inputItems: singleItemProduction.input.inputItems.map {
                Production.InputItem(item: $0.item, recipes: $0.recipes.map {
                    Production.InputRecipe(recipe: $0.recipe, proportion: $0.proportion)
                })
            },
            byproducts: singleItemProduction.input.byproducts.map {
                Production.InputByproduct(item: $0.item, producers: $0.producers.map {
                    Production.InputByproductProducer(recipe: $0.recipe, consumers: $0.consumers)
                })
            }
        )
        
        storageService.saveProduction(production)
    }
}

struct EditProductionView: View {
    @State
    private var viewModel: EditProductionViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.dismiss)
    private var dismiss
    
    init(singleItemProduction: SHSingleItemProduction) {
        _viewModel = State(initialValue: EditProductionViewModel(singleItemProduction: singleItemProduction))
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 4) {
                HStack(spacing: 18) {
                    iconView
                    
                    ZStack {
                        TextField("Production name", text: $viewModel.productionName)
                            .font(.largeTitle)
                        
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
                .padding(.horizontal, 20)
                .padding(.vertical, 32)
                
//                Toggle("Provide image", isOn: $viewModel.provideAssetImage)
//                    .font(.title3)
//                    .tint(.sh(.orange))
//                    .padding(.horizontal, 20)
//                
//                if viewModel.provideAssetImage {
//                    NewFactoryAssetCatalogView(selectedAssetName: $viewModel.selectedAssetName)
//                        .transition(.move(edge: .bottom).combined(with: .offset(y: 50)))
//                }
            }
            .frame(maxHeight: .infinity, alignment: .top)
            .animation(.spring.speed(2), value: viewModel.provideAssetImage)
            .navigationTitle("New production")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        viewModel.saveProduction()
                        dismiss()
                    }
                    .disabled(viewModel.saveDisabled)
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var iconView: some View {
        Group {
            if viewModel.provideAssetImage, let selectedAssetName = viewModel.selectedAssetName {
                Image(selectedAssetName)
                    .resizable()
            } else if !viewModel.productionName.isEmpty {
                Text(viewModel.productionName.abbreviated())
            } else {
                Image(systemName: "questionmark")
            }
        }
        .font(.title)
        .foregroundStyle(.sh(.midnight50))
        .frame(width: 60, height: 60)
        .padding(10)
        .background {
            AngledRectangle(cornerRadius: 8)
                .fill(.sh(.gray20))
                .stroke(.sh(.midnight40), lineWidth: 4 / displayScale)
        }
    }
}

#if DEBUG
private struct EditProductionPreview: View {
    let itemID: String
    
    @Dependency(\.storageService)
    private var storageService
    
    private var item: (any Item)? {
        storageService.item(id: itemID)
    }
    
    var body: some View {
        if let item {
            EditProductionView(singleItemProduction: SHSingleItemProduction(item: item))
        }
    }
}

#Preview {
    EditProductionPreview(itemID: "part-plastic")
}
#endif

