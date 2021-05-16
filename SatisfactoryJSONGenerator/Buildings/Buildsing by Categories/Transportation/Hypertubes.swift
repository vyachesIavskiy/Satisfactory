private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .hypertubes)
    }
}

let hyperTube = Building(name: "Hyper Tube")
let hyperTubeEntrance = Building(name: "Hyper Tube Entrance")
let hyperTubeSupport = Building(name: "Hyper Tube Support")
let hyperTubeWallSupport = Building(name: "Hyper Tube Wall Support")
let hyperTubeWallHole = Building(name: "Hyper Tube Wall Hole")
let stackableHyperTubeSupport = Building(name: "Stackable Hyper Tube Support")

let Hypertubes = [
    hyperTube,
    hyperTubeEntrance,
    hyperTubeSupport,
    hyperTubeWallSupport,
    hyperTubeWallHole,
    stackableHyperTubeSupport
]
