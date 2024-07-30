import Foundation
import SHStorage
import SHSettings

final class SettingsViewModel {
    @Dependency(\.settingsService)
    private var settingsService
    
    @Published
    var sections = [Section]()
    
    init() {
        buildSections()
    }
    
    func change(toggleListItem: ToggleListItem, to newValue: Bool) {
        switch toggleListItem.id {
        case .showIngredientNames:
            settingsService.showIngredientNames = newValue
        case .autoSelectSingleRecipe:
            settingsService.autoSelectSingleRecipe = newValue
        case .autoSelectSinglePinnedRecipe:
            settingsService.autoSelectSinglePinnedRecipe = newValue
        case .showFICSMAS:
            settingsService.showFICSMAS = newValue
        }
        
        print(settingsService.settings)
        
        buildSections()
    }
    
    private func buildSections() {
        sections = [
            Section.recipes(
                showIngredientNames: settingsService.showIngredientNames,
                autoSelectSingleRecipe: settingsService.autoSelectSingleRecipe,
                autoSelectSinglePinnedRecipe: settingsService.autoSelectSinglePinnedRecipe
            ),
            .seasonalEvents(showFICSMAS: settingsService.showFICSMAS)
        ]
        
        print(sections.map { $0.items.map {
            switch $0 {
            case let .header(header): "Header \(header.text)"
            case let .toggle(toggle): "Toggle \(toggle.id) \(toggle.isOn ? "on" : "off")"
            }
        }})
    }
}

extension SettingsViewModel {
    struct Section {
        enum ID {
            case recipes
            case seasonalEvents
            case other
            case feedback
        }
        
        let id: ID
        var items: [ListItem]
        
        private init(id: ID, items: [ListItem]) {
            self.id = id
            self.items = items
        }
        
        static func recipes(
            showIngredientNames: Bool,
            autoSelectSingleRecipe: Bool,
            autoSelectSinglePinnedRecipe: Bool
        ) -> Self {
            Self(id: .recipes, items: [
                .header(HeaderListItem(id: .recipes)),
                .toggle(ToggleListItem.showIngredientNames(isOn: showIngredientNames)),
                .toggle(ToggleListItem.autoSelectSingleRecipe(isOn: autoSelectSingleRecipe)),
                .toggle(ToggleListItem.autoSelectSinglePinnedRecipe(isOn: autoSelectSinglePinnedRecipe))
            ])
        }
        
        static func seasonalEvents(showFICSMAS: Bool) -> Self {
            Self(id: .seasonalEvents, items: [
                .header(HeaderListItem(id: .seasonalEvents)),
                .toggle(ToggleListItem.showFICSMAS(isOn: showFICSMAS))
            ])
        }
    }
}

extension SettingsViewModel {
    enum ListItem: Hashable {
        case header(HeaderListItem)
        case toggle(ToggleListItem)
    }
}

extension SettingsViewModel {
    struct HeaderListItem: Hashable {
        enum ID {
            case recipes
            case seasonalEvents
            case other
            case feedback
        }
        
        let id: ID
        let text: String
        
        init(id: ID) {
            self.id = id
            text = switch id {
            case .recipes: "Recipes"
            case .seasonalEvents: "Seasonal events"
            case .other: " "
            case .feedback: " "
            }
        }
    }
}

extension SettingsViewModel {
    struct ToggleListItem: Hashable {
        enum ID {
            case showIngredientNames
            case autoSelectSingleRecipe
            case autoSelectSinglePinnedRecipe
            case showFICSMAS
        }
        
        let id: ID
        let title: String
        let subtitle: String?
        let isOn: Bool
        
        private init(
            id: ID,
            title: String,
            subtitle: String? = nil,
            isOn: Bool
        ) {
            self.id = id
            self.title = title
            self.subtitle = subtitle
            self.isOn = isOn
        }
        
        static func showIngredientNames(isOn: Bool) -> Self {
            Self(
                id: .showIngredientNames,
                title: "Show recipe ingredient names",
                subtitle: "If it is difficult for you to distinguish recipe ingredients only by it's icon, you can enable this setting to also see recipe ingredient names.",
                isOn: isOn
            )
        }
        
        static func autoSelectSingleRecipe(isOn: Bool) -> Self {
            Self(
                id: .autoSelectSingleRecipe,
                title: "Auto-select single recipe",
                isOn: isOn
            )
        }
        
        static func autoSelectSinglePinnedRecipe(isOn: Bool) -> Self {
            Self(
                id: .autoSelectSinglePinnedRecipe,
                title: "Auto-select single pinned recipe",
                isOn: isOn
            )
        }
        
        static func showFICSMAS(isOn: Bool) -> Self {
            Self(
                id: .showFICSMAS,
                title: "FICSMAS",
                isOn: isOn
            )
        }
    }
}
