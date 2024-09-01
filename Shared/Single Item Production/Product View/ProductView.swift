import SwiftUI
import SingleItemCalculator

struct ProductView: View {
    @Environment(\.displayScale)
    private var displayScale
    
    let viewModel: ProductViewModel
    
    var body: some View {
        VStack {
            Section {
                ForEach(Array(viewModel.product.recipes.enumerated()), id: \.element.id) { index, outputRecipe in
                    VStack(spacing: 8) {
                        recipeView(outputRecipe)
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                        
                        if index != viewModel.product.recipes.indices.last {
                            Rectangle()
                                .fill(LinearGradient(
                                    colors: [.sh(.midnight40), .sh(.gray10)],
                                    startPoint: .leading,
                                    endPoint: UnitPoint(x: 0.85, y: 0.5)
                                ))
                                .frame(height: 2 / displayScale)
                                .padding(.leading, 16)
                        }
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
                    .buttonStyle(.shBordered)
                    .tint(.sh(.red))
                } else {
                    Button {
                        viewModel.adjust()
                    } label: {
                        Image(systemName: "slider.horizontal.3")
                            .font(.subheadline)
                            .frame(height: 16)
                    }
                    .buttonStyle(.shBordered)
                }
            }
        }
        .frame(minHeight: 28)
        .padding(.vertical, 8)
        .animation(.default, value: viewModel.canAdjust)
    }
    
    @MainActor @ViewBuilder
    private func recipeView(_ outputRecipe: SingleItemCalculator.OutputRecipe) -> some View {
        VStack(alignment: .leading) {
            if viewModel.product.recipes.count > 1 {
                HStack {
                    Text(outputRecipe.recipe.localizedName)
                        .font(.headline)
                    
                    Spacer()
                    
                    Group {
                        switch outputRecipe.proportion {
                        case .auto:
                            Text("single-item-production-proportion-auto")
                            
                        case let .fraction(fraction):
                            Text(fraction, format: .shPercent)
                            
                        case .fixed:
                            Text("single-item-production-proportion-fixed")
                        }
                    }
                    .font(.footnote)
                    .lineLimit(1)
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
    
    private var outputRecipes: [SingleItemCalculator.OutputRecipe] {
        @Dependency(\.storageService)
        var storageService
        
        return recipeIDs.compactMap {
            storageService.recipe(id: $0).map {
                SingleItemCalculator.OutputRecipe(
                    recipe: $0,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                        item: $0.output.item,
                        amount: 20
                    ),
                    byproducts: $0.byproducts.map {
                        SingleItemCalculator.OutputRecipe.ByproductIngredient(
                            item: $0.item,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        )
                    },
                    inputs: $0.inputs.map {
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            item: $0.item,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        )
                    },
                    proportion: [
                        Proportion.auto,
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
                product: SingleItemCalculator.OutputItem(item: $0, recipes: outputRecipes),
                byproductSelectionState: nil,
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
            Text(verbatim: "There is no item with ID '\(itemID)'")
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
