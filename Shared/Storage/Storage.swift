import SwiftUI

class Storage: ObservableObject {
    private var inMemoryStorage: InMemoryStorageProtocol
    private var persistentStorage: PersistentStorageProtocol
    
    var version: Int {
        get {
            (try? persistentStorage.load(VersionPersistent.self).first?.version) ?? 0
        }
        set {
            let version = VersionPersistent(version: newValue)
            do {
                try persistentStorage.save(version)
            } catch {
                fatalError("Could not save version!")
            }
        }
    }
    
    var parts: [Part] {
        get { inMemoryStorage.parts }
        set { inMemoryStorage.parts = newValue }
    }
    
    var equipments: [Equipment] {
        get { inMemoryStorage.equipments }
        set { inMemoryStorage.equipments = newValue }
    }
    
    var buildings: [Building] {
        get { inMemoryStorage.buildings }
        set { inMemoryStorage.buildings = newValue }
    }
    
    var recipes: [Recipe] {
        get { inMemoryStorage.recipes }
        set { inMemoryStorage.recipes = newValue }
    }
    
    var productionChains: [ProductionChain] {
        get { inMemoryStorage.productionChains }
        set { inMemoryStorage.productionChains = newValue }
    }
    
    init(
        inMemoryStorage: InMemoryStorageProtocol = InMemoryStorage(),
        persistentStorage: PersistentStorageProtocol = PersistentStorage()
    ) {
        self.inMemoryStorage = inMemoryStorage
        self.persistentStorage = persistentStorage
    }
    
    func save() {
        do {
            try saveVersion()
            
            try parts.forEach(save)
            try equipments.forEach(save)
            try buildings.forEach(save)
            try recipes.forEach(save)
            try productionChains.forEach(save)
        } catch {
            fatalError("Could not save! Error: \(error)")
        }
    }
    
    // MARK: - Internal save
    private func saveVersion() throws {
        let versionToSave = VersionPersistent(version: version)
        try persistentStorage.save(versionToSave)
    }
    
    private func save(part: Part) throws {
        let partToSave = PartPersistent(
            id: part.id,
            name: part.name,
            partType: part.partType.rawValue,
            tier: part.tier.rawValue,
            milestone: part.milestone,
            sortingPriority: part.sortingPriority,
            rawResource: part.rawResource,
            isFavorite: part.isPinned
        )
        try persistentStorage.save(partToSave)
    }
    
    private func save(equipment: Equipment) throws {
        let equipmentToSave = EquipmentPersistent(
            id: equipment.id,
            name: equipment.name,
            slot: equipment.slot.rawValue,
            fuel: equipment.fuel?.id,
            ammo: equipment.ammo?.id,
            consumes: equipment.consumes?.id,
            isFavorite: equipment.isPinned
        )
        try persistentStorage.save(equipmentToSave)
    }
    
    private func save(building: Building) throws {
        let buildingToSave = BuildingPersistent(
            id: building.id,
            name: building.name,
            buildingType: building.buildingType.rawValue,
            isFavorite: building.isPinned
        )
        try persistentStorage.save(buildingToSave)
    }
    
    private func save(recipe: Recipe) throws {
        let recipeToSave = RecipePersistent(
            id: recipe.id,
            name: recipe.name,
            input: recipe.input.map { input in
                RecipePersistent.RecipePart(id: input.id, amount: input.amount)
            },
            output: recipe.output.map { output in
                RecipePersistent.RecipePart(id: output.id, amount: output.amount)
            },
            machines: recipe.machines.map(\.id),
            duration: recipe.duration,
            isDefault: recipe.isDefault,
            isFavorite: recipe.isPinned
        )
        try persistentStorage.save(recipeToSave)
    }
    
    private func save(productionChain: ProductionChain) throws {
        let nodesToSave = productionChain.productionTree.arrayLevels.map { node in
            ProductionTreePersistent(
                id: node.element.id.uuidString,
                itemID: node.element.item.id,
                recipeID: node.element.recipe.id,
                children: node.children.map(\.element.id.uuidString)
            )
        }
        
        guard !nodesToSave.isEmpty else { return }
        
        let productionToSave = ProductionPersistent(
            productionTreeRootID: nodesToSave[0].id,
            amount: productionChain.amount,
            productionChain: nodesToSave
        )
        
        try persistentStorage.save(productionToSave)
    }
    
    private func save(item: Item) throws {
        if let part = item as? Part {
            try save(part: part)
        } else if let equipment = item as? Equipment {
            try save(equipment: equipment)
        } else if let building = item as? Building {
            try save(building: building)
        } else {
            enum SaveError: Error {
                case cannotSaveItemWithID(String)
            }
            
            throw SaveError.cannotSaveItemWithID(item.id)
        }
    }
    
    private func delete(productionChainID: String) throws {
        try persistentStorage.delete(ProductionPersistent.self, filename: productionChainID)
    }
    // MARK: -
    
    func load() {
        do {
            let loadedParts = try persistentStorage.load(PartPersistent.self)
            parts = loadedParts.map { part in
                Part(
                    id: part.id,
                    name: part.name,
                    partType: PartType(rawValue: part.partType)!,
                    tier: Tier(rawValue: part.tier)!,
                    milestone: part.milestone,
                    sortingPriority: part.sortingPriority,
                    rawResource: part.rawResource,
                    isPinned: part.isFavorite
                )
            }
            
            let loadedEquipments = try persistentStorage.load(EquipmentPersistent.self)
            equipments = loadedEquipments.map { equipment in
                Equipment(
                    id: equipment.id,
                    name: equipment.name,
                    slot: EquipmentSlot(rawValue: equipment.slot)!,
                    fuel: inMemoryStorage[partID: equipment.fuel ?? ""],
                    ammo: inMemoryStorage[partID: equipment.ammo ?? ""],
                    consumes: inMemoryStorage[partID: equipment.consumes ?? ""],
                    isPinned: equipment.isFavorite
                )
            }
            
            let loadedBuildings = try persistentStorage.load(BuildingPersistent.self)
            buildings = loadedBuildings.map { building in
                Building(
                    id: building.id,
                    name: building.name,
                    buildingType: BuildingType(rawValue: building.buildingType)!,
                    isPinned: building.isFavorite
                )
            }
            
            let loadedRecipes = try persistentStorage.load(RecipePersistent.self)
            recipes = loadedRecipes.compactMap { recipe in
                let input: [Recipe.RecipePart] = recipe.input.compactMap { input in
                    guard let inputItem = inMemoryStorage[itemID: input.id] else { return nil }
                    
                    return Recipe.RecipePart(item: inputItem, amount: input.amount)
                }
                
                let output: [Recipe.RecipePart] = recipe.output.compactMap { output in
                    guard let outputItem = inMemoryStorage[itemID: output.id] else { return nil }
                    
                    return Recipe.RecipePart(item: outputItem, amount: output.amount)
                }
                
                guard !input.isEmpty, !output.isEmpty else { return nil }
                
                return Recipe(
                    id: recipe.id,
                    name: recipe.name,
                    input: input,
                    output: output,
                    machines: recipe.machines.compactMap { inMemoryStorage[buildingID: $0] },
                    duration: recipe.duration,
                    isDefault: recipe.isDefault,
                    isPinned: recipe.isFavorite
                )
            }
            
            let loadedProductionChains = try persistentStorage.load(ProductionPersistent.self)
            
            productionChains = loadedProductionChains.compactMap { loadedProductionChain in
                let treeNodes: [RecipeTree] = loadedProductionChain.productionChain.compactMap { chain in
                    guard let item = self[itemID: chain.itemID],
                          let recipe = self[recipeID: chain.recipeID] else {
                        return nil
                    }
                    
                    return RecipeTree(id: UUID(uuidString: chain.id)!, item: item, recipe: recipe, amount: 0)
                }
                
                guard treeNodes.count == loadedProductionChain.productionChain.count else {
                    // This means saved production chain was using old parts or recipes
                    // so we can't load it
                    return nil
                }
                
                guard var root = treeNodes.first else {
                    // Just a safety measure for unpredicted results
                    return nil
                }
                
                root.element.amount = loadedProductionChain.amount
                loadedProductionChain.productionChain.forEach { loadedChain in
                    treeNodes.filter { node in
                        loadedChain.children.contains(where: { node.element.id.uuidString == $0 })
                    }.forEach {
                        root.add(child: $0) { check in
                            check.element.id.uuidString == loadedChain.id
                        }
                    }
                }
                
                return ProductionChain(productionTree: root)
            }
        } catch {
            fatalError("Could not load! Error: \(error)")
        }
    }
    
    subscript(itemID id: String) -> Item? {
        get {
            inMemoryStorage[itemID: id]
        }
        set {
            objectWillChange.send()
            
            inMemoryStorage[itemID: id] = newValue
            do {
                if let newValue = newValue {
                    try save(item: newValue)
                }
            } catch {
                fatalError("Could not save item! Error: \(error)")
            }
        }
    }
    
    subscript(partID id: String) -> Part? {
        get { inMemoryStorage[partID: id] }
        set {
            objectWillChange.send()
            
            inMemoryStorage[partID: id] = newValue
            do {
                if let newValue = newValue {
                    try save(part: newValue)
                }
            } catch {
                fatalError("Could not save part! Error: \(error)")
            }
        }
    }
    
    subscript(equipmentID id: String) -> Equipment? {
        get { inMemoryStorage[equipmentID: id] }
        set {
            objectWillChange.send()
            
            inMemoryStorage[equipmentID: id] = newValue
            do {
                if let newValue = newValue {
                    try save(equipment: newValue)
                }
            } catch {
                fatalError("Could not save equipment! Error: \(error)")
            }
        }
    }
    
    subscript(buildingID id: String) -> Building? {
        get { inMemoryStorage[buildingID: id] }
        set {
            objectWillChange.send()
            
            inMemoryStorage[buildingID: id] = newValue
            do {
                if let newValue = newValue {
                    try save(building: newValue)
                }
            } catch {
                fatalError("Could not save building! Error: \(error)")
            }
        }
    }
    
    subscript(recipeID id: String) -> Recipe? {
        get { inMemoryStorage[recipeID: id] }
        set {
            objectWillChange.send()
            
            inMemoryStorage[recipeID: id] = newValue
            do {
                if let newValue = newValue {
                    try save(recipe: newValue)
                }
            } catch {
                fatalError("Could not save recipe! Error: \(error)")
            }
        }
    }
    
    subscript(recipesFor id: String) -> [Recipe] {
        inMemoryStorage[recipesFor: id]
    }
    
    subscript(productionChainID id: String) -> ProductionChain? {
        get { inMemoryStorage[productionChainID: id] }
        set {
            do {
                objectWillChange.send()
                
                inMemoryStorage[productionChainID: id] = newValue
                
                if let newValue = newValue {
                    try save(productionChain: newValue)
                } else {
                    try delete(productionChainID: id)
                }
            } catch {
                fatalError("Could not save production chain! Error: \(error)")
            }
        }
    }
    
    subscript(productionChainsFor id: String) -> [ProductionChain] {
        inMemoryStorage.productionChains { chain in
            chain.id.hasPrefix(id)
        }
    }
}

class PreviewStorage: Storage {
    override init(
        inMemoryStorage: InMemoryStorageProtocol = InMemoryStorage(),
        persistentStorage: PersistentStorageProtocol = PersistentStorage()
    ) {
        super.init(inMemoryStorage: inMemoryStorage, persistentStorage: persistentStorage)
        
        load()
    }
    
    override func save() {
        // Preview should not save
    }
    
    override func load() {
        parts = Bundle.main.parts.map { part in
            Part(
                id: part.id,
                name: part.name,
                partType: PartType(rawValue: part.partType)!,
                tier: Tier(rawValue: part.tier)!,
                milestone: part.milestone,
                sortingPriority: part.sortingPriority,
                rawResource: part.rawResource,
                isPinned: false
            )
        }
        
        equipments = Bundle.main.equipments.map { equipment in
            Equipment(
                id: equipment.id,
                name: equipment.name,
                slot: EquipmentSlot(rawValue: equipment.slot)!,
                fuel: self[partID: equipment.fuel ?? ""],
                ammo: self[partID: equipment.ammo ?? ""],
                consumes: self[partID: equipment.consumes ?? ""],
                isPinned: false
            )
        }
        
        buildings = Bundle.main.buildings.map { building in
            Building(
                id: building.id,
                name: building.name,
                buildingType: BuildingType(rawValue: building.buildingType)!,
                isPinned: false
            )
        }
        
        recipes = Bundle.main.recipes.map { recipe in
            Recipe(
                id: recipe.id,
                name: recipe.name,
                input: recipe.input.map { input in
                    Recipe.RecipePart(item: self[itemID: input.id]!, amount: input.amount)
                },
                output: recipe.output.map { output in
                    Recipe.RecipePart(item: self[itemID: output.id]!, amount: output.amount)
                },
                machines: recipe.machines.compactMap { machine in
                    self[buildingID: machine]
                },
                duration: recipe.duration,
                isDefault: recipe.isDefault,
                isPinned: false
            )
        }
    }
}
