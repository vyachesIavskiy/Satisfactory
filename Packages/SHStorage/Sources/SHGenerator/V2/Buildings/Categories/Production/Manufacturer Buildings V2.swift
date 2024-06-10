import SHModels
import SHStaticModels

private extension Building.Static {
    init(id: String) {
        self.init(id: id, category: .manufacturers)
    }
}

extension V2.Buildings {
    static let constructor = Building.Static(id: "building-constructor")
    static let assembler = Building.Static(id: "building-assembler")
    static let manufacturer = Building.Static(id: "building-manufacturer")
    static let packager = Building.Static(id: "building-packager")
    static let refinery = Building.Static(id: "building-refinery")
    static let blender = Building.Static(id: "building-blender")
    static let particleAccelerator = Building.Static(id: "building-particle-accelerator")
    
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
