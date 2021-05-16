private extension Building {
    init(name: String) {
        self.init(name: name, buildingType: .manufacturers)
    }
}

let constructor = Building(name: "Constructor")
let assembler = Building(name: "Assembler")
let manufacturer = Building(name: "Manufacturer")
let packager = Building(name: "Packager")
let refinery = Building(name: "Refinery")
let blender = Building(name: "Blender")
let particleAccelerator = Building(name: "Particle Accelerator")

let Manufacturers = [
    constructor,
    assembler,
    manufacturer,
    packager,
    refinery,
    blender,
    particleAccelerator
]
