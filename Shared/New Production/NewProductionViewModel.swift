import SwiftUI
import SHDependencies
import SHStorage
import SHSettings
import SHModels

@Observable
final class NewProductionViewModel {
    // MARK: Ignored properties
    private let parts: [Part]
    private let equipment: [Equipment]
    
    @MainActor @ObservationIgnored
    private var pins: Pins {
        didSet {
            if oldValue.itemIDs != pins.itemIDs {
                buildSections()
            }
        }
    }
    
    @MainActor @ObservationIgnored
    private var settings: SHSettings.Settings {
        didSet {
            if oldValue.showFICSMAS != settings.showFICSMAS {
                buildSections()
            }
        }
    }
    
    @MainActor @ObservationIgnored
    var searchText = "" {
        didSet {
            buildSections()
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored @Dependency(\.settingsService)
    private var settingsService
    
    // MARK: Observed properties
    @MainActor
    var sorting = Sorting.progression {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    var sections = [Section]()
    
    @MainActor
    var navigationPath = [String]() // Item IDs
    
    @MainActor
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        parts = storageService.automatableParts()
        equipment = storageService.automatableEquipment()
        
        pins = storageService.pins()
        settings = settingsService.settings
        
        buildSections()
    }
    
    @MainActor
    func observeStorage() async {
        for await pins in storageService.streamPins() {
            guard !Task.isCancelled else { break }
            guard self.pins != pins else { continue }
            
            self.pins = pins
        }
    }
    
    @MainActor
    func observeSettings() async {
        for await settings in settingsService.streamSettings() {
            guard !Task.isCancelled else { break }
            guard self.settings != settings else { continue }
            
            self.settings = settings
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
    func item(id: String) -> (any Item)? {
        storageService.item(id: id)
    }
}

// MARK: Private
private extension NewProductionViewModel {
    @MainActor
    func buildSections() {
        var newSections = buildCategoriesSections()
        
        if sections.isEmpty {
            sections = newSections
        } else {
            for (index, newSection) in newSections.enumerated() {
                let expanded = sections.first { $0.id == newSection.id }?.expanded ?? true
                newSections[index].expanded = expanded
            }
            
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
        partsByCategories.sorted { $0.0 < $1.0 }.map { .parts(title: $0.0.localizedName, parts: $0.1) } +
        equipmentByCategories.sorted { $0.0 < $1.0 }.map { .equipment(title: $0.0.localizedName, equipment: $0.1) }
    }
    
    @MainActor
    func split<T: ProgressiveItem>(_ items: [T]) -> (pinned: [T], unpinned: [T]) {
        var (pinned, unpinned) = items.reduce(into: ([T](), [T]())) { partialResult, item in
            if item.category == .ficsmas, !settings.showFICSMAS {
                return
            }
            
            if searchText.isEmpty || item.category.localizedName.localizedCaseInsensitiveContains(searchText) || item.localizedName.localizedCaseInsensitiveContains(searchText) {
                if pins.itemIDs.contains(item.id) {
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
    struct Section: Identifiable, Equatable {
        enum ID: Hashable {
            case pinned
            case parts(title: String)
            case equipment(title: String)
        }
        
        let id: ID
        var items: [any Item]
        var expanded: Bool
        
        var title: String {
            switch id {
            case .pinned: NSLocalizedString("new-production-pinned-section-name", value: "Pinned", comment: "")
            case let .parts(title), let .equipment(title): title
            }
        }
        
        private init(id: ID, items: [any Item]) {
            self.id = id
            self.items = items
            self.expanded = true
        }
        
        static func pinned(_ items: [any Item]) -> Self {
            Section(id: .pinned, items: items)
        }
        
        static func parts(title: String, parts: [Part]) -> Self {
            Section(id: .parts(title: title), items: parts)
        }
        
        static func equipment(title: String, equipment: [Equipment]) -> Self {
            Section(id: .equipment(title: title), items: equipment)
        }
        
        static func == (lhs: NewProductionViewModel.Section, rhs: NewProductionViewModel.Section) -> Bool {
            lhs.id == rhs.id &&
            lhs.items.map(\.id) == rhs.items.map(\.id) &&
            lhs.expanded == rhs.expanded
        }
    }
}
