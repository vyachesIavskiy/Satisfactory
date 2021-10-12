private extension Milestone {
    init(tierPosition: Int, name: String, unlocks: [UUID], cost: [UUID: Int]) {
        init(tier: .tier1, tierPosition: tierPosition, name: name, unlocks: unlocks, cost: cost)
    }
}

let baseBuilding = Milestone(tierPosition: 0, name: "Base Building", unlocks: [
    foundation8x1.id,
    foundation8x2.id,
    foundation8x4.id,
    ramp8x1.id,
    ramp8x2.id,
    ramp8x4.id,
    wall8x4.id,
    wall8x4Gray.id,
    lookoutTower.id
], cost: [
    ironRod.id: 100,
    ironPlate.id: 100,
    concrete.id: 200
])

let logistics = Milestone(tierPosition: 1, name: "Logistics", unlocks: [
    conveyorLiftMK1.id,
    coveyorSplitter.id,
    conveyorMerger.id
], cost: [
    ironRod.id: 150,
    ironPlate.id: 150,
    wire.id: 300
])

let fieldResearch = Milestone(tierPosition: 2, name: "Field Research", unlocks: [
    beacon.id,
    objectScanner.id,
    mam.id,
    personalStorageBox.id
], cost: [
    ironPlate.id: 100,
    wire.id: 300,
    screw.id: 300
])
