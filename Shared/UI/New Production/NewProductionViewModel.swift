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
    
    private let parts: [SHModels.Part]
    private let equipment: [SHModels.Equipment]
    private var pinnedPartIDs = Set<String>() {
        didSet {
            buildSections()
        }
    }
    
    private var pinnedEquipmentIDs = Set<String>() {
        didSet {
            buildSections()
        }
    }
    
    private var showFICSMAS: Bool {
        didSet {
            buildSections()
        }
    }
    
    private var grouping = Grouping.categories {
        didSet {
            buildSections()
        }
    }
    
    private var sorting = Sorting.progression {
        didSet {
            buildSections()
        }
    }
    
    var groupingNone: Bool {
        get { grouping == .none }
        set {
            guard newValue else { return }
            
            grouping = .none
        }
    }
    
    var groupingCategories: Bool {
        get { grouping == .categories }
        set {
            guard newValue else { return }
            
            grouping = .categories
        }
    }
    
    var sortingName: Bool {
        get { sorting == .name }
        set {
            guard newValue else { return }
            
            sorting = .name
        }
    }
    
    var sortingProgression: Bool {
        get { sorting == .progression }
        set {
            guard newValue else { return }
            
            sorting = .progression
        }
    }
    
    var selectedItem: (any SHModels.Item)?
    var sections = [Section]()
    
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService.currentSettings)
        var settings
        
        parts = storageService.automatableParts()
        equipment = storageService.automatableEquipment()
        showFICSMAS = settings().showFICSMAS
    }
    
    @MainActor
    func task() async {
        await withThrowingTaskGroup(of: Void.self) { group in
            group.addTask { @MainActor [weak self] in
                guard let self else { return }
                
                for await pinnedPartIDs in storageService.pinnedPartIDs() {
                    try Task.checkCancellation()
                    
                    self.pinnedPartIDs = pinnedPartIDs
                }
            }
            
            group.addTask { @MainActor [weak self] in
                guard let self else { return }
                
                for await pinnedEquipmentIDs in storageService.pinnedEquipmentIDs() {
                    try Task.checkCancellation()
                    
                    self.pinnedEquipmentIDs = pinnedEquipmentIDs
                }
            }
            
            group.addTask { @MainActor [weak self] in
                guard let self else { return }
                
                for await showFICSMAS in settingsService.settings().map(\.showFICSMAS) {
                    try Task.checkCancellation()
                    
                    self.showFICSMAS = showFICSMAS
                }
            }
        }
    }
    
    func isPinned(_ item: some SHModels.Item) -> Bool {
        storageService.isPinned(item: item)
    }
    
    func changePinStatus(for item: some SHModels.Item) {
        storageService.changeItemPinStatus(item)
    }
    
    private func buildSections() {
        let newSections = switch grouping {
        case .none: buildUngroupedSections()
        case .categories: buildCategoriesSections()
        }
        
        if sections.isEmpty {
            sections = newSections
        } else if sections != newSections {
            withAnimation {
                sections = newSections
            }
        }
    }
    
    private func buildUngroupedSections() -> [Section] {
        let (pinnedParts, unpinnedParts) = splitParts()
        let (pinnedEquipment, unpinnedEquipment) = splitEquipment()
        
        let pinnedItems: [any SHModels.Item] = pinnedParts + pinnedEquipment
        
        return [
            .pinned(pinnedItems),
            .parts("Parts", unpinnedParts),
            .equipment("Equipment", unpinnedEquipment)
        ]
    }
    
    private func buildCategoriesSections() -> [Section] {
        let (pinnedParts, unpinnedParts) = splitParts()
        let (pinnedEquipment, unpinnedEquipment) = splitEquipment()
        
        let pinnedItems: [any SHModels.Item] = pinnedParts + pinnedEquipment
        
        let partsByCategories = unpinnedParts.reduce(into: [(SHModels.Category, [SHModels.Part])]()) { partialResult, part in
            if let index = partialResult.firstIndex(where: { $0.0 == part.category }) {
                partialResult[index].1.append(part)
            } else {
                partialResult.append((part.category, [part]))
            }
        }
        
        let equipmentByCategories = unpinnedEquipment.reduce(into: [(SHModels.Category, [SHModels.Equipment])]()) { partialResult, equipment in
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
    
    private func splitParts() -> (pinned: [SHModels.Part], unpinned: [SHModels.Part]) {
        split(parts, pins: pinnedPartIDs)
    }
    
    private func splitEquipment() -> (pinned: [SHModels.Equipment], unpinned: [SHModels.Equipment]) {
        split(equipment, pins: pinnedEquipmentIDs)
    }
    
    private func split<T: SHModels.ProgressiveItem>(_ items: [T], pins: Set<String>) -> (pinned: [T], unpinned: [T]) {
        var (pinned, unpinned) = items.reduce(into: ([T](), [T]())) { partialResult, item in
            if item.category == .ficsmas, !showFICSMAS {
                return
            }
            
            if pins.contains(item.id) {
                partialResult.0.append(item)
            } else {
                partialResult.1.append(item)
            }
        }
        
        sort(&pinned)
        sort(&unpinned)
        
        return (pinned, unpinned)
    }
    
    private func sort<T: SHModels.ProgressiveItem>(_ items: inout [T]) {
        switch sorting {
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
        case pinned(_ items: [any SHModels.Item], expanded: Bool = true)
        case parts(_ title: String, _ parts: [SHModels.Part], expanded: Bool = true)
        case equipment(_ title: String, _ equipment: [SHModels.Equipment], expanded: Bool = true)
        
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
        
        var items: [any SHModels.Item] {
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
