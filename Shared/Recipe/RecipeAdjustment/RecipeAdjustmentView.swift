import SwiftUI

struct RecipeAdjustmentView: View {
    @State
    var viewModel: RecipeAdjustmentViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text(viewModel.recipe.recipe.localizedName)
                    .fontWeight(.semibold)
                
                Spacer()
                
                HStack(spacing: 12) {
                    if viewModel.allowAdjustment {
                        ProductionProportionView(viewModel: viewModel.proportionViewModel())
                    }
                    
                    if viewModel.allowDeletion {
                        Button {
                            viewModel.onDelete()
                        } label: {
                            Image(systemName: "trash")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                        }
                        .buttonStyle(.shBordered)
                        .tint(.sh(.red))
                    }
                }
            }
            
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
import SingleItemCalculator

private struct _RecipeAdjustmentPreview: View {
    let recipeID: String
    
    private var outputRecipe: SingleItemCalculator.OutputRecipe? {
        @Dependency(\.storageService)
        var storageService
        
        let recipe = storageService.recipe(id: recipeID)
        
        return recipe.map {
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
                proportion: .fixed(20)
            )
        }
    }
    
    private var viewModel: RecipeAdjustmentViewModel? {
        outputRecipe.map {
            RecipeAdjustmentViewModel(
                recipe: $0,
                numberOfRecipes: 1,
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
