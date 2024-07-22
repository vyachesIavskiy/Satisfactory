import Foundation

public struct Settings: Codable, Hashable {
    public var showIngredientNames: Bool
    public var autoSelectSingleRecipe: Bool
    public var autoSelectSinglePinnedRecipe: Bool
    public var showFICSMAS: Bool
    
    public init(
        showIngredientNames: Bool = false,
        autoSelectSingleRecipe: Bool = true,
        autoSelectSinglePinnedRecipe: Bool = false,
        showFICSMAS: Bool = true
    ) {
        self.showIngredientNames = showIngredientNames
        self.autoSelectSingleRecipe = autoSelectSingleRecipe
        self.autoSelectSinglePinnedRecipe = autoSelectSinglePinnedRecipe
        self.showFICSMAS = showFICSMAS
    }
}

private extension Settings {
    enum CodingKeys: CodingKey {
        case showIngredientNames
        case autoSelectSingleRecipe
        case autoSelectSinglePinnedRecipe
        case showFICSMAS
    }
}
