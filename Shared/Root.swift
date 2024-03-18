import Storage
import Models
import TCA

struct Part: Item {
    let _part: Models.Part
    
    var id: String { _part.id }
    var localizedName: String { _part.localizedName }
    var category: Category { _part.category }
    var localizedDescription: String { _part.localizedDescription }
    var form: Models.Part.Form { _part.form }
    var isNaturalResource: Bool { _part.isNaturalResource }

    var isPinned: Bool
    
    fileprivate init(_ part: Models.Part, isPinned: Bool) {
        self._part = part
        self.isPinned = isPinned
    }
}

struct Equipment: Item {
    typealias Slot = Models.Equipment.Slot
    
    let _equipment: Models.Equipment
    
    var id: String { _equipment.id }
    var localizedName: String { _equipment.localizedName }
    var category: Category { _equipment.category }
    var localizedDescription: String { _equipment.localizedDescription }
    var slot: Slot { _equipment.slot }
    var ammo: [Models.Part] { _equipment.ammo }
    var fuel: [Models.Part] { _equipment.fuel }
    var consumes: [Models.Part] { _equipment.consumes }
    var requireElectrecity: Bool { _equipment.requireElectrecity }
    
    var isPinned: Bool
    
    fileprivate init(_ equipment: Models.Equipment, isPinned: Bool) {
        self._equipment = equipment
        self.isPinned = isPinned
    }
}

struct Recipe: BaseItem {
    typealias Ingredient = Models.Recipe.Ingredient
    
    let _recipe: Models.Recipe
    
    var id: String { _recipe.id }
    var localizedName: String { _recipe.localizedName }
    var input: [Ingredient] { _recipe.input }
    var output: Ingredient { _recipe.output }
    var byproducts: [Ingredient] { _recipe.byproducts }
    var machines: [Building] { _recipe.machines }
    var duration: Int { _recipe.duration }
    var isDefault: Bool { _recipe.isDefault }
    
    var isPinned: Bool
    
    fileprivate init(_ recipe: Models.Recipe, isPinned: Bool) {
        self._recipe = recipe
        self.isPinned = isPinned
    }
}

struct AppStorage: Equatable {
    var parts = IdentifiedArray<String, Part>()
    var equipment = IdentifiedArray<String, Equipment>()
    var recipes = IdentifiedArray<String, Recipe>()
    var factories = [Factory]()
}

@Reducer
struct StorageReducer {
    @dynamicMemberLookup
    struct State: Equatable {
        var _appStorage = AppStorage()
        
        subscript<T>(dynamicMember keyPath: WritableKeyPath<AppStorage, T>) -> T {
            get { _appStorage[keyPath: keyPath] }
            set { _appStorage[keyPath: keyPath] = newValue }
        }
    }
    
    enum Action: Equatable {
        case togglePinForPart(Part)
        case togglePinForEquipment(Equipment)
        case togglePinForRecipe(Recipe)
        
        case part(Models.Part, isPinned: Bool)
        case equipmemt(Models.Equipment, isPinned: Bool)
        case recipe(Models.Recipe, isPinned: Bool)
    }
    
    @Dependency(\.storageClient) private var storageClient
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case let .togglePinForPart(part):
                return .run(priority: .userInitiated) { send in
                    let _part = part._part
                    await storageClient.setPartPinned(_part, !part.isPinned)
                    let newPinned = /*await*/ storageClient.isPinned(_part)
                    await send(.part(_part, isPinned: newPinned))
                }
                
            case let .togglePinForEquipment(equipment):
                return .run(priority: .userInitiated) { send in
                    let _equipment = equipment._equipment
                    await storageClient.setEquipmentPinned(_equipment, !equipment.isPinned)
                    let newPinned = /*await*/ storageClient.isPinned(_equipment)
                    await send(.equipmemt(_equipment, isPinned: newPinned))
                }

            case let .togglePinForRecipe(recipe):
                return .run(priority: .userInitiated) { send in
                    let _recipe = recipe._recipe
                    await storageClient.setRecipePinned(_recipe, !recipe.isPinned)
                    let newPinned = storageClient.isPinned(_recipe)
                    await send(.recipe(_recipe, isPinned: newPinned))
                }
                
            case let .part(_part, isPinned):
                state.parts[id: _part.id]?.isPinned = isPinned
//                if let index = state.parts.firstIndex(where: { $0.id == _part.id }) {
//                    state.parts[index].isPinned = isPinned
//                }
                return .none
                
            case let .equipmemt(_equipment, isPinned):
                state.equipment[id: _equipment.id]?.isPinned = isPinned
//                if let index = state.equipment.firstIndex(where: { $0.id == _equipment.id }) {
//                    state.equipment[index].isPinned = isPinned
//                }
                return .none
                
            case let .recipe(_recipe, isPinned):
                state.recipes[id: _recipe.id]?.isPinned = isPinned
//                if let index = state.recipes.firstIndex(where: { $0.id == _recipe.id }) {
//                    state.recipes[index].isPinned = isPinned
//                }
                return .none
            }
        }
    }
}

@Reducer
struct Root {
    struct State: Equatable {
        var storage = StorageReducer.State()
        
        var main: MainTabBarReducer.State?
    }
    
    enum Action: Equatable {
        enum View: Equatable {
            case task
        }
        
        enum Internal: Equatable {
            case loaded(parts: [Part], equipment: [Equipment], recipes: [Recipe], factories: [Factory])
            case error(description: String)
        }
        
        case view(View)
        case `internal`(Internal)
        
        // Scoped
        case storage(StorageReducer.Action)
        case main(MainTabBarReducer.Action)
    }
    
    @Dependency(\.storageClient) private var storageCilent
//    @Dependency(\.settingsClient) private var settingsClient
    
    var body: some ReducerOf<Self> {
        Scope(state: \.storage, action: \.storage) {
            StorageReducer()
        }
        
        Reduce { state, action in
            switch action {
            case let .view(viewAction): 
                return reduceView(into: &state, action: viewAction)
                
            case let .internal(internalAction): 
                return reduceInternal(into: &state, action: internalAction)
            
            // scoped
            case .storage, .main:
                return .none
            }
        }
        .ifLet(\.main, action: \.main) {
            MainTabBarReducer()
        }
    }
    
    private func reduceView(into state: inout State, action: Action.View) -> Effect<Action> {
        switch action {
        case .task:
            return .run(priority: .userInitiated) { send in
                try await storageCilent.load()
                
                /*async*/ let parts = storageCilent.parts().map {
                    Part($0, isPinned: storageCilent.isPinned($0))
                }
                
                /*async*/ let equipment = storageCilent.equipment().map {
                    Equipment($0, isPinned: storageCilent.isPinned($0))
                }
                
                /*async*/ let recipes = storageCilent.recipes().map {
                    Recipe($0, isPinned: storageCilent.isPinned($0))
                }
                
                /*async*/ let factories = storageCilent.factories()
                
                await send(.internal(.loaded(parts: parts, equipment: equipment, recipes: recipes, factories: factories)))
            } catch: { error, send in
                await send(.internal(.error(description: error.localizedDescription)))
            }
        }
    }
    
    private func reduceInternal(into state: inout State, action: Action.Internal) -> Effect<Action> {
        switch action {
        case let .loaded(parts, equipment, recipes, factories):
            state.storage.parts = IdentifiedArray(uniqueElements: parts)
            state.storage.equipment = IdentifiedArray(uniqueElements: equipment)
            state.storage.recipes = IdentifiedArray(uniqueElements: recipes)
            state.storage.factories = factories
            
            state.main = MainTabBarReducer.State(newProduction: NewProductionFeature.State(appStorage: state.storage._appStorage))
            return .none
            
        case let .error(errorDescription):
            print(errorDescription)
            return .none
        }
    }
}
