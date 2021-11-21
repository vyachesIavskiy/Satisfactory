import SwiftUI

class BaseStorage: ObservableObject {
    var version = 0
    @Published var parts = [Part]()
    @Published var equipments = [Equipment]()
    @Published var buildings = [Building]()
    @Published var vehicles = [Vehicle]()
    @Published var recipes = [Recipe]()
    @Published var productionChains = [ProductionChain]()
    
    func save() {
        fatalError("Should be overriden")
    }
    
    func load() {
        fatalError("Should be overriden")
    }
    
    subscript(itemID id: String) -> Item? {
        fatalError("Should be overriden")
    }
    
    subscript(partID id: String) -> Part? {
        get {
            fatalError("Should be overriden")
        }
        set {
            
        }
    }
    
    subscript(equipmentID id: String) -> Equipment? {
        get {
            fatalError("Should be overriden")
        }
        set {
            
        }
    }
    
    subscript(buildingID id: String) -> Building? {
        get {
            fatalError("Should be overriden")
        }
        set {
            
        }
    }
    
    subscript(vehicleID id: String) -> Vehicle? {
        get {
            fatalError("Should be overriden")
        }
        set {
            
        }
    }
    
    subscript(recipeID id: String) -> Recipe? {
        get {
            fatalError("Should be overriden")
        }
        set {
            
        }
    }
    
    subscript(recipesFor id: String) -> [Recipe] {
        fatalError("Should be overriden")
    }
    
    subscript(productionChainID id: String) -> ProductionChain? {
        get {
            fatalError("Should be overriden")
        }
        set {
            
        }
    }
    
    subscript(productionChainsFor id: String) -> [ProductionChain] {
        fatalError("Should be overriden")
    }
}

class Storage: BaseStorage {
    var inMemoryStorage: InMemoryStorageProtocol
    var persistentStorage: PersistentStorageProtocol
    
    override var version: Int {
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
    
    override var parts: [Part] {
        get { inMemoryStorage.parts }
        set { inMemoryStorage.parts = newValue }
    }
    
    override var equipments: [Equipment] {
        get { inMemoryStorage.equipments }
        set { inMemoryStorage.equipments = newValue }
    }
    
    override var buildings: [Building] {
        get { inMemoryStorage.buildings }
        set { inMemoryStorage.buildings = newValue }
    }
    
    override var vehicles: [Vehicle] {
        get { inMemoryStorage.vehicles }
        set { inMemoryStorage.vehicles = newValue }
    }
    
    override var recipes: [Recipe] {
        get { inMemoryStorage.recipes }
        set { inMemoryStorage.recipes = newValue }
    }
    
    override var productionChains: [ProductionChain] {
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
    
    override func save() {
        do {
            try saveVersion()
            
            try parts.forEach(save)
            try equipments.forEach(save)
            try buildings.forEach(save)
            try vehicles.forEach(save)
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
            isFavorite: part.isFavorite
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
            isFavorite: equipment.isFavorite
        )
        try persistentStorage.save(equipmentToSave)
    }
    
    private func save(building: Building) throws {
        let buildingToSave = BuildingPersistent(
            id: building.id,
            name: building.name,
            buildingType: building.buildingType.rawValue,
            isFavorite: building.isFavorite
        )
        try persistentStorage.save(buildingToSave)
    }
    
    private func save(vehicle: Vehicle) throws {
        let vehicleToSave = VehiclePersistent(
            id: vehicle.id,
            name: vehicle.name,
            fuel: vehicle.fuel.map(\.id),
            isFavorite: vehicle.isFavorite
        )
        try persistentStorage.save(vehicleToSave)
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
            isFavorite: recipe.isFavorite
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
    
    private func delete(productionChainID: String) throws {
        try persistentStorage.delete(ProductionPersistent.self, filename: productionChainID)
    }
    // MARK: -
    
    override func load() {
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
                    isFavorite: inMemoryStorage[partID: part.id]?.isFavorite == true
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
                    isFavorite: inMemoryStorage[equipmentID: equipment.id]?.isFavorite == true
                )
            }
            
            let loadedBuildings = try persistentStorage.load(BuildingPersistent.self)
            buildings = loadedBuildings.map { building in
                Building(
                    id: building.id,
                    name: building.name,
                    buildingType: BuildingType(rawValue: building.buildingType)!,
                    isFavorite: inMemoryStorage[buildingID: building.id]?.isFavorite == true
                )
            }
            
            let loadedVehicles = try persistentStorage.load(VehiclePersistent.self)
            vehicles = loadedVehicles.map { vehicle in
                Vehicle(
                    id: vehicle.id,
                    name: vehicle.name,
                    fuel: vehicle.fuel.compactMap { inMemoryStorage[partID: $0] },
                    isFavorite: inMemoryStorage[vehicleID: vehicle.id]?.isFavorite == true
                )
            }
            
            let loadedRecipes = try persistentStorage.load(RecipePersistent.self)
            recipes = loadedRecipes.map { recipe in
                Recipe(
                    id: recipe.id,
                    name: recipe.name,
                    input: recipe.input.map { input in
                        Recipe.RecipePart(item: inMemoryStorage[itemID: input.id]!, amount: input.amount)
                    },
                    output: recipe.output.map { output in
                        Recipe.RecipePart(item: inMemoryStorage[itemID: output.id]!, amount: output.amount)
                    },
                    machines: recipe.machines.compactMap { inMemoryStorage[buildingID: $0] },
                    duration: recipe.duration,
                    isDefault: recipe.isDefault,
                    isFavorite: recipe.isFavorite
                )
            }
            
            let loadedProductionChains = try persistentStorage.load(ProductionPersistent.self)
            
            productionChains = loadedProductionChains.map { loadedProductionChain in
                let treeNodes: [RecipeTree] = loadedProductionChain.productionChain.map { chain in
                    let item = self[itemID: chain.itemID]!
                    let recipe = self[recipeID: chain.recipeID]!
                    return RecipeTree(id: UUID(uuidString: chain.id)!, item: item, recipe: recipe, amount: 0)
                }
                var root = treeNodes.first!
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
            
            print(productionChains)
        } catch {
            fatalError("Could not load! Error: \(error)")
        }
    }
    
    override subscript(itemID id: String) -> Item? {
        inMemoryStorage[itemID: id]
    }
    
    override subscript(partID id: String) -> Part? {
        get { inMemoryStorage[partID: id] }
        set {
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
    
    override subscript(equipmentID id: String) -> Equipment? {
        get { inMemoryStorage[equipmentID: id] }
        set {
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
    
    override subscript(buildingID id: String) -> Building? {
        get { inMemoryStorage[buildingID: id] }
        set {
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
    
    override subscript(vehicleID id: String) -> Vehicle? {
        get { inMemoryStorage[vehicleID: id] }
        set {
            inMemoryStorage[vehicleID: id] = newValue
            do {
                if let newValue = newValue {
                    try save(vehicle: newValue)
                }
            } catch {
                fatalError("Could not save vehicle! Error: \(error)")
            }
        }
    }
    
    override subscript(recipeID id: String) -> Recipe? {
        get { inMemoryStorage[recipeID: id] }
        set {
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
    
    override subscript(recipesFor id: String) -> [Recipe] {
        inMemoryStorage[recipesFor: id]
    }
    
    override subscript(productionChainID id: String) -> ProductionChain? {
        get { inMemoryStorage[productionChainID: id] }
        set {
            do {
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
    
    override subscript(productionChainsFor id: String) -> [ProductionChain] {
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
                isFavorite: false
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
                isFavorite: false
            )
        }
        
        buildings = Bundle.main.buildings.map { building in
            Building(
                id: building.id,
                name: building.name,
                buildingType: BuildingType(rawValue: building.buildingType)!,
                isFavorite: false
            )
        }
        
        vehicles = Bundle.main.vehicles.map { vehicle in
            Vehicle(
                id: vehicle.id,
                name: vehicle.name,
                fuel: vehicle.fuel.compactMap { self[partID: $0] },
                isFavorite: false
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
                isFavorite: false
            )
        }
    }
}
