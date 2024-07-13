import SwiftUI
import SHDependencies
import SHStorage
import SHSettings
import SHModels

@Observable
final class NewProductionViewModel {
    @ObservationIgnored
    @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored
    @Dependency(\.settingsService)
    private var settingsService
    
    private let parts: [Part]
    private let equipment: [Equipment]
    
    @MainActor
    private var pinnedPartIDs: Set<String> {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    private var pinnedEquipmentIDs: Set<String> {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    private var showFICSMAS: Bool {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    private var grouping = Grouping.categories {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    private var sorting = Sorting.progression {
        didSet {
            buildSections()
        }
    }
    
    @MainActor
    var groupingNone: Bool {
        get { grouping == .none }
        set {
            guard newValue else { return }
            
            grouping = .none
        }
    }
    
    @MainActor
    var groupingCategories: Bool {
        get { grouping == .categories }
        set {
            guard newValue else { return }
            
            grouping = .categories
        }
    }
    
    @MainActor
    var sortingName: Bool {
        get { sorting == .name }
        set {
            guard newValue else { return }
            
            sorting = .name
        }
    }
    
    @MainActor
    var sortingProgression: Bool {
        get { sorting == .progression }
        set {
            guard newValue else { return }
            
            sorting = .progression
        }
    }
    
    @MainActor
    var searchText = "" {
        didSet {
            buildSections()
        }
    }
    
    var selectedItemID: String?
    var sections = [Section]()
    
    @MainActor
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService.currentSettings)
        var settings
        
        parts = storageService.automatableParts()
        equipment = storageService.automatableEquipment()
        pinnedPartIDs = storageService.pinnedPartIDs()
        pinnedEquipmentIDs = storageService.pinnedEquipmentIDs()
        showFICSMAS = settings().showFICSMAS
        
        buildSections()
    }
    
    @MainActor
    func observeStorage() async {
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { @MainActor [weak self] in
                guard let self else { return }
                
                for await pinnedPartIDs in storageService.streamPinnedPartIDs() {
                    try Task.checkCancellation()
                    
                    print("got new pin parts \(pinnedPartIDs)")
                    
                    self.pinnedPartIDs = pinnedPartIDs
                }
            }
            
            group.addTask { @MainActor [weak self] in
                guard let self else { return }
                
                for await pinnedEquipmentIDs in storageService.streamPinnedEquipmentIDs() {
                    try Task.checkCancellation()
                    
                    self.pinnedEquipmentIDs = pinnedEquipmentIDs
                }
            }
        }
    }
    
    @MainActor
    func observeSettings() async {
        for await showFICSMAS in settingsService.settings().map(\.showFICSMAS) {
            guard !Task.isCancelled else { break }
            
            self.showFICSMAS = showFICSMAS
        }
    }
    
    func isPinned(_ item: some Item) -> Bool {
        storageService.isPinned(item: item)
    }
    
    func changePinStatus(for item: some Item) {
        storageService.changeItemPinStatus(item)
    }
    
    @MainActor
    func productionViewModel(for itemID: String) -> ProductionViewModel {
        let item = storageService.item(for: itemID)!
        
        return ProductionViewModel(item: item)
    }
}

// MARK: Private
private extension NewProductionViewModel {
    @MainActor
    func buildSections() {
        Task(priority: .userInitiated) { @MainActor [weak self] in
            guard let self else { return }
            
            let newSections = switch grouping {
            case .none: await buildUngroupedSections()
            case .categories: await buildCategoriesSections()
            }
            
            if sections.isEmpty {
                sections = newSections
            } else if sections != newSections {
                withAnimation {
                    self.sections = newSections
                }
            }
        }
    }
    
    func buildUngroupedSections() async -> [Section] {
        let (pinnedParts, unpinnedParts) = await splitParts()
        let (pinnedEquipment, unpinnedEquipment) = await splitEquipment()
        
        let pinnedItems: [any Item] = pinnedParts + pinnedEquipment
        
        return [
            .pinned(pinnedItems),
            .parts("Parts", unpinnedParts),
            .equipment("Equipment", unpinnedEquipment)
        ]
    }
    
    func buildCategoriesSections() async -> [Section] {
        let (pinnedParts, unpinnedParts) = await splitParts()
        let (pinnedEquipment, unpinnedEquipment) = await splitEquipment()
        
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
        
        return [
            .pinned(pinnedItems),
        ] + partsByCategories.sorted { $0.0 < $1.0 }.map { .parts($0.0.localizedName, $0.1) }
        + equipmentByCategories.sorted { $0.0 < $1.0 }.map { .equipment($0.0.localizedName, $0.1) }
    }
    
    func splitParts() async -> (pinned: [Part], unpinned: [Part]) {
        await split(parts, pins: pinnedPartIDs)
    }
    
    func splitEquipment() async -> (pinned: [Equipment], unpinned: [Equipment]) {
        await split(equipment, pins: pinnedEquipmentIDs)
    }
    
    func split<T: ProgressiveItem>(_ items: [T], pins: Set<String>) async -> (pinned: [T], unpinned: [T]) {
        let showFICSMAS = await showFICSMAS
        let searchText = await searchText
        
        var (pinned, unpinned) = items.reduce(into: ([T](), [T]())) { partialResult, item in
            if item.category == .ficsmas, !showFICSMAS {
                return
            }
            
            if searchText.isEmpty || item.category.localizedName.localizedCaseInsensitiveContains(searchText) || item.localizedName.localizedCaseInsensitiveContains(searchText) {
                if pins.contains(item.id) {
                    partialResult.0.append(item)
                } else {
                    partialResult.1.append(item)
                }
            }
        }
        
        await sort(&pinned)
        await sort(&unpinned)
        
        return (pinned, unpinned)
    }
    
    func sort<T: ProgressiveItem>(_ items: inout [T]) async {
        switch await sorting {
        case .name: items.sortByName()
        case .progression: items.sortByProgression()
        }
    }
}

// MARK: - Sorting
extension NewProductionViewModel {
    enum Sorting {
        case name
        case progression
    }
}

// MARK: - Grouping
extension NewProductionViewModel {
    enum Grouping {
        case none
        case categories
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
