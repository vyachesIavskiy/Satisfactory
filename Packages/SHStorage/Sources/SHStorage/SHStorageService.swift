import SHModels

public struct SHStorageService: Sendable {
    public var load: @Sendable () throws -> Void
    
    public var staticConfiguration: @Sendable () -> Configuration
    public var persistentConfiguration: @Sendable () -> Configuration
    
    public var parts: @Sendable () -> [Part]
    public var equipment: @Sendable () -> [Equipment]
    public var buildings: @Sendable () -> [Building]
    public var recipes: @Sendable () -> [Recipe]
    
    public var streamPinnedPartIDs: @Sendable () -> AsyncStream<Set<String>>
    public var streamPinnedEquipmentIDs: @Sendable () -> AsyncStream<Set<String>>
    public var streamPinnedRecipeIDs: @Sendable () -> AsyncStream<Set<String>>
    
    public var pinnedPartIDs: @Sendable () -> Set<String>
    public var pinnedEquipmentIDs: @Sendable () -> Set<String>
    public var pinnedRecipeIDs: @Sendable () -> Set<String>
    
    public var isPartPinned: @Sendable (_ partID: String) -> Bool
    public var isEquipmentPinned: @Sendable (_ equipmentID: String) -> Bool
    public var isRecipePinned: @Sendable (_ recipeID: String) -> Bool
    
    public var changePartPinStatus: @Sendable (_ partID: String) -> Void
    public var changeEquipmentPinStatus: @Sendable (_ equipmentID: String) -> Void
    public var changeRecipePinStatus: @Sendable (_ recipeID: String) -> Void
}

public extension SHStorageService {
    func item(for id: String) -> (any Item)? {
        let items: [any Item] = parts() + equipment()
        return items.first { $0.id == id }
    }
    
    func automatableParts() -> [Part] {
        parts().filter { !recipes(for: $0, as: .output).filter { $0.machine != nil }.isEmpty }
    }
    
    func automatableEquipment() -> [Equipment] {
        equipment().filter { !recipes(for: $0, as: .output).filter { $0.machine != nil }.isEmpty }
    }
    
    func recipes(for itemID: String, as role: Recipe.Ingredient.Role) -> [Recipe] {
        recipes().filter { recipe in
            switch role {
            case .output: recipe.output.item.id == itemID
            case .byproduct: recipe.byproducts.contains { $0.item.id == itemID }
            case .input: recipe.input.contains { $0.item.id == itemID }
            }
        }
    }
    
    func recipes(for itemID: String, as roles: Recipe.Ingredient.Role...) -> [Recipe] {
        roles.flatMap { recipes(for: itemID, as: $0) }
    }
    
    func recipes(for item: any Item, as role: Recipe.Ingredient.Role) -> [Recipe] {
        recipes(for: item.id, as: role)
    }
    
    func recipes(for item: any Item, as roles: Recipe.Ingredient.Role...) -> [Recipe] {
        roles.flatMap { recipes(for: item, as: $0) }
    }
    
    func isPartPinned(part: Part) -> Bool {
        isPartPinned(part.id)
    }
    
    func isEquipmentPinned(equipment: Equipment) -> Bool {
        isEquipmentPinned(equipment.id)
    }
    
    func isRecipePinned(_ recipe: Recipe) -> Bool {
        isRecipePinned(recipe.id)
    }
    
    func isPinned(item: any Item) -> Bool {
        isPartPinned(item.id) || isEquipmentPinned(item.id)
    }
    
    func changePartPinStatus(_ part: Part) {
        changePartPinStatus(part.id)
    }
    
    func changeEquipmentPinStatus(_ equipment: Equipment) {
        changeEquipmentPinStatus(equipment.id)
    }
    
    func changeRecipePinStatus(_ recipe: Recipe) {
        changeRecipePinStatus(recipe.id)
    }
    
    func changeItemPinStatus(_ item: any Item) {
        if let part = item as? Part {
            changePartPinStatus(part)
        } else if let equipment = item as? Equipment {
            changeEquipmentPinStatus(equipment)
        }
    }
}
