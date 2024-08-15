import SwiftUI
import SHSingleItemProduction
import SHUtils

struct ProductAdjustmentView: View {
    @State
    var viewModel: ProductAdjustmentViewModel
    
    @Environment(\.dismiss)
    private var dismiss
    
    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        NavigationStack {
//            ScrollView {
//                LazyVStack(spacing: 24) {
//                    adjustingSection
//                    
//                    pinnedSection
//                    
//                    unselectedSection
//                }
//            }
            List {
                adjustingSection
                
                pinnedSection
                
                unselectedSection
            }
            .listStyle(.plain)
            .animation(.default, value: viewModel.selectedRecipes)
//            .animation(.default, value: viewModel.pinnedRecipes)
//            .animation(.default, value: viewModel.unselectedRecipes)
            .safeAreaInset(edge: .top, spacing: 0) {
                HStack(alignment: .firstTextBaseline) {
                    Text(viewModel.product.item.localizedName)
                        .font(.title3)
                    
                    Spacer()
                    
                    Text("\(viewModel.product.amount.formatted(.shNumber)) / min")
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
        .task {
            await viewModel.observePins()
        }
    }
    
    @MainActor @ViewBuilder
    private var adjustingSection: some View {
            Section {
                if !viewModel.selectedRecipes.isEmpty {
                    ForEach(Array(viewModel.selectedRecipes.enumerated()), id: \.element.id) { index, recipe in
                        VStack(spacing: 8) {
                            RecipeAdjustmentView(
                                viewModel: RecipeAdjustmentViewModel(
                                    recipe: recipe,
                                    numberOfRecipes: viewModel.selectedRecipes.count,
                                    allowAdjustment: viewModel.selectedRecipes.count > 1,
                                    allowDeletion: viewModel.allowDeletion || viewModel.selectedRecipes.count > 1
                                ) { [weak viewModel] proportion in
                                    viewModel?.updateRecipe(recipe, with: proportion)
                                } onDelete: { [weak viewModel] in
                                    viewModel?.removeRecipe(recipe)
                                }
                            )
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            
                            if index != viewModel.selectedRecipes.count - 1 {
                                Rectangle()
                                    .fill(.sh(.midnight))
                                    .frame(height: 1 / displayScale)
                                    .padding(.leading, 16)
                            }
                        }
                        .id(recipe.recipe.id)
                    }
                    .listRowSeparator(.hidden)
                    .listRowInsets(EdgeInsets())
                } else {
                    VStack(spacing: 24) {
                        Text("No selected recipes for \(viewModel.product.item.localizedName).")
                            .font(.title3)
                        
                        Text("Applying now will remove \(viewModel.product.item.localizedName) from calculation.")
                            .font(.subheadline)
                        
                        Rectangle()
                            .fill(.sh(.midnight))
                            .frame(height: 2 / displayScale)
                    }
                    
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(16)
                    .listRowSeparator(.hidden)
                }
            }
        
    }
    
    @MainActor @ViewBuilder
    private var pinnedSection: some View {
        if !viewModel.pinnedRecipes.isEmpty {
            Section {
                ForEach(Array(viewModel.pinnedRecipes.enumerated()), id: \.element.id) { index, pinnedRecipe in
                    VStack(spacing: 8) {
                        Button {
                            viewModel.addRecipe(pinnedRecipe)
                        } label: {
                            RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: pinnedRecipe))
                                .padding(.horizontal, 16)
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 8)
                        
                        if index != viewModel.pinnedRecipes.count - 1 {
                            Rectangle()
                                .fill(.sh(.midnight))
                                .frame(height: 1 / displayScale)
                                .padding(.leading, 16)
                        }
                    }
                    .id(pinnedRecipe.id)
                }
            } header: {
                Text("Pinned recipes")
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .background(.background)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
        }
    }
    
    @MainActor @ViewBuilder
    private var unselectedSection: some View {
        if !viewModel.unselectedRecipes.isEmpty {
            Section {
                ForEach(Array(viewModel.unselectedRecipes.enumerated()), id: \.element.id) { index, unselectedRecipe in
                    VStack(spacing: 8) {
                        Button {
                            viewModel.addRecipe(unselectedRecipe)
                        } label: {
                            RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: unselectedRecipe))
                                .padding(.horizontal, 16)
                        }
                        .buttonStyle(.plain)
                        .padding(.vertical, 8)
                        
                        if index != viewModel.unselectedRecipes.count - 1 {
                            Rectangle()
                                .fill(.sh(.midnight))
                                .frame(height: 1 / displayScale)
                                .padding(.leading, 16)
                        }
                    }
                    .id(unselectedRecipe.id)
                }
            } header: {
                Text("Unselected recipes")
                    .fontWeight(.medium)
                    .foregroundStyle(.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                    .padding(.bottom, 4)
                    .background(.background)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets())
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
        storageService.item(id: itemID)!
    }
    
    private var recipes: [Recipe] {
        recipeIDs.compactMap(storageService.recipe)
    }
    
    var body: some View {
        ProductAdjustmentView(
            viewModel: ProductAdjustmentViewModel(
                product: SHSingleItemProduction.OutputItem(
                    item: item,
                    recipes: recipes.map { recipe in
                        SHSingleItemProduction.OutputRecipe(
                            recipe: recipe,
                            output: SHSingleItemProduction.OutputRecipe.OutputIngredient(
                                item: recipe.output.item,
                                amount: recipe.amountPerMinute(for: recipe.output)
                            ),
                            byproducts: recipe.byproducts.map {
                                SHSingleItemProduction.OutputRecipe.ByproductIngredient(
                                    item: $0.item,
                                    amount: recipe.amountPerMinute(for: $0),
                                    byproducts: [],
                                    isSelected: true
                                )
                            },
                            inputs: recipe.inputs.map {
                                SHSingleItemProduction.OutputRecipe.InputIngredient(
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
