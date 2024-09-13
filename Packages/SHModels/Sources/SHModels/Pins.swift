
public struct Pins: Equatable, Sendable {
    public var singleItemPartIDs: Set<String>
    public var fromResourcesPartIDs: Set<String>
    public var power: Power
    public var recipeIDs: Set<String>
    
    public var isEmpty: Bool {
        singleItemPartIDs.isEmpty && fromResourcesPartIDs.isEmpty && recipeIDs.isEmpty
    }
    
    public init(
        singleItemPartIDs: Set<String> = [],
        fromResourcesPartIDs: Set<String> = [],
        power: Power = Power(),
        recipeIDs: Set<String> = []
    ) {
        self.singleItemPartIDs = singleItemPartIDs
        self.fromResourcesPartIDs = fromResourcesPartIDs
        self.power = power
        self.recipeIDs = recipeIDs
    }
    
    public func isPinned(partID: String, productionType: ProductionType) -> Bool {
        switch productionType {
        case .singleItem: singleItemPartIDs.contains(partID)
        case .fromResources: fromResourcesPartIDs.contains(partID)
        case .power: power.isPinned(partID: partID)
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
