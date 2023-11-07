
extension LegacyToV2.Buildings {
    static let constructor = Migration.IDs(old: Legacy.Buildings.constructor, new: V2.Buildings.constructor)
    static let assembler = Migration.IDs(old: Legacy.Buildings.assembler, new: V2.Buildings.assembler)
    static let manufacturer = Migration.IDs(old: Legacy.Buildings.manufacturer, new: V2.Buildings.manufacturer)
    static let packager = Migration.IDs(old: Legacy.Buildings.packager, new: V2.Buildings.packager)
    static let refinery = Migration.IDs(old: Legacy.Buildings.refinery, new: V2.Buildings.refinery)
    static let blender = Migration.IDs(old: Legacy.Buildings.blender, new: V2.Buildings.blender)
    static let particleAccelerator = Migration.IDs(old: Legacy.Buildings.particleAccelerator, new: V2.Buildings.particleAccelerator)
    
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
