import Foundation
import SHModels

extension Equipment {
    public struct Static: Codable {
        public let id: String
        public let categoryID: String
        public var progressionIndex = 0
        public let slotID: String
        public let ammoIDs: [String]?
        public let fuelIDs: [String]?
        public let consumesIDs: [String]?
        public let requireElectricity: Bool
        
        public init(
            id: String,
            categoryID: String,
            slotID: String,
            ammoIDs: [String]?,
            fuelIDs: [String]?,
            consumesIDs: [String]?,
            requireElectricity: Bool
        ) {
            self.id = id
            self.categoryID = categoryID
            self.slotID = slotID
            self.ammoIDs = ammoIDs
            self.fuelIDs = fuelIDs
            self.consumesIDs = consumesIDs
            self.requireElectricity = requireElectricity
        }
    }
    
    public init(_ equipment: Static, partProvider: (_ partID: String) throws -> Part) throws {
        try self.init(
            id: equipment.id,
            category: Category(fromID: equipment.categoryID),
            progressionIndex: equipment.progressionIndex,
            slot: Slot(fromID: equipment.slotID),
            ammo: equipment.ammoIDs?.map(partProvider) ?? [],
            fuel: equipment.fuelIDs?.map(partProvider) ?? [],
            consumes: equipment.consumesIDs?.map(partProvider) ?? [],
            requireElectrecity: equipment.requireElectricity
        )
    }
}

private extension Equipment.Slot {
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

extension Equipment.Slot {
    enum LoadError: Error, CustomDebugStringConvertible {
        case invalidID(String)
        
        var debugDescription: String {
            switch self {
            case let .invalidID(id): "Failed to initialized Equipment.Slot with ID '\(id)'"
            }
        }
    }
}
