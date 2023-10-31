
public struct Equipment: Item {
    public let id: String
    public let category: Category
    public let slot: Slot
    public let ammo: [Part]
    public let fuel: [Part]
    public let consumes: [Part]
    public let requireElectrecity: Bool
    
    public init(
        id: String,
        category: Category,
        slot: Slot,
        ammo: [Part] = [],
        fuel: [Part] = [],
        consumes: [Part] = [],
        requireElectrecity: Bool = false
    ) {
        self.id = id
        self.category = category
        self.slot = slot
        self.ammo = ammo
        self.fuel = fuel
        self.consumes = consumes
        self.requireElectrecity = requireElectrecity
    }
}

public extension Equipment {
    enum Slot {
        case head
        case body
        case back
        case hands
        case legs
        
        public var id: String {
            switch self {
            case .head: "head"
            case .body: "body"
            case .back: "back"
            case .hands: "hands"
            case .legs: "legs"
            }
        }
    }
}
