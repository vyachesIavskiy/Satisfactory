import SwiftUI
import SHModels
import SingleItemCalculator

struct RecipeIngredientView: View {
    let viewModel: RecipeIngredientViewModel
    
    @Environment(\.showIngredientNames)
    private var showIngredientNames
    
    private var iconSpacing: Double {
        showIngredientNames ? 12.0 : 0.0
    }
    
    private var iconSize: Double {
        showIngredientNames ? 40 : 48
    }

    var body: some View {
        VStack(spacing: iconSpacing) {
            VStack(spacing: 0) {
                Image(viewModel.item.id)
                    .resizable()
                    .frame(width: iconSize, height: iconSize)
                    .padding(4)
                
                if showIngredientNames {
                    Text(viewModel.item.localizedName)
                        .font(.callout)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .minimumScaleFactor(0.7)
                        .frame(width: 100, height: 40)
                }
            }

            VStack(spacing: -2) {
                ForEach(Array(viewModel.amountViewModels().enumerated()), id: \.offset) { index, viewModel in
                    RecipeIngredientAmountView(viewModel: viewModel)
                        .offset(x: 4 * Double(index))
                }
            }
        }
    }
}

#if DEBUG
#Preview("Display Output") {
    _DisplayIngredientPreview(role: .output)
}

#Preview("Display Byproduct") {
    _DisplayIngredientPreview(role: .byproduct)
}

#Preview("Display Input") {
    _DisplayIngredientPreview(role: .input)
}

#Preview("Production Output") {
    _ProductionIngredientPreview(role: .output)
}

#Preview("Production Byproduct") {
    _ProductionIngredientPreview(role: .byproduct)
}

#Preview("Production Input") {
    _ProductionIngredientPreview(role: .input)
}

#Preview("Production Output (1 byproduct)") {
    _ProductionIngredientPreview(role: .output, byproductCount: 1)
}

#Preview("Production Byproduct (1 byproduct)") {
    _ProductionIngredientPreview(role: .byproduct, byproductCount: 1)
}

#Preview("Production Input (1 byproduct)") {
    _ProductionIngredientPreview(role: .input, byproductCount: 1)
}

#Preview("Production Output (2 byproduct)") {
    _ProductionIngredientPreview(role: .output, byproductCount: 2)
}

#Preview("Production Byproduct (2 byproduct)") {
    _ProductionIngredientPreview(role: .byproduct, byproductCount: 2)
}

#Preview("Production Input (2 byproduct)") {
    _ProductionIngredientPreview(role: .input, byproductCount: 2)
}

private struct _DisplayIngredientPreview: View {
    let role: Recipe.Ingredient.Role
    
    var body: some View {
        VStack {
            ingredient(form: .solid)
            
            ingredient(form: .fluid)
            
            ingredient(form: .gas)
        }
    }
    
    @MainActor @ViewBuilder
    private func ingredient(form: Part.Form) -> some View {
        HStack(spacing: 40) {
            switch form {
            case .solid:
                Text("Solid")
                
            case .fluid:
                Text("Fluid")
                
            case .gas:
                Text("Gas")
            }
            
            RecipeIngredientView(
                viewModel: RecipeIngredientViewModel(
                    displayIngredient: displayIngredient(role: role, form: form),
                    amount: 10
                )
            )
            .showIngredientNames(false)
            
            RecipeIngredientView(
                viewModel: RecipeIngredientViewModel(
                    displayIngredient: displayIngredient(role: role, form: form),
                    amount: 10
                )
            )
            .showIngredientNames(true)
        }
    }
}

private struct _ProductionIngredientPreview: View {
    enum Role {
        case output
        case byproduct
        case input
    }
    
    let role: Role
    let byproductCount: Int
    
    init(role: Role, byproductCount: Int = 0) {
        self.role = role
        self.byproductCount = byproductCount
    }
    
    var body: some View {
        ScrollView {
            Grid(alignment: .leading, horizontalSpacing: 40, verticalSpacing: 24) {
                titleRow("Unselected")
                
                row(form: .solid, selected: false)
                
                row(form: .fluid, selected: false)
                
                row(form: .gas, selected: false)
                
                Divider()
                    .gridCellUnsizedAxes(.horizontal)
                
                titleRow("Selected")
                
                row(form: .solid, selected: true)
                
                row(form: .fluid, selected: true)
                
                row(form: .gas, selected: true)
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    @MainActor @ViewBuilder
    private func titleRow(_ title: String) -> some View {
        GridRow {
            Text(title)
            
            Text("Icon")
                .font(.headline)
                .gridColumnAlignment(.center)

            
            Text("Row")
                .font(.headline)
                .gridColumnAlignment(.center)
        }
    }
    
    @MainActor @ViewBuilder
    private func row(form: Part.Form, selected: Bool) -> some View {
        GridRow(alignment: .top) {
            Group {
                switch form {
                case .solid:
                    Text("Solid")
                    
                case .fluid:
                    Text("Fluid")
                    
                case .gas:
                    Text("Gas")
                }
            }
            .frame(maxHeight: .infinity)
            
            let viewModel = switch role {
            case .output:
                RecipeIngredientViewModel(
                    productionOutput: productionIngredient(
                        form: form,
                        byproductCount: byproductCount
                    )
                )
                
            case .byproduct:
                RecipeIngredientViewModel(
                    productionByproduct: productionIngredient(
                        form: form,
                        selected: selected,
                        byproductCount: byproductCount
                    )
                )
                
            case .input:
                RecipeIngredientViewModel(
                    productionInput: productionIngredient(
                        form: form,
                        selected: selected,
                        byproductCount: byproductCount
                    )
                )
            }
            
            RecipeIngredientView(viewModel: viewModel)
                .showIngredientNames(false)
            
            RecipeIngredientView(viewModel: viewModel)
                .showIngredientNames(true)
        }
    }
}

private func part(form: Part.Form) -> Part {
    let id = switch form {
    case .solid: "part-iron-ingot"
    case .fluid: "part-water"
    case .gas: "part-nitrogen-gas"
    }
    
    return Part(id: id, category: .special, progressionIndex: 0, form: form)
}

private func displayIngredient(role: Recipe.Ingredient.Role, form: Part.Form) -> Recipe.Ingredient {
    Recipe.Ingredient(role: role, item: part(form: form), amount: 10)
}

private func productionIngredient(form: Part.Form, byproductCount: Int = 0) -> SingleItemCalculator.OutputRecipe.OutputIngredient {
    let id = switch form {
    case .solid: "part-iron-ingot"
    case .fluid: "part-water"
    case .gas: "part-nitrogen-gas"
    }
    
    return SingleItemCalculator.OutputRecipe.OutputIngredient(
        item: Part(id: id, category: .special, progressionIndex: 0, form: form),
        amount: 10
    )
}

private func productionIngredient(form: Part.Form, selected: Bool, byproductCount: Int = 0) -> SingleItemCalculator.OutputRecipe.ByproductIngredient {
    let id = switch form {
    case .solid: "part-iron-ingot"
    case .fluid: "part-water"
    case .gas: "part-nitrogen-gas"
    }
    
    return SingleItemCalculator.OutputRecipe.ByproductIngredient(
        item: Part(id: id, category: .special, progressionIndex: 0, form: form),
        amount: 10,
        byproducts: (0..<byproductCount).map {
            SingleItemCalculator.OutputRecipe.Byproduct(index: $0, amount: 10)
        },
        isSelected: selected
    )
}

private func productionIngredient(form: Part.Form, selected: Bool, byproductCount: Int = 0) -> SingleItemCalculator.OutputRecipe.InputIngredient {
    let id = switch form {
    case .solid: "part-iron-ingot"
    case .fluid: "part-water"
    case .gas: "part-nitrogen-gas"
    }
    
    return SingleItemCalculator.OutputRecipe.InputIngredient(
        producingProductID: nil,
        item: Part(id: id, category: .special, progressionIndex: 0, form: form),
        amount: 10,
        byproducts: (0..<byproductCount).map {
            SingleItemCalculator.OutputRecipe.Byproduct(index: $0, amount: 10)
        },
        isSelected: selected
    )
}

private func productionSecondaryByproduct(index: Int) -> SingleItemCalculator.OutputRecipe.Byproduct {
    SingleItemCalculator.OutputRecipe.Byproduct(index: index, amount: 10)
}
#endif
