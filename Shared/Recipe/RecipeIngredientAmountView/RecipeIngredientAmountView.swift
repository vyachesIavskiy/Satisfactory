import SwiftUI
import SHModels
import SingleItemCalculator
import SHUtils

struct RecipeIngredientAmountView: View {
    let viewModel: RecipeIngredientAmountViewModel
    
    var body: some View {
        Text(viewModel.amount, format: .shNumber)
            .multilineTextAlignment(.center)
            .font(.callout)
            .fontWeight(.medium)
            .minimumScaleFactor(0.8)
            .lineLimit(1)
            .padding(.horizontal, 6)
            .frame(minWidth: 80, maxWidth: 100, minHeight: 24)
            .fixedSize(horizontal: true, vertical: false)
            .background {
                ZStack {
                    ItemIconShape(item: viewModel.item, cornerRadius: viewModel.cornerRadius)
                        .fill(viewModel.foregroundStyle)
                        .shadow(color: viewModel.shadowColor, radius: 2, y: 1)
                    
                    if let secondaryStyle = viewModel.secondaryStyle {
                        RecipeByproductShape()
                            .foregroundStyle(secondaryStyle)
                            .clipShape(ItemIconShape(item: viewModel.item, cornerRadius: viewModel.cornerRadius))
                    }
                    
                    ItemIconShape(item: viewModel.item, cornerRadius: viewModel.cornerRadius)
                        .stroke(viewModel.primaryColor, lineWidth: 1)
                }
            }
    }
}

#if DEBUG
#Preview("Recipe - Output") {
    _RecipeIngredientAmountPreview(role: .output)
}

#Preview("Recipe - Byproduct") {
    _RecipeIngredientAmountPreview(role: .byproduct)
}

#Preview("Recipe - Input") {
    _RecipeIngredientAmountPreview(role: .input)
}

#Preview("Production Recipe - Output") {
    _ProductionRecipeIngredientAmountPreview(role: .output)
}

#Preview("Production Recipe - Byproduct") {
    _ProductionRecipeIngredientAmountPreview(role: .byproduct)
}

#Preview("Production Recipe - Input") {
    _ProductionRecipeIngredientAmountPreview(role: .input)
}

#Preview("Production Recipe - Additional amount") {
    _ProductionRecipeAdditionalAmountPreview()
}

private struct _RecipeIngredientAmountPreview: View {
    let role: Recipe.Ingredient.Role
    
    var body: some View {
        HStack {
            ingredientAmount(form: .solid)
            
            ingredientAmount(form: .fluid)
            
            ingredientAmount(form: .gas)
        }
    }
    
    @ViewBuilder
    private func ingredientAmount(form: Part.Form) -> some View {
        VStack {
            switch form {
            case .solid:
                Text(verbatim: "Solid")
                
            case .fluid:
                Text(verbatim: "Fluid")
                
            case .gas:
                Text(verbatim: "Gas")
            }
            
            RecipeIngredientAmountView(
                viewModel: RecipeIngredientAmountViewModel(
                    recipeIngredient: ingredient(role: role, form: form),
                    amount: 100
                )
            )
        }
    }
}

private struct _ProductionRecipeIngredientAmountPreview: View {
    enum Role {
        case output
        case byproduct
        case input
    }
    
    let role: Role
    let index: Int?
    
    init(role: Role, index: Int? = nil) {
        self.role = role
        self.index = index
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(verbatim: "Unselected")
                .padding(.vertical)
            
            HStack {
                ingredientAmount(form: .solid, selected: false, naturalResource: false)
                
                ingredientAmount(form: .fluid, selected: false, naturalResource: false)
                
                ingredientAmount(form: .gas, selected: false, naturalResource: false)
            }
            
            Text(verbatim: "Natural Resource")
                .padding(.vertical)
            
            HStack {
                ingredientAmount(form: .solid, selected: false, naturalResource: true)
                
                ingredientAmount(form: .fluid, selected: false, naturalResource: true)
                
                ingredientAmount(form: .gas, selected: false, naturalResource: true)
            }
            
            Text(verbatim: "Selected")
                .padding(.vertical)
            
            HStack {
                ingredientAmount(form: .solid, selected: true, naturalResource: false)
                
                ingredientAmount(form: .fluid, selected: true, naturalResource: false)
                
                ingredientAmount(form: .gas, selected: true, naturalResource: false)
            }
        }
    }
    
    @ViewBuilder
    private func ingredientAmount(form: Part.Form, selected: Bool, naturalResource: Bool) -> some View {
        VStack {
            switch form {
            case .solid:
                Text(verbatim: "Solid")
                
            case .fluid:
                Text(verbatim: "Fluid")
                
            case .gas:
                Text(verbatim: "Gas")
            }
            
            let viewModel = switch role {
            case .output:
                RecipeIngredientAmountViewModel(productionOutput: productionIngredient(form: form, selected: selected))
                
            case .byproduct:
                RecipeIngredientAmountViewModel(productionByproduct: productionIngredient(form: form, selected: selected, naturalResource: naturalResource))
                
            case .input:
                RecipeIngredientAmountViewModel(productionInput: productionIngredient(form: form, selected: selected, naturalResource: naturalResource))
            }
            
            RecipeIngredientAmountView(viewModel: viewModel)
        }
    }
}

private struct _ProductionRecipeAdditionalAmountPreview: View {
    var body: some View {
        VStack(alignment: .leading) {
            ForEach(0..<7) { index in
                HStack {
                    ingredientAmount(form: .solid, index: index)
                    
                    ingredientAmount(form: .fluid, index: index)
                    
                    ingredientAmount(form: .gas, index: index)
                }
            }
        }
    }
    
    @ViewBuilder
    private func ingredientAmount(form: Part.Form, index: Int) -> some View {
        VStack {
            switch form {
            case .solid:
                Text(verbatim: "Solid")
                
            case .fluid:
                Text(verbatim: "Fluid")
                
            case .gas:
                Text(verbatim: "Gas")
            }
            
            RecipeIngredientAmountView(viewModel: RecipeIngredientAmountViewModel(
                productionSecondaryByproduct: productionSecondaryByproduct(index: index),
                item: part(form: form)
            ))
        }
    }
}

private func part(form: Part.Form) -> Part {
    Part(id: "preview-part", category: .special, progressionIndex: 0, form: form)
}

private func ingredient(role: Recipe.Ingredient.Role, form: Part.Form) -> Recipe.Ingredient {
    Recipe.Ingredient(
        role: role,
        item: part(form: form),
        amount: 0
    )
}

private func productionIngredient(form: Part.Form, selected: Bool) -> SingleItemCalculator.OutputRecipe.OutputIngredient {
    SingleItemCalculator.OutputRecipe.OutputIngredient(
        item: Part(id: "preview-part", category: .special, progressionIndex: 0, form: form),
        amount: 10
    )
}

private func productionIngredient(form: Part.Form, selected: Bool, naturalResource: Bool) -> SingleItemCalculator.OutputRecipe.ByproductIngredient {
    SingleItemCalculator.OutputRecipe.ByproductIngredient(
        item: Part(
            id: "preview-part",
            category: .special,
            progressionIndex: 0,
            form: form,
            isNaturalResource: naturalResource
        ),
        amount: 10,
        byproducts: [],
        isSelected: selected
    )
}

private func productionIngredient(form: Part.Form, selected: Bool, naturalResource: Bool) -> SingleItemCalculator.OutputRecipe.InputIngredient {
    SingleItemCalculator.OutputRecipe.InputIngredient(
        producingProductID: nil,
        item: Part(
            id: "preview-part",
            category: .special,
            progressionIndex: 0,
            form: form,
            isNaturalResource: naturalResource
        ),
        amount: 10,
        byproducts: [],
        isSelected: selected
    )
}

private func productionSecondaryByproduct(index: Int) -> SingleItemCalculator.OutputRecipe.Byproduct {
    SingleItemCalculator.OutputRecipe.Byproduct(index: index, amount: 10)
}
#endif
