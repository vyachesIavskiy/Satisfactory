private extension Milestone {
    init(tierPosition: Int, name: String, unlocks: [UUID], cost: [UUID: Int]) {
        self.init(tier: .tier0, tierPosition: tierPosition, name: name, unlocks: unlocks, cost: cost)
    }
}

let startMilestone = Milestone(tierPosition: -1, name: "Start", unlocks: [
    ironOre.id,
    copperOre.id,
    limestone.id,
    coal.id,
    sulfur.id,
    cateriumOre.id,
    rawQuartz.id,
    crudeOil.id,
    bauxite.id,
    uranium.id,
    ironIngot.id,
    ironPlate.id,
    ironRod.id,
    xenoZapper.id,
    hub.id,
    craftBench.id
], cost: [:])

let hubUpgrade1 = Milestone(tierPosition: 0, name: "HUB Upgrade 1", unlocks: [
    portableMiner.id,
    equipmentWorkshop.id
], cost: [
    ironRod.id: 10
])

let hubUpgrade2 = Milestone(tierPosition: 1, name: "HUB Upgrade 2", unlocks: [
    copperIngot.id,
    wire.id,
    cable.id,
    powerLine.id,
    smelter.id
], cost: [
    ironRod.id: 20,
    ironPlate.id: 10
])

let hubUpgrade3 = Milestone(tierPosition: 2, name: "HUB Upgrade 3", unlocks: [
    concrete.id,
    screw.id,
    reinforcedIronPlate.id,
    powerPoleMK1.id,
    constructor.id
], cost: [
    ironRod.id: 20,
    ironPlate.id: 20,
    wire.id: 20
])

let hubUpgrade4 = Milestone(tierPosition: 3, name: "HUB Upgrade 4", unlocks: [
    conveyorPole.id,
    conveyorBeltMK1.id
], cost: [
    ironPlate.id: 75,
    cable.id: 20,
    concrete.id: 10
])

let hubUpgrade5 = Milestone(tierPosition: 4, name: "HUB Upgrade 5", unlocks: [
    minerMK1.id,
    storageContainer.id
], cost: [
    ironRod.id: 75,
    cable.id: 50,
    concrete.id: 20
])

let hubUpgrade6 = Milestone(tierPosition: 5, name: "HUB Upgrade 6", unlocks: [
    biomass.id,
    biomassBurner.id,
    spaceElevator.id
], cost: [
    ironRod.id: 100,
    ironPlate.id: 100,
    wire.id: 100,
    concrete.id: 50
])
