import SwiftUI
import TipKit
import SHSharedUI
import SHSingleItemCalculator
import SHUtils

struct SingleItemCalculatorItemAdjustmentView: View {
    @State
    var viewModel: SingleItemCalculatorItemAdjustmentViewModel
    
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
                        Text(viewModel.part.part.localizedName)
                            .font(.title3)
                        
                        Spacer()
                        
                        Text("single-item-production-adjustment-\(viewModel.part.amount.formatted(.shNumber()))-per-minute")
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
            #if os(iOS)
            .toolbarBackground(.hidden, for: .navigationBar)
            #endif
        }
        .task {
            await viewModel.observePins()
        }
    }
    
    @MainActor @ViewBuilder
    private var adjustingSection: some View {
        Section {
            if !viewModel.selectedRecipes.isEmpty {
                sectionContent(data: viewModel.selectedRecipes) { index, recipe in
                    RecipeAdjustmentView(viewModel: viewModel.recipeAdjustmentViewModel(recipe: recipe, index: index))
                        .padding(.vertical, 8)
                        .padding(.horizontal, 16)
                }
            } else {
                Text("single-item-production-adjustment-no-recipes-for-**\(viewModel.part.part.localizedName)**")
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
                addMoreRecipesTipView
                
                sectionContent(data: viewModel.pinnedRecipes) { _, pinnedRecipe in
                    Button {
                        withAnimation {
                            viewModel.addRecipe(pinnedRecipe)
                        }
                    } label: {
                        RecipeView(pinnedRecipe)
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, 8)
                }
            } header: {
                SectionHeader("single-item-production-adjustment-pinned-recipes-section-name")
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
                if viewModel.pinnedRecipes.isEmpty {
                    addMoreRecipesTipView
                }
                
                sectionContent(data: viewModel.unselectedRecipes) { _, unselectedRecipe in
                    Button {
                        withAnimation {
                            viewModel.addRecipe(unselectedRecipe)
                        }
                    } label: {
                        RecipeView(unselectedRecipe)
                            .padding(.horizontal, 16)
                    }
                    .buttonStyle(.plain)
                    .padding(.vertical, 8)
                }
            } header: {
                SectionHeader("single-item-production-adjustment-unselected-recipes-section-name")
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
        @ViewBuilder content: @escaping @MainActor (Int, Data) -> Content
    ) -> some View {
        ForEach(Array(data.enumerated()), id: \.element.id) { index, element in
            VStack(spacing: 8) {
                content(index, element)
                
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
                colors: [.sh(.midnight60), .sh(.midnight30)],
                startPoint: .leading,
                endPoint: .trailing
            ))
            .padding(.leading, 16)
            .frame(height: 2 / displayScale)
    }
    
    @ViewBuilder
    private var addMoreRecipesTipView: some View {
        TipView(viewModel.addMoreRecipesTip)
            .listSectionSeparator(.hidden)
            .listRowSeparator(.hidden)
            .listRowInsets(EdgeInsets(top: 4, leading: 16, bottom: 4, trailing: 16))
    }
}

#if DEBUG
import SHModels
import SHStorage

private struct _SingleItemCalculatorItemAdjustmentPreview: View {
    let partID: String
    let recipeIDs: [String]
    
    @Dependency(\.storageService)
    var storageService
    
    private var part: Part {
        storageService.part(id: partID)!
    }
    
    private var recipes: [Recipe] {
        recipeIDs.compactMap(storageService.recipe)
    }
    
    var body: some View {
        SingleItemCalculatorItemAdjustmentView(
            viewModel: SingleItemCalculatorItemAdjustmentViewModel(
                part: SingleItemCalculator.OutputPart(
                    part: part,
                    recipes: recipes.map { recipe in
                        SingleItemCalculator.OutputRecipe(
                            recipe: recipe,
                            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                part: recipe.output.part,
                                amount: recipe.amountPerMinute(for: recipe.output)
                            ),
                            byproducts: recipe.byproducts.map {
                                SingleItemCalculator.OutputRecipe.ByproductIngredient(
                                    part: $0.part,
                                    amount: recipe.amountPerMinute(for: $0),
                                    byproducts: [],
                                    isSelected: true
                                )
                            },
                            inputs: recipe.inputs.map {
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    part: $0.part,
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
    _SingleItemCalculatorItemAdjustmentPreview(partID: "part-iron-plate", recipeIDs: ["recipe-iron-plate"])
}

#Preview("Reinforced Iron Plate") {
    _SingleItemCalculatorItemAdjustmentPreview(
        partID: "part-reinforced-iron-plate",
        recipeIDs: [
            "recipe-reinforced-iron-plate",
            "recipe-alternate-bolted-iron-plate"
        ]
    )
}

#Preview("Plastic") {
    _SingleItemCalculatorItemAdjustmentPreview(partID: "part-plastic", recipeIDs: ["recipe-alternate-recycled-plastic"])
}

#Preview("Heavy Modular Frame") {
    _SingleItemCalculatorItemAdjustmentPreview(partID: "part-heavy-modular-frame", recipeIDs: ["recipe-heavy-modular-frame"])
}
#endif
