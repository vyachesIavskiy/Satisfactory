import Foundation

public struct Settings: Codable, Hashable {
    public var viewMode: ViewMode
    public var autoSelectSingleRecipe: Bool
    public var autoSelectSinglePinnedRecipe: Bool
    public var showFICSMAS: Bool
    
    public init(
        viewMode: ViewMode = .icon,
        autoSelectSingleRecipe: Bool = true,
        autoSelectSinglePinnedRecipe: Bool = false,
        showFICSMAS: Bool = true
    ) {
        self.viewMode = viewMode
        self.autoSelectSingleRecipe = autoSelectSingleRecipe
        self.autoSelectSinglePinnedRecipe = autoSelectSinglePinnedRecipe
        self.showFICSMAS = showFICSMAS
    }
}

private extension Settings {
    enum CodingKeys: CodingKey {
        case viewMode
        case autoSelectSingleRecipe
        case autoSelectSinglePinnedRecipe
        case showFICSMAS
    }
}
