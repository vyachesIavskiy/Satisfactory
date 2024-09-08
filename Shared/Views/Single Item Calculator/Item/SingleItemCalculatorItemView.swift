import SwiftUI
import SHSingleItemCalculator

public struct SingleItemCalculatorItemView: View {
    private let viewModel: SingleItemCalculatorItemViewModel
    
    @Environment(\.displayScale)
    private var displayScale
    
    @Environment(\.horizontalSizeClass)
    private var horizontalSizeClass
    
    public init(viewModel: SingleItemCalculatorItemViewModel) {
        self.viewModel = viewModel
    }
    
    public var body: some View {
        VStack(spacing: 8) {
            titleView
                .padding(.horizontal, 16)
            
            ForEach(Array(viewModel.item.recipes.enumerated()), id: \.element.id) { index, outputRecipe in
                VStack(spacing: 16) {
                    recipeView(outputRecipe)
                        .padding(.horizontal, 16)
                    
                    if index != viewModel.item.recipes.indices.last {
                        Rectangle()
                            .fill(LinearGradient(
                                colors: [.sh(.midnight40), .sh(.midnight40).opacity(0.1)],
                                startPoint: .leading,
                                endPoint: .trailing
                            ))
                            .frame(height: 2 / displayScale)
                            .padding(.leading, 16)
                    }
                }
            }
        }
        .frame(
            maxWidth: horizontalSizeClass == .compact ? .infinity : 600,
            alignment: .leading
        )
    }
    
    @MainActor @ViewBuilder
    private var titleView: some View {
        HStack(alignment: .firstTextBaseline) {
            if viewModel.item.recipes.count > 1 {
                Text(viewModel.item.item.localizedName)
                    .font(.title3)
                    .foregroundStyle(.secondary)
            } else {
                Text(viewModel.item.recipes[0].recipe.localizedName)
                    .fontWeight(.medium)
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
        .animation(.default, value: viewModel.canAdjust)
    }
    
    @MainActor @ViewBuilder
    private func recipeView(_ outputRecipe: SingleItemCalculator.OutputRecipe) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            if viewModel.item.recipes.count > 1 {
                HStack {
                    Text(outputRecipe.recipe.localizedName)
                        .fontWeight(.medium)
                    
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
            
            CalculatorRecipeView(viewModel: viewModel.outputRecipeViewModel(for: outputRecipe))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
import SHStorage
import SHModels

private struct _SingleItemCalculatorItemPreview: View {
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
    
    private var viewModel: SingleItemCalculatorItemViewModel? {
        item.map {
            SingleItemCalculatorItemViewModel(
                item: SingleItemCalculator.OutputItem(item: $0, recipes: outputRecipes),
                byproductSelectionState: nil,
                canPerformAction: { _ in true },
                performAction: { _ in }
            )
        }
    }
    
    var body: some View {
        if let viewModel {
            ScrollView {
                SingleItemCalculatorItemView(viewModel: viewModel)
            }
        } else {
            Text(verbatim: "There is no item with ID '\(itemID)'")
                .font(.title3)
                .padding()
        }
    }
}

#Preview("Plastic, 1 recipe") {
    _SingleItemCalculatorItemPreview(itemID: "part-plastic", recipeIDs: ["recipe-alternate-recycled-plastic"])
}

#Preview("Rubber, 2 recipes") {
    _SingleItemCalculatorItemPreview(itemID: "part-rubber", recipeIDs: [
        "recipe-alternate-recycled-rubber",
        "recipe-rubber"
    ])
}

#Preview("Heavy Modular Frame, 3 recipes") {
    _SingleItemCalculatorItemPreview(itemID: "part-heavy-modular-frame", recipeIDs: [
        "recipe-heavy-modular-frame",
        "recipe-alternate-heavy-encased-frame",
        "recipe-alternate-heavy-flexible-frame"
    ])
}
#endif
