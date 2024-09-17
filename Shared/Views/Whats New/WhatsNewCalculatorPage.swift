import SwiftUI
import SHModels
import SHStorage
import SHSingleItemCalculator

struct WhatsNewCalculatorPage: View {
    @Dependency(\.storageService)
    private var storageService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            WhatsNewPageTitle("whats-new-calculator-page-title")
                .padding(.horizontal, 20)
            
            WhatsNewPageSubtitle("whats-new-calculator-page-subtitle")
                .padding(.horizontal, 20)
            
            ScrollView {
                VStack(alignment: .leading) {
                    SingleItemCalculatorItemView(
                        viewModel: SingleItemCalculatorItemViewModel(part: plasticOutputItem)
                    )
                    
                    SingleItemCalculatorItemView(
                        viewModel: SingleItemCalculatorItemViewModel(part: rubberOutputItem)
                    )
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            
            Spacer()
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
    }
    
    private var plasticOutputItem: SingleItemCalculator.OutputPart {
        let plastic = storageService.part(id: "part-plastic")!
        let rubber = storageService.part(id: "part-rubber")!
        let fuel = storageService.part(id: "part-fuel")!
        let recipe = storageService.recipe(id: "recipe-alternate-recycled-plastic")!
        
        return SingleItemCalculator.OutputPart(
            part: plastic,
            recipes: [
                SingleItemCalculator.OutputRecipe(
                    recipe: recipe,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                        part: plastic,
                        amount: 90,
                        additionalAmounts: [23.333333]
                    ),
                    byproducts: [],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: rubber,
                            amount: 56.666666,
                            byproducts: [],
                            isSelected: true
                        ),
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: fuel,
                            amount: 56.666666,
                            byproducts: [],
                            isSelected: false
                        )
                    ],
                    proportion: .auto
                )
            ]
        )
    }
    
    private var rubberOutputItem: SingleItemCalculator.OutputPart {
        let rubber = storageService.part(id: "part-rubber")!
        let plastic = storageService.part(id: "part-plastic")!
        let fuel = storageService.part(id: "part-fuel")!
        let polymerResin = storageService.part(id: "part-polymer-resin")!
        let water = storageService.part(id: "part-water")!
        
        let recipe1 = storageService.recipe(id: "recipe-alternate-recycled-rubber")!
        let recipe2 = storageService.recipe(id: "recipe-residual-rubber")!
        
        return SingleItemCalculator.OutputPart(
            part: plastic,
            recipes: [
                SingleItemCalculator.OutputRecipe(
                    recipe: recipe1,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(part: rubber, amount: 56.666666),
                    byproducts: [],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: plastic,
                            amount: 23.333333,
                            byproducts: [],
                            isSelected: true
                        ),
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: fuel,
                            amount: 23.333333,
                            byproducts: [],
                            isSelected: false
                        )
                    ],
                    proportion: .auto
                ),
                SingleItemCalculator.OutputRecipe(
                    recipe: recipe2,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(part: rubber, amount: 10),
                    byproducts: [],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: polymerResin,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        ),
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: water,
                            amount: 20,
                            byproducts: [],
                            isSelected: false
                        )
                    ],
                    proportion: .fixed(10)
                )
            ]
        )
    }
}

#if DEBUG
#Preview {
    WhatsNewCalculatorPage()
}
#endif
