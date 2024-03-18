import SwiftUI
import Storage
import Settings
import Models
import TCA

@Reducer
struct RecipeFeature {
    struct State: Equatable {
        var recipe: Models.Recipe
        var itemViewStyle = Settings.ItemViewStyle.icon
    }
    
    enum Action: Equatable {
        enum View: Equatable {
            case onAppear
        }
        
        enum Internal: Equatable {
            case itemViewStyleChange(Settings.ItemViewStyle)
        }
        
        case view(View)
        case `internal`(Internal)
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .view(viewAction): reduceView(into: &state, action: viewAction)
            case let .internal(internalAction): reduceInternal(into: &state, action: internalAction)
            }
        }
    }
    
//    @Dependency(\.settingsClient) private var settingsClient
    
    private func reduceView(into state: inout State, action: Action.View) -> Effect<Action> {
        switch action {
        case .onAppear:
//            return .run { send in
//                for await itemViewStyle in settingsClient.updates().map(\.itemViewStyle).eraseToStream() {
//                    await send(.internal(.itemViewStyleChange(itemViewStyle)))
//                }
//            }
            return .none
        }
    }
    
    private func reduceInternal(into state: inout State, action: Action.Internal) -> Effect<Action> {
        switch action {
        case let .itemViewStyleChange(itemViewStyle):
            state.itemViewStyle = itemViewStyle
            return .none
        }
    }
}

struct RecipeView: View {
    private let store: StoreOf<RecipeFeature>
    @ObservedObject private var viewStore: ViewStore<RecipeFeature.State, RecipeFeature.Action.View>
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    init(store: StoreOf<RecipeFeature>) {
        self.store = store
        self.viewStore = ViewStore(store, observe: { $0 }, send: RecipeFeature.Action.view)
    }
    
    var body: some View {
        switch viewStore.itemViewStyle {
        case .icon:
            if horizontalSizeClass == .compact {
                RecipeViewCompact(viewStore.recipe)
            } else {
                RecipeViewRegular(viewStore.recipe)
            }

        case .row:
            RecipeViewRow(viewStore.recipe)
        }
    }
}

private struct RecipeViewCompact: View {
    let recipe: Models.Recipe
    
    private let gridItem = GridItem(.adaptive(minimum: 66, maximum: .infinity), spacing: 10)
    
    init(_ recipe: Models.Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        HStack(spacing: 25) {
            LazyVGrid(columns: [gridItem], spacing: 15) {
                IngredientIconView(recipe.output)
                
                ForEach(recipe.byproducts) { byproduct in
                    IngredientIconView(byproduct)
                }
            }
            .frame(width: 70)
            
            LazyVGrid(columns: [gridItem], spacing: 15) {
                ForEach(recipe.input) { input in
                    IngredientIconView(input)
                }
            }
            .frame(width: recipe.input.count > 1 ? 150 : 70)
        }
    }
}

private struct RecipeViewRegular: View {
    let recipe: Models.Recipe
    
    init(_ recipe: Models.Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        HStack(spacing: 25) {
            HStack(spacing: 10) {
                IngredientIconView(recipe.output)
                
                ForEach(recipe.byproducts) { byproduct in
                    IngredientIconView(byproduct)
                }
            }
            
            HStack(spacing: 10) {
                ForEach(recipe.input) { input in
                    IngredientIconView(input)
                }
            }
        }
    }
}

private struct RecipeViewRow: View {
    let recipe: Models.Recipe
    
    init(_ recipe: Models.Recipe) {
        self.recipe = recipe
    }
    
    var body: some View {
        HStack(spacing: 25) {
            VStack(alignment: .leading, spacing: 15) {
                IngredientRowView(recipe.output)
                
                ForEach(recipe.byproducts) { byproduct in
                    IngredientRowView(byproduct)
                }
            }
            
            VStack(alignment: .leading, spacing: 15) {
                ForEach(recipe.input) { input in
                    IngredientRowView(input)
                }
            }
        }
    }
}

private struct IngredientIconView: View {
    let ingredient: Models.Recipe.Ingredient
    
    private var amountPerMinuteDisplayString: String {
//        ingredient.amountPerMinute.formatted(.fractionFromZeroToFour)
        ingredient.amount.formatted(.fractionFromZeroToFour)
    }
    
    init(_ ingredient: Models.Recipe.Ingredient) {
        self.ingredient = ingredient
    }
    
    var body: some View {
        ItemCell(
            item: ingredient.item,
            amountPerMinute: amountPerMinuteDisplayString,
            isOutput: ingredient.role == .output
        )
    }
}

private struct IngredientRowView: View {
    let ingredient: Models.Recipe.Ingredient
    
    private var amountPerMinuteDisplayString: String {
//        ingredient.amountPerMinute.formatted(.fractionFromZeroToFour)
        ingredient.amount.formatted(.fractionFromZeroToFour)
    }
    
    init(_ ingredient: Models.Recipe.Ingredient) {
        self.ingredient = ingredient
    }
    
    var body: some View {
        ItemRowInRecipe(
            item: ingredient.item,
            amountPerMinute: amountPerMinuteDisplayString,
            isOutput: ingredient.role == .output
        )
    }
}

struct RecipeView_Previews: PreviewProvider {
    static private let recipesForItem = {
        @Dependency(\.storageClient.recipesForItemWithID) var recipesForItem
        return recipesForItem
    }()
    
    static var previews: some View {
        VStack(alignment: .leading, spacing: 10) {
            RecipeView(store: store(for: recipesForItem("iron-ingot", .output)[0]))
            RecipeView(store: store(for: recipesForItem("modular-frame", .output)[0]))
            RecipeView(store: store(for: recipesForItem("computer", .output)[1]))
            RecipeView(store: store(for: recipesForItem("non-fissile-uranium", .output)[0]))
        }
    }
    
    private static func store(for recipe: Models.Recipe) -> StoreOf<RecipeFeature> {
        Store(initialState: RecipeFeature.State(recipe: recipe)) {
            RecipeFeature()
        } withDependencies: {
            $0.storageClient = .live
        }
    }
}
