import SwiftUI
import SHDependencies
import SHStorage
import SHSettings
import SHModels

@Observable
final class NewProductionViewModel {
    private let parts: [Part]
    private let equipment: [Equipment]
    
    private(set) var pinnedItemIDs: Set<String>
    private(set) var showFICSMAS: Bool
    
    @MainActor
    var sorting = Sorting.progression {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    var searchText = "" {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    var selectedItemID: String?
    
    @MainActor
    var sections = [Section]()
    
    // Dependencies
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    private var settingsService
    
    @MainActor
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService.currentSettings)
        var settings
        
        parts = storageService.automatableParts()
        equipment = storageService.automatableEquipment()
        pinnedItemIDs = storageService.pinnedItemIDs
        showFICSMAS = settings().showFICSMAS
        
        buildSections()
    }
    
    @MainActor
    func observeStorage() async {
        for await pinnedItemIDs in storageService.streamPinnedItemIDs {
            guard !Task.isCancelled else { break }
            
            self.pinnedItemIDs = pinnedItemIDs
            buildSections()
        }
    }
    
    @MainActor
    func observeSettings() async {
        for await showFICSMAS in settingsService.settings().map(\.showFICSMAS) {
            guard !Task.isCancelled else { break }
            
            self.showFICSMAS = showFICSMAS
            buildSections()
        }
    }
    
    @MainActor
    func isPinned(_ item: some Item) -> Bool {
        storageService.isPinned(item)
    }
    
    @MainActor
    func changePinStatus(for item: some Item) {
        storageService.changePinStatus(for: item)
    }
    
    @MainActor
    func productionViewModel(for itemID: String) -> ProductionViewModel {
        guard let item = storageService.item(withID: itemID) else {
            fatalError("Item with provided itemID '\(itemID)' not found!")
        }
        
        return ProductionViewModel(item: item)
    }
}

// MARK: Private
private extension NewProductionViewModel {
    @MainActor
    func buildSections() {
        let newSections = buildCategoriesSections()
        
        if sections.isEmpty {
            sections = newSections
        } else {
            withAnimation {
                self.sections = newSections
            }
        }
    }
    
    @MainActor
    func buildCategoriesSections() -> [Section] {
        let (pinnedParts, unpinnedParts) = split(parts)
        let (pinnedEquipment, unpinnedEquipment) = split(equipment)
        
        let pinnedItems: [any Item] = pinnedParts + pinnedEquipment
        
        let partsByCategories = unpinnedParts.reduce(into: [(SHModels.Category, [Part])]()) { partialResult, part in
            if let index = partialResult.firstIndex(where: { $0.0 == part.category }) {
                partialResult[index].1.append(part)
            } else {
                partialResult.append((part.category, [part]))
            }
        }
        
        let equipmentByCategories = unpinnedEquipment.reduce(into: [(SHModels.Category, [Equipment])]()) { partialResult, equipment in
            if let index = partialResult.firstIndex(where: { $0.0 == equipment.category }) {
                partialResult[index].1.append(equipment)
            } else {
                partialResult.append((equipment.category, [equipment]))
            }
        }
        
        return [.pinned(pinnedItems)] +
        partsByCategories.sorted { $0.0 < $1.0 }.map { .parts($0.0.localizedName, $0.1) } +
        equipmentByCategories.sorted { $0.0 < $1.0 }.map { .equipment($0.0.localizedName, $0.1) }
    }
    
    @MainActor
    func split<T: ProgressiveItem>(_ items: [T]) -> (pinned: [T], unpinned: [T]) {
        var (pinned, unpinned) = items.reduce(into: ([T](), [T]())) { partialResult, item in
            if item.category == .ficsmas, !showFICSMAS {
                return
            }
            
            if searchText.isEmpty || item.category.localizedName.localizedCaseInsensitiveContains(searchText) || item.localizedName.localizedCaseInsensitiveContains(searchText) {
                if pinnedItemIDs.contains(item.id) {
                    partialResult.0.append(item)
                } else {
                    partialResult.1.append(item)
                }
            }
        }
        
        switch sorting {
        case .name:
            pinned.sortByName()
            unpinned.sortByName()
            
        case .progression: 
            pinned.sortByProgression()
            unpinned.sortByProgression()
        }
        
        return (pinned, unpinned)
    }
}

// MARK: - Sorting
extension NewProductionViewModel {
    enum Sorting {
        case name
        case progression
    }
}

// MARK: - Section
extension NewProductionViewModel {
    enum Section: Identifiable, Equatable {
        case pinned(_ items: [any Item], expanded: Bool = true)
        case parts(_ title: String, _ parts: [Part], expanded: Bool = true)
        case equipment(_ title: String, _ equipment: [Equipment], expanded: Bool = true)
        
        var id: String {
            switch self {
            case .pinned: "Pinned"
            case let .parts(title, _, _): "Parts_\(title)"
            case let .equipment(title, _, _): "Equipment_\(title)"
            }
        }
        
        var isEmpty: Bool {
            switch self {
            case let .pinned(items, _): items.isEmpty
            case let .parts(_, parts, _): parts.isEmpty
            case let .equipment(_, equipment, _): equipment.isEmpty
            }
        }
        
        var title: String {
            switch self {
            case .pinned: "Pinned"
            case let .parts(title, _, _), let .equipment(title, _, _): title
            }
        }
        
        var expanded: Bool {
            get {
                switch self {
                case
                    let .pinned(_, expanded),
                    let .parts(_, _, expanded),
                    let .equipment(_, _, expanded):
                    expanded
                }
            }
            set {
                switch self {
                case let .pinned(items, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .pinned(items, expanded: newValue)
                    
                case let .parts(title, parts, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .parts(title, parts, expanded: newValue)
                    
                case let .equipment(title, equipment, expanded):
                    guard expanded != newValue else { return }
                    
                    self = .equipment(title, equipment, expanded: newValue)
                }
            }
        }
        
        var items: [any Item] {
            switch self {
            case let .pinned(items, _): items
            case let .parts(_, parts, _): parts
            case let .equipment(_, equipment, _): equipment
            }
        }
        
        static func == (lhs: NewProductionViewModel.Section, rhs: NewProductionViewModel.Section) -> Bool {
            switch (lhs, rhs) {
            case let (.pinned(lhsItems, _), .pinned(rhsItems, _)):
                lhsItems.map(\.id) == rhsItems.map(\.id)
                
            case let (.parts(_, lhsParts, _), .parts(_, rhsParts, _)):
                lhsParts == rhsParts
                
            case let (.equipment(_, lhsEquipment, _), .equipment(_, rhsEquipment, _)):
                lhsEquipment == rhsEquipment
                
            default:
                false
            }
        }
    }
}
