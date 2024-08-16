import XCTest
@testable import SingleItemCalculator
import SHStorage

final class SingleItemCalculatorTests: XCTestCase {
    @Dependency(\.storageService)
    private var storageService
    
    @Dependency(\.uuid)
    private var uuid
    
    func testProductionCreationWithItem() throws {
        withDependencies {
            $0.storageService = .previewValue
        } operation: {
            let ironPlate = storageService.item(id: "part-iron-plate")!
            let production = SingleItemCalculator(item: ironPlate)
            XCTAssertEqual(production.input, SingleItemCalculator.Input(finalItem: ironPlate, amount: 1.0))
        }
    }
    
    func testProductionWithDefaultEmptyOutput() {
        withDependencies {
            $0.storageService = .previewValue
        } operation: {
            let ironPlate = storageService.item(id: "part-iron-plate")!
            let production = SingleItemCalculator(item: ironPlate)
            production.update()
            XCTAssertEqual(production.outputItems, [])
        }
    }
    
    func testProductionWithInitialRecipe() {
        withDependencies {
            $0.storageService = .previewValue
            $0.uuid = .constant(UUID(0))
        } operation: { [self] in
            let ironPlate = storageService.item(id: "part-iron-plate")!
            let ironPlateRecipe = storageService.recipe(id: "recipe-iron-plate")!
            let ironIngot = storageService.item(id: "part-iron-ingot")!
            let production = SingleItemCalculator(item: ironPlate)
            production.addRecipe(ironPlateRecipe, to: ironPlate)
            production.update()
            
            let expectedOutput = SingleItemCalculator.OutputItem(
                id: uuid(),
                item: ironPlate,
                recipes: [
                    SingleItemCalculator.OutputRecipe(
                        id: uuid(),
                        recipe: ironPlateRecipe,
                        output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                            id: uuid(),
                            item: ironPlate,
                            amount: 1.0
                        ),
                        byproducts: [],
                        inputs: [
                            SingleItemCalculator.OutputRecipe.InputIngredient(
                                id: uuid(),
                                item: ironIngot,
                                amount: 1.5,
                                byproducts: [],
                                isSelected: false
                            )
                        ],
                        proportion: .auto
                    )
                ]
            )
            XCTAssertEqual(production.outputItems, [expectedOutput])
        }
    }
    
    func testProductionWithOneRecipeAndChangedAmount() {
        withDependencies {
            $0.storageService = .previewValue
            $0.uuid = .constant(UUID(0))
        } operation: { [self] in
            let ironPlate = storageService.item(id: "part-iron-plate")!
            let ironPlateRecipe = storageService.recipe(id: "recipe-iron-plate")!
            let ironIngot = storageService.item(id: "part-iron-ingot")!
            let production = SingleItemCalculator(item: ironPlate)
            production.addRecipe(ironPlateRecipe, to: ironPlate)
            production.amount = 20
            production.update()
            
            let expectedOutput = SingleItemCalculator.OutputItem(
                id: uuid(),
                item: ironPlate,
                recipes: [
                    SingleItemCalculator.OutputRecipe(
                        id: uuid(),
                        recipe: ironPlateRecipe,
                        output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                            id: uuid(),
                            item: ironPlate,
                            amount: 20
                        ),
                        byproducts: [],
                        inputs: [
                            SingleItemCalculator.OutputRecipe.InputIngredient(
                                id: uuid(),
                                item: ironIngot,
                                amount: 30,
                                byproducts: [],
                                isSelected: false
                            )
                        ],
                        proportion: .auto
                    )
                ]
            )
            XCTAssertEqual(production.outputItems, [expectedOutput])
        }
    }
    
    func testRecycledPlasticProduction() {
        withDependencies {
            $0.storageService = .previewValue
            $0.uuid = .constant(UUID(0))
        } operation: { [self] in
            let plastic = storageService.item(id: "part-plastic")!
            let rubber = storageService.item(id: "part-rubber")!
            let fuel = storageService.item(id: "part-fuel")!
            let polymerResin = storageService.item(id: "part-polymer-resin")!
            let water = storageService.item(id: "part-water")!
            let heavyOilResidue = storageService.item(id: "part-heavy-oil-residue")!
            
            let recycledPlasticRecipe = storageService.recipe(id: "recipe-alternate-recycled-plastic")!
            let recycledRubberRecipe = storageService.recipe(id: "recipe-alternate-recycled-rubber")!
            let residualRubberRecipe = storageService.recipe(id: "recipe-residual-rubber")!
            let dilutedFuelRecipe = storageService.recipe(id: "recipe-alternate-diluted-fuel")!
            
            let production = SingleItemCalculator(item: plastic)
            production.addRecipe(recycledPlasticRecipe, to: plastic)
            production.addRecipe(recycledRubberRecipe, to: rubber)
            production.addRecipe(residualRubberRecipe, to: rubber, with: .fixed(10))
            production.addRecipe(dilutedFuelRecipe, to: fuel)
            production.amount = 90
            production.update()
            
            let expectedOutput = [
                SingleItemCalculator.OutputItem(
                    id: uuid(),
                    item: plastic,
                    recipes: [
                        SingleItemCalculator.OutputRecipe(
                            id: uuid(),
                            recipe: recycledPlasticRecipe,
                            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                id: uuid(),
                                item: plastic,
                                amount: 113.333_333_333_333_333_333_333_333_333_333
                            ),
                            byproducts: [],
                            inputs: [
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    producingProductID: uuid(),
                                    item: rubber,
                                    amount: 56.666_666_666_666_666_666_666_666_666_666,
                                    byproducts: [],
                                    isSelected: true
                                ),
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    item: fuel,
                                    amount: 56.666_666_666_666_666_666_666_666_666_666,
                                    byproducts: [],
                                    isSelected: true
                                )
                            ],
                            proportion: .auto
                        )
                    ]
                ),
                SingleItemCalculator.OutputItem(
                    id: uuid(),
                    item: rubber,
                    recipes: [
                        SingleItemCalculator.OutputRecipe(
                            id: uuid(),
                            recipe: recycledRubberRecipe,
                            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                id: uuid(),
                                item: rubber,
                                amount: 56.666_666_666_666_666_666_666_666_666_666
                            ),
                            byproducts: [],
                            inputs: [
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    item: plastic,
                                    amount: 28.333_333_333_333_333_333_333_333_333_333,
                                    byproducts: [],
                                    isSelected: true
                                ),
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    item: fuel,
                                    amount: 28.333_333_333_333_333_333_333_333_333_333,
                                    byproducts: [],
                                    isSelected: true
                                )
                            ],
                            proportion: .auto
                        ),
                        SingleItemCalculator.OutputRecipe(
                            id: uuid(),
                            recipe: residualRubberRecipe,
                            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                id: uuid(),
                                item: rubber,
                                amount: 10
                            ),
                            byproducts: [],
                            inputs: [
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    item: polymerResin,
                                    amount: 20,
                                    byproducts: [],
                                    isSelected: false
                                ),
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    item: water,
                                    amount: 20,
                                    byproducts: [],
                                    isSelected: false
                                )
                            ],
                            proportion: .fixed(10)
                        )
                    ]
                ),
                SingleItemCalculator.OutputItem(
                    id: uuid(),
                    item: fuel,
                    recipes: [
                        SingleItemCalculator.OutputRecipe(
                            id: uuid(),
                            recipe: dilutedFuelRecipe,
                            output: SingleItemCalculator.OutputRecipe.OutputIngredient(
                                id: uuid(),
                                item: fuel,
                                amount: 85
                            ),
                            byproducts: [],
                            inputs: [
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    item: heavyOilResidue,
                                    amount: 42.5,
                                    byproducts: [],
                                    isSelected: false
                                ),
                                SingleItemCalculator.OutputRecipe.InputIngredient(
                                    id: uuid(),
                                    item: water,
                                    amount: 42.5,
                                    byproducts: [],
                                    isSelected: false
                                )
                            ],
                            proportion: .auto
                        )
                    ]
                )
            ]
            XCTAssertEqual(production.outputItems, expectedOutput)
        }
    }
}
