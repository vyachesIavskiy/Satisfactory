import Foundation
import Dependencies
import SHModels
import SHPersistentModels

public struct StorageClient {
    public var parts: @Sendable () -> [Part]
    public var equipment: @Sendable () -> [Equipment]
    public var buildings: @Sendable () -> [Building]
    public var recipes: @Sendable () -> [Recipe]
    public var factories: @Sendable () -> [Factory]
    
    public var load: @Sendable () async throws -> Void
    public var save: @Sendable () async throws -> Void
    
    public var partWithID: @Sendable (_ id: String) -> Part?
    public var equipmentWithID: @Sendable (_ id: String) -> Equipment?
    public var buildingWithID: @Sendable (_ id: String) -> Building?
    public var itemWithID: @Sendable (_ id: String) -> (any Item)?
    
    public var recipeWithID: @Sendable (_ id: String) -> Recipe?
    public var recipesForItem: @Sendable (_ item: any Item, _ role: Recipe.Ingredient.Role) -> [Recipe]
    public var recipesForItemWithID: @Sendable (_ id: String, _ role: Recipe.Ingredient.Role) -> [Recipe]
    
    public var factoryWithID: @Sendable (_ id: UUID) -> Factory?
    public var productionWithID: @Sendable (_ id: UUID) -> Production?
    
    public var isPartPinned: @Sendable (_ part: Part) -> Bool
    public var setPartPinned: @Sendable (_ part: Part, _ pinned: Bool) async -> Void
    
    public var isEquipmentPinned: @Sendable (_ equipment: Equipment) -> Bool
    public var setEquipmentPinned: @Sendable (_ equipment: Equipment, _ pinned: Bool) async -> Void
    
    public var isRecipePinned: @Sendable (_ recipe: Recipe) -> Bool
    public var setRecipePinned: @Sendable (_ recipe: Recipe, _ isPinned: Bool) async -> Void
    
    public var pinsStream: @Sendable () -> AsyncStream<Void>
}
