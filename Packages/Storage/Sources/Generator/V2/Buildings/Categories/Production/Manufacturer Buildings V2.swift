import StaticModels

private extension Building {
    init(id: String) {
        self.init(id: id, category: .manufacturers)
    }
}

extension V2.Buildings {
    static let constructor = Building(id: "building-constructor")
    static let assembler = Building(id: "building-assembler")
    static let manufacturer = Building(id: "building-manufacturer")
    static let packager = Building(id: "building-packager")
    static let refinery = Building(id: "building-refinery")
    static let blender = Building(id: "building-blender")
    static let particleAccelerator = Building(id: "building-particle-accelerator")
    
    static let manufacturerBuildings = [
        constructor,
        assembler,
        manufacturer,
        packager,
        refinery,
        blender,
        particleAccelerator,
    ]
}
