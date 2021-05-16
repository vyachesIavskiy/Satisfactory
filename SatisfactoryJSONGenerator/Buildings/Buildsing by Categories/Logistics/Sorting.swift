private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .sorting)
    }
}

let conveyorMerger = Building(name: "Conveyor Merger")
let coveyorSplitter = Building(name: "Conveyor Splitter")
let smartSplitter = Building(name: "Smart Splitter")
let programmableSplitter = Building(name: "Programmable Splitter")

let Sorting = [
    conveyorMerger,
    coveyorSplitter,
    smartSplitter,
    programmableSplitter
]
