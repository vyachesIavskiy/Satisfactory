import SwiftUI

struct ProductionNewProductRecipeSelectionView: View {
    let viewModel: ProductionNewProductRecipeSelectionViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        NavigationStack {
            ScrollView {
                ItemRecipesView(viewModel: viewModel.itemRecipesViewModel)
            }
            .safeAreaInset(edge: .top) {
                Rectangle()
                    .foregroundStyle(.sh(.midnight))
                    .frame(height: 1 / displayScale)
                    .background(.background, ignoresSafeAreaEdges: .top)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
            .navigationTitle(viewModel.item.localizedName)
            .navigationBarTitleDisplayMode(.inline)
        }
//        .safeAreaInset(edge: .top) {
//            NavigationBar {
//                Text(viewModel.item.localizedName)
//                    .font(.title3)
//                    .frame(maxWidth: .infinity, alignment: .leading)
//            } buttons: {
//                HStack {
//                    Button("Cancel") {
//                        dismiss()
//                    }
//                    .buttonStyle(.shToolbar(role: .cancel))
//                    .frame(maxWidth: .infinity, alignment: .leading)
//                }
//            }
//        }
    }
}

#if DEBUG
import SHModels
import SHStorage

private struct _ProductionNewProductRecipeSelectionPreview: View {
    let itemID: String
    
    private var item: any Item {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(for: itemID)!
    }
    
    var body: some View {
        ProductionNewProductRecipeSelectionView(
            viewModel: ProductionNewProductRecipeSelectionViewModel(
                item: item,
                selectedRecipeIDs: [],
                onSelectRecipe: { _ in }
            )
        )
    }
}

#Preview {
    _ProductionNewProductRecipeSelectionPreview(itemID: "part-iron-plate")
}
#endif
