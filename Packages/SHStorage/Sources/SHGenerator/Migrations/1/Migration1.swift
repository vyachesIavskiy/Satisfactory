
enum LegacyToV2 {}

extension Migrations {
    static let migration1 = Migration(
        version: 1,
        partIDs: LegacyToV2.Parts.all,
        recipeIDs: LegacyToV2.Recipes.all
    )
}
