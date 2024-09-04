
public struct Pins: Equatable, Sendable {
    public var singleItem: SingleItem
    public var fromResources: FromResources
    public var power: Power
    public var recipeIDs: Set<String>
    
    public var isEmpty: Bool {
        singleItem.isEmpty && fromResources.isEmpty && recipeIDs.isEmpty
    }
    
    public init(
        singleItem: SingleItem = SingleItem(),
        fromResources: FromResources = FromResources(),
        power: Power = Power(),
        recipeIDs: Set<String> = []
    ) {
        self.singleItem = singleItem
        self.fromResources = fromResources
        self.power = power
        self.recipeIDs = recipeIDs
    }
    
    public func isPinned(partID: String, productionType: ProductionType) -> Bool {
        switch productionType {
        case .singleItem: singleItem.isPinned(partID: partID)
        case .fromResources: fromResources.isPinned(partID: partID)
        case .power: power.isPinned(partID: partID)
        }
    }
    
    public func isPinned(equipmentID: String, productionType: ProductionType) -> Bool {
        switch productionType {
        case .singleItem: singleItem.isPinned(equipmentID: equipmentID)
        case .fromResources: fromResources.isPinned(equipmentID: equipmentID)
        case .power: false
        }
    }
    
    public func isPinned(buildingID: String, productionType: ProductionType) -> Bool {
        switch productionType {
        case .singleItem: false
        case .fromResources: false
        case .power: power.isPinned(buildingID: buildingID)
        }
    }
}

extension Pins {
    public struct SingleItem: Equatable, Sendable {
        public var partIDs: Set<String>
        public var equipmentIDs: Set<String>
        
        public var itemIDs: Set<String> {
            partIDs.union(equipmentIDs)
        }
        
        public var isEmpty: Bool {
            partIDs.isEmpty && equipmentIDs.isEmpty
        }
        
        public init(partIDs: Set<String> = [], equipmentIDs: Set<String> = []) {
            self.partIDs = partIDs
            self.equipmentIDs = equipmentIDs
        }
        
        public func isPinned(partID: String) -> Bool {
            partIDs.contains(partID)
        }
        
        public func isPinned(equipmentID: String) -> Bool {
            equipmentIDs.contains(equipmentID)
        }
    }
    
    public struct FromResources: Equatable, Sendable {
        public var partIDs: Set<String>
        public var equipmentIDs: Set<String>
        
        public var itemIDs: Set<String> {
            partIDs.union(equipmentIDs)
        }
        
        public var isEmpty: Bool {
            partIDs.isEmpty && equipmentIDs.isEmpty
        }
        
        public init(partIDs: Set<String> = [], equipmentIDs: Set<String> = []) {
            self.partIDs = partIDs
            self.equipmentIDs = equipmentIDs
        }
        
        public func isPinned(partID: String) -> Bool {
            partIDs.contains(partID)
        }
        
        public func isPinned(equipmentID: String) -> Bool {
            equipmentIDs.contains(equipmentID)
        }
    }
    
    public struct Power: Equatable, Sendable {
        public var buildingIDs: Set<String>
        public var partIDs: Set<String>
        
        public var isEmpty: Bool {
            buildingIDs.isEmpty && partIDs.isEmpty
        }
        
        public init(buildingIDs: Set<String> = [], partIDs: Set<String> = []) {
            self.buildingIDs = buildingIDs
            self.partIDs = partIDs
        }
        
        public func isPinned(partID: String) -> Bool {
            partIDs.contains(partID)
        }
        
        public func isPinned(buildingID: String) -> Bool {
            buildingIDs.contains(buildingID)
        }
    }
}
