private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .special)
    }
}

let hub = Building(name: "The HUB")
let mam = Building(name: "MAM")
let spaceElevator = Building(name: "Space Elevator")
let awesomeSink = Building(name: "AWESOME Sink")
let awesomeShop = Building(name: "AWESOME Shop")

let Special = [
    hub,
    mam,
    spaceElevator,
    awesomeSink,
    awesomeShop
]
