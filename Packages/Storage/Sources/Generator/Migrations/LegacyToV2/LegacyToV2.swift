
enum LegacyToV2 {}

extension Migrations {
    static let legacyToV2 = Migration(
        version: .legacyToV2,
        partIDs: LegacyToV2.Parts.all,
        equipmentIDs: LegacyToV2.Equipment.all,
        buildingIDs: LegacyToV2.Buildings.all,
        recipeIDs: []
    )
}
