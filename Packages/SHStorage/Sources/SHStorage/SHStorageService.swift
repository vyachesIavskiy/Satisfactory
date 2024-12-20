import Foundation
import SHModels

public struct SHStorageService: Sendable {
    /// Loads storage. This should be called before any other call to storage is made.
    public var load: @Sendable () throws -> Void
    
    /// Fetch a static configuration for a storage. This information is not changed during execution.
    public var staticConfiguration: @Sendable () -> Configuration
    
    /// Fetch a persistent configuration for a storage. This information is not changed during execution.
    public var persistentConfiguration: @Sendable () -> Configuration
    
    /// Fetch all pins (parts, equipment and recipes) from storage.
    public var pins: @Sendable () -> Pins
    
    /// Stream for any changes done to pins in a storage.
    public var streamPins: @Sendable () -> AsyncStream<Pins>
    
    public var factories: @Sendable () -> [Factory]
    
    public var streamFactories: @Sendable () -> AsyncStream<[Factory]>
    
    public var productions: @Sendable () -> [Production]
    
    public var productionsInside: @Sendable (_ factory: Factory) -> [Production]
    
    public var streamProductions: @Sendable () -> AsyncStream<[Production]>
    
    public var streamProductionsInside: @Sendable (_ factory: Factory) -> AsyncStream<[Production]>
    
    public var saveFactory: @Sendable (_ factory: Factory) -> Void
    
    public var saveProduction: @Sendable (_ production: Production, _ factoryID: UUID) -> Void
    
    public var saveProductionInformation: @Sendable (_ production: Production, _ factoryID: UUID) -> Void
    
    public var saveProductionContent: @Sendable (_ production: Production) -> Void
    
    public var deleteFactory: @Sendable (_ factory: Factory) -> Void
    
    public var deleteProduction: @Sendable (_ production: Production) -> Void
    
    public var moveFactories: @Sendable (_ fromOffsets: IndexSet, _ toOffsets: Int) -> Void
    
    public var moveProductions: @Sendable (_ factory: Factory, _ fromOffsets: IndexSet, _ toOffset: Int) -> Void
    
    /// Fetch all parts from storage. This information is not changed during execution.
    public var parts: @Sendable () -> [Part]
    
    /// Fetch all buildings from storage. This data is constant.
    public var buildings: @Sendable () -> [Building]
    
    /// Fetch all recipes from storage. This data is constant.
    var recipes: @Sendable () -> [Recipe]
    
    /// Fetch all extractions from storage. This data is constant.
    var extractions: @Sendable () -> [Extraction]
    
    /// Changes pin status for a provided part ID.
    var changePartPinStatus: @Sendable (_ partID: String, _ productionType: ProductionType) -> Void
    
    /// Changes pin status for a provided building iD.
    var changeBuildingPinStatus: @Sendable (_ buildingID: String, _ productionType: ProductionType) -> Void
    
    /// /// Changes pin status for a provided recpe iD.
    var changeRecipePinStatus: @Sendable (_ recipeID: String) -> Void
}

public extension SHStorageService {
    // MARK: Items
    
    /// Fetch an item (part or equipment) with a provided ID.
    /// - Parameter id: An ID for an item.
    /// - Returns: An item with a provided ID or `nil` if there is no item with a provided ID.
    func item(id: String) -> (any Item)? {
        let items: [any Item] = parts() + buildings()
        return items.first { $0.id == id }
    }
    
    func part(id: String) -> Part? {
        parts().first { $0.id == id }
    }
    
    func building(id: String) -> Building? {
        buildings().first { $0.id == id }
    }
    
    /// Fetch all parts that can be automated.
    ///
    /// A part can be automated if there is a recipe which produces this part (as an output or a byproduct) and this recipe can be set in any production machine.
    /// - Returns: An array of parts which can be automated.
    func automatableParts() -> [Part] {
        parts().filter { !recipes(for: $0, as: .output).filter { $0.machine != nil }.isEmpty }
    }
    
    // MARK: Recipes
    /// Fetch a recipe with a provided ID.
    /// - Parameter id: An ID for an recipe.
    /// - Returns: A recipe with a provided ID or `nil` if there is no recipe with a provided ID.
    func recipe(id: String) -> Recipe? {
        recipes().first(id: id)
    }
    
    /// Fetch recipes which has an item (part or equipment) with a provided ID as a provided role.
    /// - Parameters:
    ///   - itemID: An ID of an ingredient item.
    ///   - role: An ingredient role for an item.
    /// - Returns: An array of recipes.
    func recipes(for partID: String, as role: Recipe.Ingredient.Role) -> [Recipe] {
        recipes().filter { recipe in
            switch role {
            case .output: recipe.output.part.id == partID
            case .byproduct: recipe.byproducts.contains { $0.part.id == partID }
            case .input: recipe.inputs.contains { $0.part.id == partID }
            }
        }
    }
    
    /// Fetch recipes which has an item (part or equipment) with a provided ID as all of provided roles.
    /// - Parameters:
    ///   - itemID: An ID of an ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: An array of recipes.
    func recipes(for partID: String, as roles: [Recipe.Ingredient.Role]) -> [Recipe] {
        roles.flatMap { recipes(for: partID, as: $0) }
    }
    
    /// Fetch recipes which has a provided item (part or equipment) as a provided role.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - role: An ingredient role for an item.
    /// - Returns: An array of recipes.
    func recipes(for part: Part, as role: Recipe.Ingredient.Role) -> [Recipe] {
        recipes(for: part.id, as: role)
    }
    
    /// Fetch recipes which has a provided item (part or equipment) as all of provided roles.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: An array of recipes.
    func recipes(for part: Part, as roles: [Recipe.Ingredient.Role]) -> [Recipe] {
        recipes(for: part.id, as: roles)
    }
    
    // MARK: Pins
    /// Fetch Single Item pinned part IDs.
    var pinnedSingleItemPartIDs: Set<String> {
        pins().singleItemPartIDs
    }
    
    /// Fetch From Resources pinned part IDs.
    var pinnedFromResourcesPartIDs: Set<String> {
        pins().fromResourcesPartIDs
    }
    
    /// Fetch Power pinned part IDs.
    var pinnedPowerPartIDs: Set<String> {
        pins().power.partIDs
    }
    
    /// Fetch Power pinned building IDs.
    var pinnedPowerBuildingIDs: Set<String> {
        pins().power.buildingIDs
    }
    
    /// Fetch all pinned recipe IDs which has an item (part or equipment) with provided ID as a provided role.
    /// - Parameters:
    ///   - itemID: An ID of an ingredient item.
    ///   - role: An ingredient role for an item.
    /// - Returns: A set of pinned recipe IDs.
    func pinnedRecipeIDs(for itemID: String, as role: Recipe.Ingredient.Role) -> Set<String> {
        let recipes = recipes(for: itemID, as: role)
        return pins().recipeIDs.filter { recipeID in
            recipes.contains { $0.id == recipeID }
        }
    }
    
    /// Fetch all pinned recipe IDs which has an item (part or equipment) with provided ID as a provided role.
    /// - Parameters:
    ///   - itemID: An ID of an ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: A set of pinned recipe IDs.
    func pinnedRecipeIDs(for itemID: String, as roles: [Recipe.Ingredient.Role]) -> Set<String> {
        roles.reduce(into: Set<String>()) { partialResult, role in
            partialResult.formUnion(pinnedRecipeIDs(for: itemID, as: role))
        }
    }
    
    /// Fetch all pinned recipe IDs which has a provided item (part or equipment) as a provided role.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - role: An ingredient role for an item.
    /// - Returns: A set of pinned recipe IDs.
    func pinnedRecipeIDs(for item: some Item, as role: Recipe.Ingredient.Role) -> Set<String> {
        pinnedRecipeIDs(for: item.id, as: role)
    }
    
    /// Fetch all pinned recipe IDs which has a provided item (part or equipment) as a provided role.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: A set of pinned recipe IDs.
    func pinnedRecipeIDs(for item: some Item, as roles: [Recipe.Ingredient.Role]) -> Set<String> {
        pinnedRecipeIDs(for: item.id, as: roles)
    }
    
    /// Stream Single Item pinned part IDs as an AsyncStream.
    var streamPinnedSingleItemPartIDs: AsyncStream<Set<String>> {
        streamPins().map(\.singleItemPartIDs).eraseToStream()
    }
    
    /// Stream From Resources pinned part IDs as an AsyncStream.
    var streamPinnedFromResourcesPartIDs: AsyncStream<Set<String>> {
        streamPins().map(\.fromResourcesPartIDs).eraseToStream()
    }
    
    /// Stream Power pinned part IDs as an AsyncStream.
    var streamPinnedPowerPartIDs: AsyncStream<Set<String>> {
        streamPins().map(\.power.partIDs).eraseToStream()
    }
    
    /// Stream Power pinned building IDs as an AsyncStream.
    var streamPinnedPowerBuildingIDs: AsyncStream<Set<String>> {
        streamPins().map(\.power.buildingIDs).eraseToStream()
    }
    
    /// Stream all pinned recipe IDs which has an item (part or equipment) with provided ID as a provided role.
    /// - Parameters:
    ///   - itemID: An ID of an ingredient item.
    ///   - role: An ingredient role for an item.
    /// - Returns: An AsyncStream of pinned recipe IDs.
    func streamPinnedRecipeIDs(for itemID: String, as role: Recipe.Ingredient.Role) -> AsyncStream<Set<String>> {
        streamPins()
            .map { pins in
                let recipes = recipes(for: itemID, as: role)
                return pins.recipeIDs.filter { recipeID in
                    recipes.contains { $0.id == recipeID }
                }
            }
            .eraseToStream()
    }
    
    /// Stream all pinned recipe IDs which has an item (part or equipment) with provided ID as a provided role.
    /// - Parameters:
    ///   - itemID: An ID of an ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: An AsyncStream of pinned recipe IDs.
    func streamPinnedRecipeIDs(for itemID: String, as roles: [Recipe.Ingredient.Role]) -> AsyncStream<Set<String>> {
        streamPins()
            .map { pins in
                let recipes = recipes(for: itemID, as: roles)
                return pins.recipeIDs.filter { recipeID in
                    recipes.contains { $0.id == recipeID }
                }
            }
            .eraseToStream()
    }
    
    /// Stream all pinned recipe IDs which has a provided item (part or equipment) as a provided role.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - role: An ingredient role for an item.
    /// - Returns: An AsyncStream of pinned recipe IDs.
    func streamPinnedRecipeIDs(for item: some Item, as role: Recipe.Ingredient.Role) -> AsyncStream<Set<String>> {
        streamPinnedRecipeIDs(for: item.id, as: role)
    }
    
    /// Stream all pinned recipe IDs which has a provided item (part or equipment) as a provided role.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: An AsyncStream of pinned recipe IDs.
    func streamPinnedRecipeIDs(for item: some Item, as roles: [Recipe.Ingredient.Role]) -> AsyncStream<Set<String>> {
        streamPinnedRecipeIDs(for: item.id, as: roles)
    }
    
    /// Checks if a provided part is pinned.
    /// - Parameter part: A part to check.
    /// - Returns: `true` if part is pinned. Otherwise `false`.
    func isPinned(_ part: Part, productionType: ProductionType) -> Bool {
        pins().isPinned(partID: part.id, productionType: productionType)
    }
    
    /// Checks if a provided building is pinned.
    /// - Parameter building: A building to check.
    /// - Returns: `true` if building is pinned. Otherwise `false`.
    func isPinned(_ building: Building, productionType: ProductionType) -> Bool {
        pins().isPinned(buildingID: building.id, productionType: productionType)
    }
    
    /// Checks if a provided item (part or equipment) is pinned.
    /// - Parameter item: An item to check
    /// - Returns: `true` if item is pinned. Otherwise `false`.
    func isPinned(_ item: some Item, productionType: ProductionType) -> Bool {
        if let part = item as? Part {
            isPinned(part, productionType: productionType)
        } else if let building = item as? Building {
            isPinned(building, productionType: productionType)
        } else {
            false
        }
    }
    
    /// Checks if a provided recipe is pinned.
    /// - Parameter recipe: A recipe to check.
    /// - Returns: `true` if recipe is pinned. Otherwise `false`.
    func isPinned(_ recipe: Recipe) -> Bool {
        pins().recipeIDs.contains(recipe.id)
    }
    
    /// Changes a pin status for a provided part.
    ///
    /// If provded part was pinned, it will be unpinned. If provided part was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for part: Part, productionType: ProductionType) {
        changePartPinStatus(part.id, productionType)
    }
    
    /// Changes a pin status for a provided building.
    ///
    /// If provded building was pinned, it will be unpinned. If provided building was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for building: Building, productionType: ProductionType) {
        changeBuildingPinStatus(building.id, productionType)
    }
    
    /// Changes a pin status for a provided item (part or equipment).
    ///
    /// If provded item was pinned, it will be unpinned. If provided item was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for item: any Item, productionType: ProductionType) {
        if let part = item as? Part {
            changePinStatus(for: part, productionType: productionType)
        } else if let building = item as? Building {
            changePinStatus(for: building, productionType: productionType)
        }
    }
    
    /// Changes a pin status for a provided recipe.
    ///
    /// If provded recipe was pinned, it will be unpinned. If provided recipe was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for recipe: Recipe) {
        changeRecipePinStatus(recipe.id)
    }
    
    func factory(id: UUID) -> Factory? {
        factories().first(id: id)
    }
    
    func production(id: UUID) -> Production? {
        productions().first(id: id)
    }
    
    func factoryID(for production: Production) -> UUID? {
        factories().first { $0.productionIDs.contains(production.id) }?.id
    }
    
    func factory(for production: Production) -> Factory? {
        factoryID(for: production).flatMap(factory(id:))
    }
    
    func extraction(for item: any Item) -> Extraction? {
        extractions().first { $0.naturalResources.contains { $0.id == item.id } }
    }
}
