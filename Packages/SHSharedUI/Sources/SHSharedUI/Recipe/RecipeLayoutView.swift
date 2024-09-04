import SwiftUI

public struct RecipeLayoutView<Output: View, Byproduct: View, Input: View>: View {
    private let outputViewModel: RecipeIngredientViewModel
    private let byproductViewModels: [RecipeIngredientViewModel]
    private let inputViewModels: [RecipeIngredientViewModel]
    
    private let output: @MainActor (RecipeIngredientView) -> Output
    private let byproduct: @MainActor (Int, RecipeIngredientView) -> Byproduct
    private let input: @MainActor (Int, RecipeIngredientView) -> Input
    
    private let gridItem = GridItem(.adaptive(minimum: 80, maximum: 100), spacing: 12, alignment: .top)
    
    @Environment(\.displayScale)
    private var displayScale
    
    public init(
        outputViewModel: RecipeIngredientViewModel,
        byproductViewModels: [RecipeIngredientViewModel],
        inputViewModels: [RecipeIngredientViewModel],
        @ViewBuilder output: @escaping @MainActor (RecipeIngredientView) -> Output,
        @ViewBuilder byproduct: @escaping @MainActor (Int, RecipeIngredientView) -> Byproduct,
        @ViewBuilder input: @escaping @MainActor (Int, RecipeIngredientView) -> Input
    ) {
        self.outputViewModel = outputViewModel
        self.byproductViewModels = byproductViewModels
        self.inputViewModels = inputViewModels
        self.output = output
        self.byproduct = byproduct
        self.input = input
    }
    
    public init(
        outputViewModel: RecipeIngredientViewModel,
        byproductViewModels: [RecipeIngredientViewModel],
        inputViewModels: [RecipeIngredientViewModel]
    ) where Output == RecipeIngredientView, Byproduct == RecipeIngredientView, Input == RecipeIngredientView {
        self.init(
            outputViewModel: outputViewModel,
            byproductViewModels: byproductViewModels,
            inputViewModels: inputViewModels,
            output: { $0 },
            byproduct: { _, view in view },
            input: { _, view in view }
        )
    }
    
    public var body: some View {
        ViewThatFits(in: .horizontal) {
            HStack(alignment: .top, spacing: 24) {
                HStack(alignment: .top, spacing: 12) {
                    outputView
                    
                    byproductsView
                }
                
                HStack(alignment: .top, spacing: 12) {
                    inputsView
                }
            }
            
            HStack(alignment: .top, spacing: 24) {
                VStack(spacing: 12) {
                    outputView
                    
                    byproductsView
                }
                
                ViewThatFits(in: .horizontal) {
                    HStack(alignment: .top, spacing: 12) {
                        inputsView
                    }
                    
                    VStack(spacing: 12) {
                        inputsGridView
                    }
                }
            }
        }
    }
    
    @MainActor @ViewBuilder
    private var outputView: some View {
        let ingredientView = RecipeIngredientView(viewModel: outputViewModel)
        output(ingredientView)
    }
    
    @MainActor @ViewBuilder
    private var byproductsView: some View {
        ForEach(Array(byproductViewModels.enumerated()), id: \.element.id) { index, viewModel in
            let ingredientView = RecipeIngredientView(viewModel: viewModel)
            byproduct(index, ingredientView)
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsView: some View {
        ForEach(Array(inputViewModels.enumerated()), id: \.element.id) { index, viewModel in
            let ingredientView = RecipeIngredientView(viewModel: viewModel)
            input(index, ingredientView)
        }
    }
    
    @MainActor @ViewBuilder
    private var inputsGridView: some View {
        let viewModels = inputViewModels
            .reduce(into: [[RecipeIngredientViewModel]]()) { partialResult, viewModel in
                if let lastIndex = partialResult.indices.last, partialResult[lastIndex].count < 2 {
                    partialResult[lastIndex].append(viewModel)
                } else {
                    partialResult.append([viewModel])
                }
            }
        
        ForEach(Array(viewModels.enumerated()), id: \.offset) { _, viewModels in
            HStack(alignment: .top, spacing: 12) {
                ForEach(viewModels) { viewModel in
                    if let index = inputViewModels.firstIndex(where: { $0.id == viewModel.id }) {
                        input(index, RecipeIngredientView(viewModel: viewModel))
                    }
                }
            }
        }
    }
}

#if DEBUG
import SHStorage
import SHModels

private struct _RecipeLayoutDisplayPreview: View {
    let recipe: Recipe
    
    init(recipeID: String) {
        @Dependency(\.storageService)
        var storageService
        
        recipe = storageService.recipe(id: recipeID)!
    }
    
    var body: some View {
        RecipeLayoutView(
            outputViewModel: RecipeIngredientViewModel(ingredient: recipe.output, amount: 10),
            byproductViewModels: recipe.byproducts.map { RecipeIngredientViewModel(ingredient: $0, amount: 10) },
            inputViewModels: recipe.inputs.map { RecipeIngredientViewModel(ingredient: $0, amount: 10) }
        )
    }
}

#Preview("Recipe Display") {
    _RecipeLayoutDisplayPreview(recipeID: "recipe-reinforced-iron-plate")
}
#endif
