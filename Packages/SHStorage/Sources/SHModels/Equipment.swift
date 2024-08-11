import Foundation

public struct Equipment: ProgressiveItem {
    public let id: String
    public let category: Category
    public var progressionIndex: Int
    public let slot: Slot
    public let ammo: [Part]
    public let fuel: [Part]
    public let consumes: [Part]
    public let requireElectrecity: Bool
    
    public var description: String {
        "Equipment: \(localizedName)"
    }
    
    public init(
        id: String,
        category: Category,
        progressionIndex: Int,
        slot: Slot,
        ammo: [Part] = [],
        fuel: [Part] = [],
        consumes: [Part] = [],
        requireElectrecity: Bool = false
    ) {
        self.id = id
        self.category = category
        self.progressionIndex = progressionIndex
        self.slot = slot
        self.ammo = ammo
        self.fuel = fuel
        self.consumes = consumes
        self.requireElectrecity = requireElectrecity
    }
}

public extension Equipment {
    enum Slot: Sendable {
        case head
        case body
        case back
        case hands
        case legs
        
        public var id: String {
            switch self {
            case .head: "equipment-slot-head"
            case .body: "equipment-slot-body"
            case .back: "equipment-slot-back"
            case .hands: "equipment-slot-hands"
            case .legs: "equipment-slot-legs"
            }
        }
        
        public var localizedName: String {
            NSLocalizedString(id, tableName: "Equipment Slots", bundle: .module, comment: "")
        }
    }
}
