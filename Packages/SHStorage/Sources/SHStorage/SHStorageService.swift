import Foundation
import SHModels
import struct SHPersistentStorage.LoadOptions

public struct SHStorageService: Sendable {
    /// Loads storage. This should be called before any other call to storage is made.
    public var load: @Sendable (_ loadOptions: LoadOptions) throws -> Void
    
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
    
    public var streamProductions: @Sendable () -> AsyncStream<[Production]>
    
    public var saveFactory: @Sendable (_ factory: Factory) -> Void
    
    public var saveProduction: @Sendable (_ production: Production, _ factoryID: UUID) -> Void
    
    public var deleteFactory: @Sendable (_ factory: Factory) -> Void
    
    public var deleteProduction: @Sendable (_ production: Production) -> Void
    
    /// Fetch all parts from storage. This information is not changed during execution.
    public var parts: @Sendable () -> [Part]
    
    /// Fetch all equipment from storage. This data is constant.
    public var equipment: @Sendable () -> [Equipment]
    
    /// Fetch all buildings from storage. This data is constant.
    public var buildings: @Sendable () -> [Building]
    
    /// Fetch all recipes from storage. This data is constant.
    var recipes: @Sendable () -> [Recipe]
    
    /// Fetch all extractions from storage. This data is constant.
    var extractions: @Sendable () -> [Extraction]
    
    /// Changes pin status for a provided part ID.
    var changePartPinStatus: @Sendable (_ partID: String) -> Void
    
    /// Changes pin status for a provided equipment iD.
    var changeEquipmentPinStatus: @Sendable (_ equipmentID: String) -> Void
    
    /// /// Changes pin status for a provided recpe iD.
    var changeRecipePinStatus: @Sendable (_ recipeID: String) -> Void
}

public extension SHStorageService {
    // MARK: Items
    
    /// Fetch an item (part or equipment) with a provided ID.
    /// - Parameter id: An ID for an item.
    /// - Returns: An item with a provided ID or `nil` if there is no item with a provided ID.
    func item(id: String) -> (any Item)? {
        let items: [any Item] = parts() + equipment() + buildings()
        return items.first { $0.id == id }
    }
    
    func part(id: String) -> Part? {
        parts().first { $0.id == id }
    }
    
    func equipment(id: String) -> Equipment? {
        equipment().first { $0.id == id }
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
    
    /// Fetch all equipment that can be automated.
    ///
    /// An equipment can be automated if there is a recipe which produces this equipment (as an output or a byproduct) and this recipe can be set in any production machine.
    /// - Returns: An array of equipment which can be automated.
    func automatableEquipment() -> [Equipment] {
        equipment().filter { !recipes(for: $0, as: .output).filter { $0.machine != nil }.isEmpty }
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
    func recipes(for itemID: String, as role: Recipe.Ingredient.Role) -> [Recipe] {
        recipes().filter { recipe in
            switch role {
            case .output: recipe.output.item.id == itemID
            case .byproduct: recipe.byproducts.contains { $0.item.id == itemID }
            case .input: recipe.inputs.contains { $0.item.id == itemID }
            }
        }
    }
    
    /// Fetch recipes which has an item (part or equipment) with a provided ID as all of provided roles.
    /// - Parameters:
    ///   - itemID: An ID of an ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: An array of recipes.
    func recipes(for itemID: String, as roles: [Recipe.Ingredient.Role]) -> [Recipe] {
        roles.flatMap { recipes(for: itemID, as: $0) }
    }
    
    /// Fetch recipes which has a provided item (part or equipment) as a provided role.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - role: An ingredient role for an item.
    /// - Returns: An array of recipes.
    func recipes(for item: some Item, as role: Recipe.Ingredient.Role) -> [Recipe] {
        recipes(for: item.id, as: role)
    }
    
    /// Fetch recipes which has a provided item (part or equipment) as all of provided roles.
    /// - Parameters:
    ///   - item: An ingredient item.
    ///   - roles: Ingredient roles for an item.
    /// - Returns: An array of recipes.
    func recipes(for item: some Item, as roles: [Recipe.Ingredient.Role]) -> [Recipe] {
        recipes(for: item.id, as: roles)
    }
    
    // MARK: Pins
    /// Fetch all pinned part IDs.
    var pinnedPartIDs: Set<String> {
        pins().partIDs
    }
    
    /// Fetch all pinned equipment IDs.
    var pinnedEquipmentIDs: Set<String> {
        pins().equipmentIDs
    }
    
    /// Fetch all pinned item (part or equipment) IDs.
    var pinnedItemIDs: Set<String> {
        pinnedPartIDs.union(pinnedEquipmentIDs)
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
    
    /// Stream all pinned part IDs as an AsyncStream.
    var streamPinnedPartIDs: AsyncStream<Set<String>> {
        streamPins().map(\.partIDs).eraseToStream()
    }
    
    /// Stream all pinned equipment IDs as an AsyncStream.
    var streamPinnedEquipmentIDs: AsyncStream<Set<String>> {
        streamPins().map(\.equipmentIDs).eraseToStream()
    }
    
    /// Stream all pinned item (part or equipment) IDs as an AsyncStream.
    var streamPinnedItemIDs: AsyncStream<Set<String>> {
        streamPins()
            .map { $0.partIDs.union($0.equipmentIDs) }
            .eraseToStream()
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
    func isPinned(_ part: Part) -> Bool {
        pins().partIDs.contains(part.id)
    }
    
    /// Checks if a provided equipment is pinned.
    /// - Parameter equipment: An equipment to check.
    /// - Returns: `true` if equipment is pinned. Otherwise `false`.
    func isPinned(_ equipment: Equipment) -> Bool {
        pins().equipmentIDs.contains(equipment.id)
    }
    
    /// Checks if a provided recipe is pinned.
    /// - Parameter recipe: A recipe to check.
    /// - Returns: `true` if recipe is pinned. Otherwise `false`.
    func isPinned(_ recipe: Recipe) -> Bool {
        pins().recipeIDs.contains(recipe.id)
    }
    
    /// Checks if a provided item (part or equipment) is pinned.
    /// - Parameter item: An item to check
    /// - Returns: `true` if item is pinned. Otherwise `false`.
    func isPinned(_ item: some Item) -> Bool {
        if let part = item as? Part {
            isPinned(part)
        } else if let equipment = item as? Equipment {
            isPinned(equipment)
        } else {
            false
        }
    }
    
    /// Changes a pin status for a provided part.
    ///
    /// If provded part was pinned, it will be unpinned. If provided part was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for part: Part) {
        changePartPinStatus(part.id)
    }
    
    /// Changes a pin status for a provided equipmnet.
    ///
    /// If provded equipmnet was pinned, it will be unpinned. If provided equipmnet was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for equipment: Equipment) {
        changeEquipmentPinStatus(equipment.id)
    }
    
    /// Changes a pin status for a provided recipe.
    ///
    /// If provded recipe was pinned, it will be unpinned. If provided recipe was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for recipe: Recipe) {
        changeRecipePinStatus(recipe.id)
    }
    
    /// Changes a pin status for a provided item (part or equipment).
    ///
    /// If provded item was pinned, it will be unpinned. If provided item was not pinned, it will be pinned.
    /// - Parameter part: A part to pin/unpin.
    func changePinStatus(for item: any Item) {
        if let part = item as? Part {
            changePinStatus(for: part)
        } else if let equipment = item as? Equipment {
            changePinStatus(for: equipment)
        }
    }
    
    func produtions(inside factory: Factory) -> [Production] {
        productions().filter { factory.productionIDs.contains($0.id) }
    }
    
    func streamProductions(inside factory: Factory) -> AsyncStream<[Production]> {
        streamProductions()
            .map { $0.filter { factory.productionIDs.contains($0.id) } }
            .eraseToStream()
    }
    
    func extraction(for item: any Item) -> Extraction? {
        extractions().first { $0.naturalResources.contains { $0.id == item.id } }
    }
}
