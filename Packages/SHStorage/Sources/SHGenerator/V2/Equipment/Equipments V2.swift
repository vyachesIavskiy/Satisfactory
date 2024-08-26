import SHModels
import SHStaticModels

extension Equipment.Static {
    init(
        id: String,
        category: Category,
        slot: Equipment.Slot,
        ammo: [Part.Static]? = nil,
        fuel: [Part.Static]? = nil,
        consumes: [Part.Static]? = nil,
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
        
        static let allSortedByProgression = [
            xenoZapper,
            portableMiner,
            objectScanner,
            beacon,
            parachute,
            chainsaw,
            medicinalInhaler,
            rebarGun,
            zipline,
            xenoBasher,
            bladeRunners,
            nobeliskDetonator,
            gasMask,
            rifle,
            jetpack,
            hazmatSuit,
            hoverPack,
            factoryCart,
            coffeCup,
            boombox,
            candyCaneBasher,
            goldenFactoryCart,
            goldCoffeCup
        ]
    }
}
