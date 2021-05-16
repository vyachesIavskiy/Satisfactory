private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .pipelines)
    }
}

let pipelineMK1 = Building(name: "Pipeline MK.1")
let pipelineMK2 = Building(name: "Pipeline MK.2")
let pipelineJunctionCross = Building(name: "Pipeline Junction Cross")
let pipelinePumpMK1 = Building(name: "Pipeline Pump MK.1")
let pipelinePumpMK2 = Building(name: "Pipeline Pump MK.2")
let valve = Building(name: "Valve")

let Pipelines = [
    pipelineMK1,
    pipelineMK2,
    pipelineJunctionCross,
    pipelinePumpMK1,
    pipelinePumpMK2,
    valve
]
