import SwiftUI
import SingleItemCalculator
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
            List {
                adjustingSection
                
                pinnedSection
                
                unselectedSection
            }
            .listStyle(.plain)
            .safeAreaInset(edge: .top, spacing: 0) {
                VStack(alignment: .leading, spacing: 4) {
                    HStack(alignment: .firstTextBaseline) {
                        Text(viewModel.product.item.localizedName)
                            .font(.title3)
                        
                        Spacer()
                        
                        Text("single-item-production-adjustment-\(viewModel.product.amount.formatted(.shNumber))-per-minute")
                            .font(.headline)
                    }
                    
                    if let validationMessage = viewModel.validationMessage {
                        Text(validationMessage)
                            .font(.caption)
                            .foregroundStyle(.sh(.red))
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                }
                .animation(.default, value: viewModel.validationMessage == nil)
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
                    Button("general-cancel") {
                        dismiss()
                    }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("general-apply") {
                        viewModel.apply()
                        dismiss()
                    }
                    .disabled(viewModel.applyButtonDisabled)
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
                sectionContent(data: viewModel.selectedRecipes) { recipe in
                    RecipeAdjustmentView(viewModel: viewModel.recipeAdjustmentViewModel(recipe))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
            } else {
                Text("single-item-production-adjustment-no-recipes-for-**\(viewModel.product.item.localizedName)**")
                    .font(.title3)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 16)
                    .listRowSeparator(.hidden)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var pinnedSection: some View {
        if !viewModel.pinnedRecipes.isEmpty {
            Section {
                sectionContent(data: viewModel.pinnedRecipes) { pinnedRecipe in
                    Button {
                        withAnimation {
                            viewModel.addRecipe(pinnedRecipe)
                        }
                    } label: {
                        RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: pinnedRecipe))
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, 8)
                }
            } header: {
                SHSectionHeader("single-item-production-adjustment-pinned-recipes-section-name")
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
                sectionContent(data: viewModel.unselectedRecipes) { unselectedRecipe in
                    Button {
                        withAnimation {
                            viewModel.addRecipe(unselectedRecipe)
                        }
                    } label: {
                        RecipeDisplayView(viewModel: RecipeDisplayViewModel(recipe: unselectedRecipe))
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, 8)
                }
            } header: {
                SHSectionHeader("single-item-production-adjustment-unselected-recipes-section-name")
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
    private func sectionContent<Data: Identifiable, Content: View>(
        data: [Data],
        @ViewBuilder content: @escaping @MainActor (Data) -> Content
    ) -> some View {
        ForEach(Array(data.enumerated()), id: \.element.id) { index, element in
            VStack(spacing: 8) {
                content(element)
                
                if index != data.indices.last {
                    separator
                }
            }
            .id(element.id)
        }
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets())
    }
    
    @MainActor @ViewBuilder
    private var separator: some View {
        Rectangle()
            .fill(LinearGradient(
                colors: [.sh(.midnight40), .sh(.gray10)],
                startPoint: .leading,
                endPoint: UnitPoint(x: 0.85, y: 0.5)
            ))
            .padding(.leading, 16)
            .frame(height: 2 / displayScale)
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
                product: SingleItemCalculator.OutputItem(
                    item: item,
                    recipes: recipes.map { recipe in
                        SingleItemCalculator.OutputRecipe(
                            recipe: recipe,
                            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                item: recipe.output.item,
                                amount: recipe.amountPerMinute(for: recipe.output)
                            ),
                            byproducts: recipe.byproducts.map {
                                SingleItemCalculator.OutputRecipe.ByproductIngredient(
                                    item: $0.item,
                                    amount: recipe.amountPerMinute(for: $0),
                                    byproducts: [],
                                    isSelected: true
                                )
                            },
                            inputs: recipe.inputs.map {
                                SingleItemCalculator.OutputRecipe.InputIngredient(
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
