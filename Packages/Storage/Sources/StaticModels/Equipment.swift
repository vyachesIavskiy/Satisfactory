import Foundation

public struct Equipment: Codable {
    public let id: String
    public let categoryID: String
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
