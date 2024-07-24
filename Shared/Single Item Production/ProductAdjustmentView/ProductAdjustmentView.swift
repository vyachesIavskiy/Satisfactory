import SwiftUI

struct ProductAdjustmentView: View {
    @Bindable
    var viewModel: ProductAdjustmentViewModel
    
    @State
    private var productionRecipesExpanded = true
        
    @State
    private var unselectedRecipesExpanded = true
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Namespace
    private var namespace
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(spacing: 16) {
                    adjustingSection
                    
                    unselectedSection
                }
            }
            .safeAreaInset(edge: .top) {
                HStack(alignment: .firstTextBaseline) {
                    Text(viewModel.product.item.localizedName)
                        .font(.title3)
                    
                    Spacer()
                    
                    Text("\(viewModel.product.amount.formatted(.fractionFromZeroToFour)) / min")
                        .font(.headline)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 8)
                .overlay(alignment: .bottom) {
                    Rectangle()
                        .frame(height: 1 / displayScale)
                        .foregroundStyle(.sh(.midnight))
                }
                .background(.background, ignoresSafeAreaEdges: .top)
            }
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Apply") {
                        viewModel.apply()
                        dismiss()
                    }
                }
            }
            .toolbarBackground(.hidden, for: .navigationBar)
        }
    }
    
    @MainActor @ViewBuilder
    private var adjustingSection: some View {
        if !viewModel.selectedRecipes.isEmpty {
            Section(isExpanded: $productionRecipesExpanded) {
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
            } header: {
                SHSectionHeader("Production recipes", expanded: $productionRecipesExpanded)
            }
            .padding(.horizontal, 16)
        }
    }
    
    @MainActor @ViewBuilder
    private var unselectedSection: some View {
        if viewModel.hasUnselectedRecipes {
            Section(isExpanded: $unselectedRecipesExpanded) {
                SingleItemProductionInitialRecipeSelectionView(viewModel: viewModel.unselectedItemRecipesViewModel)
            } header: {
                SHSectionHeader("Unselected recipes", expanded: $unselectedRecipesExpanded)
                    .padding(.horizontal, 16)
            }
        }
    }
}

#if DEBUG
import SHModels
import SHStorage

private struct _ProductAdjustmentPreview: View {
    let itemID: String
    let recipeIDs: [String]
    
    @Dependency(\.storageService)
    var storageService
    
    private var item: any Item {
        storageService.item(withID: itemID)!
    }
    
    private var recipes: [Recipe] {
        recipeIDs.compactMap(storageService.recipe)
    }
    
    var body: some View {
        ProductAdjustmentView(
            viewModel: ProductAdjustmentViewModel(
                product: SingleItemProduction.Output.Product(
                    item: item,
                    recipes: recipes.map { recipe in
                        SingleItemProduction.Output.Recipe(
                            model: recipe,
                            output: SingleItemProduction.Output.Recipe.OutputIngredient(
                                item: recipe.output.item,
                                amount: recipe.amountPerMinute(for: recipe.output),
                                byproducts: [],
                                isSelected: true
                            ),
                            byproducts: recipe.byproducts.map {
                                SingleItemProduction.Output.Recipe.OutputIngredient(
                                    item: $0.item,
                                    amount: recipe.amountPerMinute(for: $0),
                                    byproducts: [],
                                    isSelected: true
                                )
                            },
                            inputs: recipe.input.map {
                                SingleItemProduction.Output.Recipe.InputIngredient(
                                    item: $0.item,
                                    amount: recipe.amountPerMinute(for: $0),
                                    byproducts: [],
                                    isSelected: true
                                )
                            },
                            proportion: .auto
                        )
                    }
                ),
                allowDeletion: true,
                onApply: {
                    _ in
                }
            )
        )
    }
}

#Preview("Iron Plate") {
    _ProductAdjustmentPreview(itemID: "part-iron-plate", recipeIDs: ["recipe-iron-plate"])
}

#Preview("Reinforced Iron Plate") {
    _ProductAdjustmentPreview(
        itemID: "part-reinforced-iron-plate",
        recipeIDs: [
            "recipe-reinforced-iron-plate",
            "recipe-alternate-bolted-iron-plate"
        ]
    )
}

#Preview("Plastic") {
    _ProductAdjustmentPreview(itemID: "part-plastic", recipeIDs: ["recipe-alternate-recycled-plastic"])
}

#Preview("Heavy Modular Frame") {
    _ProductAdjustmentPreview(itemID: "part-heavy-modular-frame", recipeIDs: ["recipe-heavy-modular-frame"])
}
#endif
