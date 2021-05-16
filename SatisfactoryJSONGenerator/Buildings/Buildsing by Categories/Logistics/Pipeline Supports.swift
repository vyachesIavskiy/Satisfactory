private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .pipelineSupports)
    }
}

let pipelineSupport = Building(name: "Pipeline Support")
let stackablePipelineSupport = Building(name: "Stackable Pipeline Support")
let pipelineWallSupport = Building(name: "Pipeline Wall Support")
let pipelineWallHole = Building(name: "Pipeline Wall Hole")

let PipelineSupports = [
    pipelineSupport,
    stackablePipelineSupport,
    pipelineWallSupport,
    pipelineWallHole
]
