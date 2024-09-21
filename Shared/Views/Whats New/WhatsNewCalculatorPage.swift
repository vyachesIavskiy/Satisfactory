import SwiftUI
import SHModels
import SHStorage
import SHSingleItemCalculator

struct WhatsNewCalculatorPage: View {
    @Dependency(\.storageService)
    private var storageService
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            WhatsNewPageTitle("whats-new-calculator-page-title")
                .padding(.horizontal, 20)
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 12) {
                    WhatsNewPageSubtitle("whats-new-calculator-page-subtitle")
                        .padding(.horizontal, 20)
                        .padding(.top, 24)
                    
                    calculatorContentView
                }
            }
            .scrollBounceBehavior(.basedOnSize)
            
            Spacer()
        }
        .padding(.vertical, 20)
        .frame(maxWidth: .infinity)
    }
    
    @ViewBuilder
    private var calculatorContentView: some View {
        let plastic = storageService.part(id: "part-plastic")!
        let rubber = storageService.part(id: "part-rubber")!
        let fuel = storageService.part(id: "part-fuel")!
        let hor = storageService.part(id: "part-heavy-oil-residue")!
        let polymerResin = storageService.part(id: "part-polymer-resin")!
        let water = storageService.part(id: "part-water")!
        let crudeOil = storageService.part(id: "part-crude-oil")!
        
        let plasticRecipe = storageService.recipe(id: "recipe-alternate-recycled-plastic")!
        let rubberRecipe1 = storageService.recipe(id: "recipe-alternate-recycled-rubber")!
        let rubberRecipe2 = storageService.recipe(id: "recipe-residual-rubber")!
        let horRecipe = storageService.recipe(id: "recipe-alternate-heavy-oil-residue")!
        
        let plasticOutputPart = SingleItemCalculator.OutputPart(
            part: plastic,
            recipes: [
                SingleItemCalculator.OutputRecipe(
                    recipe: plasticRecipe,
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
        let rubberOutputPart = SingleItemCalculator.OutputPart(
            part: rubber,
            recipes: [
                SingleItemCalculator.OutputRecipe(
                    recipe: rubberRecipe1,
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
                    recipe: rubberRecipe2,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(part: rubber, amount: 10),
                    byproducts: [],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: polymerResin,
                            amount: 0,
                            byproducts: [
                                SingleItemCalculator.OutputRecipe.Byproduct(index: 0, amount: 20)
                            ],
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
        let horOutputPart = SingleItemCalculator.OutputPart(
            part: hor,
            recipes: [
                SingleItemCalculator.OutputRecipe(
                    recipe: horRecipe,
                    output: SingleItemCalculator.OutputRecipe.OutputIngredient(part: hor, amount: 40),
                    byproducts: [
                        SingleItemCalculator.OutputRecipe.ByproductIngredient(
                            part: polymerResin,
                            amount: 20,
                            byproducts: [
                                SingleItemCalculator.OutputRecipe.Byproduct(index: 0, amount: 20)
                            ],
                            isSelected: false
                        )
                    ],
                    inputs: [
                        SingleItemCalculator.OutputRecipe.InputIngredient(
                            part: crudeOil,
                            amount: 30,
                            byproducts: [],
                            isSelected: false
                        )
                    ],
                    proportion: .auto
                )
            ]
        )
        
        VStack(alignment: .leading) {
            SingleItemCalculatorItemView(
                viewModel: SingleItemCalculatorItemViewModel(part: plasticOutputPart)
            )
            
            SingleItemCalculatorItemView(
                viewModel: SingleItemCalculatorItemViewModel(part: rubberOutputPart)
            )
            
            SingleItemCalculatorItemView(
                viewModel: SingleItemCalculatorItemViewModel(part: horOutputPart)
            )
        }
    }
}

#if DEBUG
#Preview {
    WhatsNewCalculatorPage()
}
#endif
