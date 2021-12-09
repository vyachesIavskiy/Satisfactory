private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .ficsmas)
    }
}

let giantFicsmasTree = Building(name: "Giant FICSMAS Tree")
let candyCaneBuilding = Building(name: "Candy Cane")
let snowman = Building(name: "Snowman")
let ficsmasGiftTree = Building(name: "FICSMAS Gift Tree")
let ficsmasPowerLight = Building(name: "FICSMAS Power Light")
let ficsmasSnowDispenser = Building(name: "FICSMAS Snow Dispenser")
let ficsmasWreath = Building(name: "FICSMAS Wreath")

let FICSMASBuildings = [
    giantFicsmasTree,
    candyCaneBuilding,
    snowman,
    ficsmasGiftTree,
    ficsmasPowerLight,
    ficsmasSnowDispenser,
    ficsmasWreath
]
