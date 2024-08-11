import SwiftUI
import SHSingleItemProduction

struct ProductView: View {
    let viewModel: ProductViewModel
    
    private var nameID: String {
        if viewModel.product.recipes.count == 1 {
            "\(viewModel.product.recipes[0].id)_name"
        } else {
            "\(viewModel.product.item.id)_recipe_name"
        }
    }
    
    var body: some View {
        VStack {
            Section {
                ForEach(Array(viewModel.product.recipes.enumerated()), id: \.element.id) { index, outputRecipe in
                    VStack {
                        recipeView(outputRecipe)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        Divider()
                            .padding(.leading, 16)
                    }
                }
            } header: {
                titleView
                    .padding(.horizontal, 16)
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var titleView: some View {
        HStack {
            if viewModel.product.recipes.count > 1 {
                Text(viewModel.product.item.localizedName)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            } else {
                Text(viewModel.product.recipes[0].recipe.localizedName)
                    .font(.headline)
            }
            
            Spacer()
            
            if viewModel.canAdjust {
                if viewModel.hasOnlyOneRecipe {
                    Button {
                        viewModel.removeItem()
                    } label: {
                        Image(systemName: "trash")
                            .font(.caption)
                            .frame(height: 16)
                    }
                    .buttonStyle(.shTinted)
                    .tint(.sh(.red))
                } else {
                    Button {
                        viewModel.adjust()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.subheadline)
                            .frame(height: 16)
                    }
                    .buttonStyle(.shTinted)
                }
            }
        }
        .frame(minHeight: 24)
        .padding(.vertical, 8)
        .background(.background)
        .animation(.default, value: viewModel.canAdjust)
    }
    
    @MainActor @ViewBuilder
    private func recipeView(_ outputRecipe: SHSingleItemProduction.OutputRecipe) -> some View {
        VStack(alignment: .leading) {
            if viewModel.product.recipes.count > 1 {
                HStack {
                    Text(outputRecipe.recipe.localizedName)
                        .font(.headline)
                    
                    Spacer()
                    
                    Group {
                        switch outputRecipe.proportion {
                        case .auto:
                            Text("AUTO")
                            
                        case let .fraction(fraction):
                            Text(fraction, format: .shPercent)
                            
                        case .fixed:
                            Text("FIXED")
                        }
                    }
                    .font(.footnote)
                    .foregroundStyle(.secondary)
                }
            }
            
            SingleItemProductionRecipeSelectView(viewModel: viewModel.outputRecipeViewModel(for: outputRecipe))
        }
    }
}

#if DEBUG
import SHStorage
import SHModels

private struct _ProductPreview: View {
    let itemID: String
    let recipeIDs: [String]
    
    private var item: (any Item)? {
        @Dependency(\.storageService)
        var storageService
        
        return storageService.item(id: itemID)
    }
    
    private var outputRecipes: [SHSingleItemProduction.OutputRecipe] {
        @Dependency(\.storageService)
        var storageService
        
        return recipeIDs.compactMap {
            storageService.recipe(id: $0).map {
                SHSingleItemProduction.OutputRecipe(
                    recipe: $0,
                    output: SHSingleItemProduction.OutputRecipe.OutputIngredient(
                        item: $0.output.item,
                        amount: 20
                    ),
                    byproducts: $0.byproducts.map {
                        SHSingleItemProduction.OutputRecipe.ByproductIngredient(
                            item: $0.item,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        )
                    },
                    inputs: $0.inputs.map {
                        SHSingleItemProduction.OutputRecipe.InputIngredient(
                            item: $0.item,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        )
                    },
                    proportion: [
                        SHProductionProportion.auto,
                        .fraction(.random(in: 0...1)),
                        .fixed(.random(in: 1...100))
                    ].randomElement()!
                )
            }
        }
    }
    
    private var viewModel: ProductViewModel? {
        item.map {
            ProductViewModel(
                product: SHSingleItemProduction.OutputItem(item: $0, recipes: outputRecipes),
                selectedByproduct: nil,
                canPerformAction: { _ in true },
                performAction: { _ in }
            )
        }
    }
    
    var body: some View {
        if let viewModel {
            ScrollView {
                ProductView(viewModel: viewModel)
            }
        } else {
            Text("There is no item with ID '\(itemID)'")
                .font(.title3)
                .padding()
        }
    }
}

#Preview("Plastic, 1 recipe") {
    _ProductPreview(itemID: "part-plastic", recipeIDs: ["recipe-alternate-recycled-plastic"])
}

#Preview("Rubber, 2 recipes") {
    _ProductPreview(itemID: "part-rubber", recipeIDs: [
        "recipe-alternate-recycled-rubber",
        "recipe-rubber"
    ])
}

#Preview("Heavy Modular Frame, 3 recipes") {
    _ProductPreview(itemID: "part-heavy-modular-frame", recipeIDs: [
        "recipe-heavy-modular-frame",
        "recipe-alternate-heavy-encased-frame",
        "recipe-alternate-heavy-flexible-frame"
    ])
}
#endif
