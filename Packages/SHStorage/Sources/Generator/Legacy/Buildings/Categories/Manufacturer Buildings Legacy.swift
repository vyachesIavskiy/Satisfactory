import Models
import StaticModels

private extension Building.Static.Legacy {
    init(id: String, name: String) {
        self.init(id: id, name: name, buildingType: "Manufacturers")
    }
}

extension Legacy.Buildings {
    static let constructor = Building.Static.Legacy(id: "building-constructor", name: "Constructor")
    static let assembler = Building.Static.Legacy(id: "building-assembler", name: "Assembler")
    static let manufacturer = Building.Static.Legacy(id: "building-manufacturer", name: "Manufacturer")
    static let packager = Building.Static.Legacy(id: "building-packager", name: "Packager")
    static let refinery = Building.Static.Legacy(id: "building-refinery", name: "Refinery")
    static let blender = Building.Static.Legacy(id: "building-blender", name: "Blender")
    static let particleAccelerator = Building.Static.Legacy(id: "building-particle-accelerator", name: "Particle Accelerator")
    
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
