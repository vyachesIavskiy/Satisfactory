import SwiftUI

struct RecipeAdjustmentView: View {
    @Bindable
    var viewModel: RecipeAdjustmentViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(viewModel.recipe.recipe.localizedName)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    if viewModel.allowAdjustment {
                        ProductionProportionView($viewModel.proportion, totalAmount: viewModel.recipe.output.amount)
                    }
                    
                    if viewModel.allowDeletion {
                        Button {
                            viewModel.onDelete()
                        } label: {
                            Image(systemName: "trash")
                                .font(.caption)
                                .frame(height: 16)
                        }
                        .buttonStyle(.shTinted)
                        .tint(.sh(.red))
                        .padding(.horizontal, 4)
                    }
                }
            }
            .frame(minHeight: 24)
            
            SingleItemProductionRecipeDisplayView(
                viewModel: SingleItemProductionRecipeDisplayViewModel(
                    recipe: viewModel.recipe
                )
            )
        }
    }
}

#if DEBUG
import SHStorage
import SHModels
import SHSingleItemProduction

private struct _RecipeAdjustmentPreview: View {
    let recipeID: String
    
    private var outputRecipe: SHSingleItemProduction.OutputRecipe? {
        @Dependency(\.storageService)
        var storageService
        
        let recipe = storageService.recipe(id: recipeID)
        
        return recipe.map {
            SHSingleItemProduction.OutputRecipe(
                recipe: $0,
                output: SHSingleItemProduction.OutputRecipe.OutputIngredient(
                    item: $0.output.item,
                    amount: 20,
                    byproducts: [],
                    isSelected: false
                ),
                byproducts: $0.byproducts.map {
                    SHSingleItemProduction.OutputRecipe.OutputIngredient(
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
                proportion: .fixed(20)
            )
        }
    }
    
    private var viewModel: RecipeAdjustmentViewModel? {
        outputRecipe.map {
            RecipeAdjustmentViewModel(
                recipe: $0,
                allowAdjustment: true,
                allowDeletion: true,
                onChange: { _ in },
                onDelete: {}
            )
        }
    }
    
    var body: some View {
        if let viewModel {
            RecipeAdjustmentView(viewModel: viewModel)
        } else {
            Text("There is no recipe with id '\(recipeID)'")
                .font(.title3)
                .padding()
        }
    }
}

#Preview("Heavy Modular Frame") {
    _RecipeAdjustmentPreview(recipeID: "recipe-heavy-modular-frame")
        .padding()
}
#endif
