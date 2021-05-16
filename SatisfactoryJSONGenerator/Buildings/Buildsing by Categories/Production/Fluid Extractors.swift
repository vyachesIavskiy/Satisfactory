private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .fluidExtractors)
    }
}

let waterExctractor = Building(name: "Water Extractor")
let oilExctractor = Building(name: "Oil Extractor")
let resourceWellPressurizer = Building(name: "Resource Well Pressurizer")
let resourceWellExtractor = Building(name: "Resource Well Extractor")

let FluidProduction = [
    waterExctractor,
    oilExctractor,
    resourceWellPressurizer,
    resourceWellExtractor
]
