import Models
import PersistentModels
import Dependencies

public extension StorageClient {
    static let live = {
        let live = Storage()
        
        return StorageClient(
            parts: {
                AsyncStream {
                    live.parts
                }
            },
            equipment: { live.equipment },
            buildings: { live.buildings },
            recipes: { live.recipes },
            factories: { live.factories },
            
            load: live.load,
            save: live.save,
            
            partWithID: { live[partID: $0] },
            equipmentWithID: { live[equipmentID: $0] },
            buildingWithID: { live[buildingID: $0] },
            itemWithID: { live[itemID: $0] },
            
            recipeWithID: { live[recipeID: $0] },
            recipesForItem: { item, role in live[recipesFor: item.id, role: role] },
            recipesForItemWithID: { itemID, role in live[recipesFor: itemID, role: role] },
            
            factoryWithID: { live[factoryID: $0] },
            productionWithID: { live[productionID: $0] },
            
            isPinned: { live[isPinned: $0.id] },
            
            isPartPinned: { part in live[isPartPinned: part.id] },
            setPartPinned: { part, isPinned in live[isPartPinned: part.id] = isPinned },
            
            isEquipmentPinned: { equipment in live[isEquipmentPinned: equipment.id] },
            setEquipmentPinned: { equipment, isPinned in live[isEquipmentPinned: equipment.id] = isPinned },
            
            isRecipePinned: { recipe in live[isRecipePinned: recipe.id] },
            setRecipePinned: { recipe, isPinned in live[isRecipePinned: recipe.id] = isPinned }
        )
    }()
    
    static let failing = StorageClient(
        parts: unimplemented("StorageClient.parts"),
        equipment: unimplemented("StorageClient.equipment"),
        buildings: unimplemented("StorageClient.buildings"),
        recipes: unimplemented("StorageClient.recipes"),
        factories: unimplemented("StorageClient.factories"),
        
        load: unimplemented("StorageClient.load"),
        save: unimplemented("StorageClient.save"),
        
        partWithID: unimplemented("StorageClient.partWithID"),
        equipmentWithID: unimplemented("StorageClient.equipmentWithID"),
        buildingWithID: unimplemented("StorageClient.buildingWithID"),
        itemWithID: unimplemented("StorageClient.itemWithID"),
        
        recipeWithID: unimplemented("StorageClient.recipeWithID"),
        recipesForItem: unimplemented("StorageClient.recipesForItem"),
        recipesForItemWithID: unimplemented("StorageClient.recipesForItemWithID"),
        
        factoryWithID: unimplemented("StorageClient.factoryWithID"),
        productionWithID: unimplemented("StorageClient.productionWithID"),
        
        isPinned: unimplemented("StorageClient.isPinned"),
        
        isPartPinned: unimplemented("StorageClient.isPartPinned"),
        setPartPinned: unimplemented("StorageClient.setPartPinned"),
        
        isEquipmentPinned: unimplemented("StorageClient.isEquipmentPinned"),
        setEquipmentPinned: unimplemented("StorageClient.setEquipmentPinned"),
        
        isRecipePinned: unimplemented("StorageClient.isRecipePinned"),
        setRecipePinned: unimplemented("StorageClient.setRecipePinned")
    )
    
    static let noop = StorageClient(
        parts: { .never },
        equipment: { [] },
        buildings: { [] },
        recipes: { [] },
        factories: { [] },
        
        load: {},
        save: {},
        
        partWithID: { _ in nil },
        equipmentWithID: { _ in nil },
        buildingWithID: { _ in nil },
        itemWithID: { _ in nil },
        
        recipeWithID: { _ in nil },
        recipesForItem: { _, _ in [] },
        recipesForItemWithID: { _, _ in [] },
        
        factoryWithID: { _ in nil },
        productionWithID: { _ in nil },
        
        isPinned: { _ in false },
        
        isPartPinned: { _ in false },
        setPartPinned: { _, _ in },
        
        isEquipmentPinned: { _ in false },
        setEquipmentPinned: { _, _ in },
        
        isRecipePinned: { _ in false },
        setRecipePinned: { _, _ in }
    )
    
    static func inMemory(
        parts: [Part] = [],
        equipment: [Equipment] = [],
        buildings: [Building] = [],
        recipes: [Recipe] = [],
        factories: [Factory] = [],
        pins: Pins.Persistent.V2 = Pins.Persistent.V2()
    ) -> StorageClient {
        let inMemory = InMemory(
            parts: parts,
            equipment: equipment,
            buildings: buildings,
            recipes: recipes,
            factories: factories,
            pins: pins
        )
        
        return StorageClient(
            parts: { AsyncStream { inMemory.parts } },
            equipment: { inMemory.equipment },
            buildings: { inMemory.buildings },
            recipes: { inMemory.recipes },
            factories: { inMemory.factories },
            
            load: { },
            save: { },
            
            partWithID: { inMemory.parts.first(id: $0) },
            equipmentWithID: { inMemory.equipment.first(id: $0) },
            buildingWithID: { inMemory.buildings.first(id: $0) },
            itemWithID: { inMemory.parts.first(id: $0) ?? inMemory.equipment.first(id: $0) ?? inMemory.buildings.first(id: $0) },
            
            recipeWithID: { inMemory.recipes.first(id: $0) },
            recipesForItem: { item, role in inMemory.recipes.filter(for: item.id, role: role) },
            recipesForItemWithID: { itemID, role in inMemory.recipes.filter(for: itemID, role: role) },
            
            factoryWithID: { inMemory.factories.first(id: $0) },
            productionWithID: { inMemory.factories.flatMap(\.productions).first(id: $0) },
            
            isPinned: { inMemory.pins.partIDs.contains($0.id) || inMemory.pins.equipmentIDs.contains($0.id) || inMemory.pins.recipeIDs.contains($0.id) },
            
            isPartPinned: { inMemory.pins.partIDs.contains($0.id) },
            setPartPinned: { part, pinned in
                if pinned {
                    inMemory.pins.partIDs.insert(part.id)
                } else {
                    inMemory.pins.partIDs.remove(part.id)
                }
            },
            
            isEquipmentPinned: { inMemory.pins.equipmentIDs.contains($0.id) },
            setEquipmentPinned: { equipment, pinned in
                if pinned {
                    inMemory.pins.equipmentIDs.insert(equipment.id)
                } else {
                    inMemory.pins.equipmentIDs.remove(equipment.id)
                }
            },
            
            isRecipePinned: { inMemory.pins.recipeIDs.contains($0.id) },
            setRecipePinned: { recipe, pinned in
                if pinned {
                    inMemory.pins.recipeIDs.insert(recipe.id)
                } else {
                    inMemory.pins.recipeIDs.remove(recipe.id)
                }
            }
        )
    }
    
    static let preview: StorageClient = {
        let preview = Preview()
        
        return StorageClient(
            parts: { AsyncStream { preview.parts } },
            equipment: { preview.equipment },
            buildings: { preview.buildings },
            recipes: { preview.recipes },
            factories: { preview.factories },
            
            load: { },
            save: { },
            
            partWithID: { preview[partID: $0] },
            equipmentWithID: { preview[equipmentID: $0] },
            buildingWithID: { preview[buildingID: $0] },
            itemWithID: { preview[itemID: $0] },
            
            recipeWithID: { preview[recipeID: $0] },
            recipesForItem: { preview[recipesFor: $0.id, role: $1] },
            recipesForItemWithID: { preview[recipesFor: $0, role: $1] },
            
            factoryWithID: { preview[factoryID: $0] },
            productionWithID: { preview[productionID: $0] },
            
            isPinned: { preview[isPinned: $0.id] },
            
            isPartPinned: { preview[isPartPinned: $0.id] },
            setPartPinned: { preview[isPartPinned: $0.id] = $1 },
            
            isEquipmentPinned: { preview[isEquipmentPinned: $0.id] },
            setEquipmentPinned: { preview[isEquipmentPinned: $0.id] = $1 },
            
            isRecipePinned: { preview[isRecipePinned: $0.id] },
            setRecipePinned: { preview[isRecipePinned: $0.id] = $1 }
        )
    }()
}
