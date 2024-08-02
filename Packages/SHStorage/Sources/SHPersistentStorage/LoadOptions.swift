import SHModels
import SHPersistentModels

public struct LoadOptions {
    public var v1: V1
    
    public init(v1: V1) {
        self.v1 = v1
    }
    
    public init() {
        self.init(v1: V1())
    }
}

extension LoadOptions {
#if DEBUG
    public struct V1 {
        public var pinnedPartIDs: Set<String>
        public var pinnedEquipmentIDs: Set<String>
        public var pinnedRecipeIDs: Set<String>
        public var savedProductions: [Production.Persistent.Legacy]
        
        package var isEmpty: Bool {
            pinnedPartIDs.isEmpty &&
            pinnedEquipmentIDs.isEmpty &&
            pinnedRecipeIDs.isEmpty &&
            savedProductions.isEmpty
        }
        
        public init(
            pinnedPartIDs: Set<String> = [],
            pinnedEquipmentIDs: Set<String> = [],
            pinnedRecipeIDs: Set<String> = [],
            savedProductions: [Production.Persistent.Legacy] = []
        ) {
            self.pinnedPartIDs = pinnedPartIDs
            self.pinnedEquipmentIDs = pinnedEquipmentIDs
            self.pinnedRecipeIDs = pinnedRecipeIDs
            self.savedProductions = savedProductions
        }
    }
#else
    public struct V1 {
        public var pinnedPartIDs: Set<String>
        public var pinnedEquipmentIDs: Set<String>
        public var pinnedRecipeIDs: Set<String>
        public var savedProductions: [Production.Persistent.Legacy]
        
        package var isEmpty: Bool { true }
        
        public init(
            pinnedPartIDs: Set<String> = [],
            pinnedEquipmentIDs: Set<String> = [],
            pinnedRecipeIDs: Set<String> = [],
            savedProductions: [Production.Persistent.Legacy] = []
        ) {
            self.pinnedItemIDs = []
            self.pinnedEquipmentIDs = []
            self.pinnedRecipeIDs = []
            self.savedProductions = []
        }
    }
#endif
}
