import SwiftUI

struct ProductAdjustmentView: View {
    @Bindable
    var viewModel: ProductAdjustmentViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Namespace
    private var namespace
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 16) {
                adjustingSection
                
                unselectedSection
            }
            .padding(16)
        }
        .safeAreaInset(edge: .top) {
            navigationBar
        }
    }
    
    @MainActor @ViewBuilder
    private var adjustingSection: some View {
        ForEach(viewModel.selectedRecipes) { recipe in
            RecipeAdjustmentView(
                viewModel: RecipeAdjustmentViewModel(
                    recipe: recipe,
                    allowAdjustment: viewModel.selectedRecipes.count > 1,
                    allowDeletion: viewModel.allowDeletion || viewModel.selectedRecipes.count > 1
                ) {
                    [weak viewModel] proportion in
                    viewModel?.updateRecipe(recipe, with: proportion)
                } onDelete: { [weak viewModel] in
                    viewModel?.removeRecipe(recipe)
                }
            )
        }
    }
    
    @MainActor @ViewBuilder
    private var unselectedSection: some View {
        if !viewModel.unselectedRecipes.isEmpty {
            Section {
                ForEach(viewModel.unselectedRecipes) { recipe in
                    Button {
                        viewModel.addRecipe(recipe)
                    } label: {
                        RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: recipe))
                    }
                    .buttonStyle(.plain)
                }
            } header: {
                Text("Unselected recipes")
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var navigationBar: some View {
        NavigationBar {
            HStack(alignment: .firstTextBaseline) {
                Text(viewModel.product.item.localizedName)
                    .font(.title3)
                
                Spacer()
                
                Text("\(viewModel.product.amount.formatted(.fractionFromZeroToFour)) / min")
                    .font(.headline)
            }
        } buttons: {
            HStack {
                Button("Cancel", role: .cancel) {
                    dismiss()
                }
                .buttonStyle(.toolbar(role: .cancel))
                
                Spacer()
                
                Button("Apply") {
                    viewModel.apply()
                    dismiss()
                }
                .buttonStyle(.toolbar(role: .confirm))
            }
        }
    }
}
