import StaticModels
import Models

extension Models.Equipment {
    init(_ equipment: StaticModels.Equipment, partProvider: (_ partID: String) throws -> Models.Part) throws {
        try self.init(
            id: equipment.id,
            category: Category(fromID: equipment.categoryID),
            slot: Slot(fromID: equipment.slotID),
            ammo: equipment.ammoIDs.map(partProvider),
            fuel: equipment.fuelIDs.map(partProvider),
            consumes: equipment.consumesID.map(partProvider),
            requireElectrecity: equipment.requireElectricity
        )
    }
}

private extension Models.Equipment.Slot {
    init(fromID id: String) throws {
        self = switch id {
        case Self.head.id: .head
        case Self.body.id: .body
        case Self.back.id: .back
        case Self.hands.id: .hands
        case Self.legs.id: .legs
            
        default: throw LoadError.invalidID(id)
        }
    }
}

extension Models.Equipment.Slot {
    enum LoadError: Error, CustomDebugStringConvertible {
        case invalidID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidID(id): "Failed to initialized Equipment.Slot with ID '\(id)'"
            }
        }
    }
}
