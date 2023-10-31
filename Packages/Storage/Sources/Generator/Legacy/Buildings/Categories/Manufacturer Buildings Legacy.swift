import StaticModels

private extension BuildingLegacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Manufacturers")
    }
}

extension Legacy.Buildings {
    static let constructor = BuildingLegacy(id: "building-constructor", name: "Constructor")
    static let assembler = BuildingLegacy(id: "building-assembler", name: "Assembler")
    static let manufacturer = BuildingLegacy(id: "building-manufacturer", name: "Manufacturer")
    static let packager = BuildingLegacy(id: "building-packager", name: "Packager")
    static let refinery = BuildingLegacy(id: "building-refinery", name: "Refinery")
    static let blender = BuildingLegacy(id: "building-blender", name: "Blender")
    static let particleAccelerator = BuildingLegacy(id: "building-particle-accelerator", name: "Particle Accelerator")
    
    static let manufacturerBuildings = [
        constructor,
        assembler,
        manufacturer,
        packager,
        refinery,
        blender,
        particleAccelerator
    ]
}
