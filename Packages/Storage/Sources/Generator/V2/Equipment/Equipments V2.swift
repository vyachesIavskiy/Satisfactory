import StaticModels
import Models

extension StaticModels.Equipment {
    init(
        id: String,
        category: Models.Category,
        slot: Models.Equipment.Slot,
        ammo: [StaticModels.Part]? = nil,
        fuel: [StaticModels.Part]? = nil,
        consumes: [StaticModels.Part]? = nil,
        requireElectricity: Bool = false
    ) {
        self.init(
            id: id,
            categoryID: category.id,
            slotID: slot.id,
            ammoIDs: ammo?.map(\.id),
            fuelIDs: fuel?.map(\.id),
            consumesIDs: consumes?.map(\.id),
            requireElectricity: requireElectricity
        )
    }
}

extension V2 {
    enum Equipment {
        static let all =
        backEquipment +
        bodyEquipment +
        handEquipment +
        headEquipment +
        legEquipment
    }
}
