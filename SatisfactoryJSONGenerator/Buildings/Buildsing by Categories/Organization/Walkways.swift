private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .walkways)
    }
}

let walkwayStraight = Building(name: "Walkway Straight")
let walkwayTurn = Building(name: "Walkway Turn")
let walkwayTCrossing = Building(name: "Walkway T-Crossing")
let walkwayRamp = Building(name: "Walkway Ramp")
let walkwayCrossing = Building(name: "Walkway Crossing")

let Walkways = [
    walkwayStraight,
    walkwayTurn,
    walkwayTCrossing,
    walkwayRamp,
    walkwayCrossing
]
