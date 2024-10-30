import SwiftUI
import SHStorage
@preconcurrency import SHSettings
import SHModels

@Observable
final class SingleItemCalculatorItemSelectionViewModel {
    // MARK: Observed
    @MainActor
    var sorting = Sorting.progression {
        didSet {
            updateSections(animated: true)
        }
    }
    
    @MainActor
    var sections = [Section]()
    
    var selectedPart: Part?
    
    // MARK: Ignored
    private let parts: [Part]
    
    @MainActor @ObservationIgnored
    private var pinnedPartIDs: Set<String> {
        didSet {
            if oldValue != pinnedPartIDs {
                updateSections(animated: true)
            }
        }
    }
    
    @MainActor @ObservationIgnored
    private var showFICSMAS: Bool {
        didSet {
            if oldValue != showFICSMAS {
                updateSections(animated: true)
            }
        }
    }
    
    @MainActor @ObservationIgnored
    var searchText = "" {
        didSet {
            updateSections(animated: true)
        }
    }
    
    // MARK: Dependencies
    @ObservationIgnored @Dependency(\.storageService)
    private var storageService
    
    @ObservationIgnored @Dependency(\.settingsService)
    private var settingsService
    
    // MARK: -
    @MainActor
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        parts = storageService.automatableParts()
        pinnedPartIDs = storageService.pinnedSingleItemPartIDs
        showFICSMAS = settingsService.showFICSMAS
    }
    
    @MainActor
    func observeStorage() async {
        for await pinnedPartIDs in storageService.streamPinnedSingleItemPartIDs {
            guard !Task.isCancelled else { break }
            
            self.pinnedPartIDs = pinnedPartIDs
        }
    }
    
    @MainActor
    func observeSettings() async {
        for await showFICSMAS in settingsService.streamSettings().map(\.showFICSMAS) {
            guard !Task.isCancelled else { break }
            
            self.showFICSMAS = showFICSMAS
        }
    }
    
    @MainActor
    func buildInitialSections() {
        updateSections(animated: false)
    }
    
    @MainActor
    func isPinned(_ part: Part) -> Bool {
        storageService.isPinned(part, productionType: .singleItem)
    }
    
    @MainActor
    func changePinStatus(for part: Part) {
        storageService.changePinStatus(for: part, productionType: .singleItem)
    }
    
    func selectItem(_ part: Part) {
        selectedPart = part
    }
}

// MARK: Private
private extension SingleItemCalculatorItemSelectionViewModel {
    @MainActor
    func updateSections(animated: Bool) {
        Task(priority: .userInitiated) { @MainActor [weak self] in
            guard let self else { return }
            
            var newSections = await buildSections()
            
            if !sections.isEmpty {
                for (index, newSection) in newSections.enumerated() {
                    let expanded = sections.first { $0.id == newSection.id }?.expanded ?? true
                    newSections[index].expanded = expanded
                }
            }
            
            withAnimation(animated ? .default : nil) {
                self.sections = newSections
            }
        }
    }
    
    @MainActor
    func buildSections() async -> [Section] {
        let automatableParts = parts.filter {
            !storageService.recipes(for: $0, as: [.output, .byproduct]).isEmpty
        }
        let (pinnedParts, unpinnedParts) = split(automatableParts)
        
        let partsByCategories = unpinnedParts.reduce(into: [(SHModels.Category, [Part])]()) { partialResult, part in
            if let index = partialResult.firstIndex(where: { $0.0 == part.category }) {
                partialResult[index].1.append(part)
            } else {
                partialResult.append((part.category, [part]))
            }
        }
        
        return [.pinned(pinnedParts)] +
        partsByCategories.sorted { $0.0 < $1.0 }.map { .parts(title: $0.0.localizedName, parts: $0.1) }
    }
    
//    @MainActor
//    func buildFromResourcesSections() -> [Section] {
//        let automatableParts = parts.filter {
//            !storageService.recipes(for: $0, as: .input).isEmpty
//        }
//        let automatableEquipment = equipment.filter {
//            !storageService.recipes(for: $0, as: .input).isEmpty
//        }
//        let (pinnedParts, unpinnedParts) = split(automatableParts)
//        let (pinnedEquipment, unpinnedEquipment) = split(automatableEquipment)
//        
//        let pinnedItems: [any Item] = pinnedParts + pinnedEquipment
//        
//        let partsByCategories = unpinnedParts.reduce(into: [(SHModels.Category, [Part])]()) { partialResult, part in
//            if let index = partialResult.firstIndex(where: { $0.0 == part.category }) {
//                partialResult[index].1.append(part)
//            } else {
//                partialResult.append((part.category, [part]))
//            }
//        }
//        
//        let equipmentByCategories = unpinnedEquipment.reduce(into: [(SHModels.Category, [Equipment])]()) { partialResult, equipment in
//            if let index = partialResult.firstIndex(where: { $0.0 == equipment.category }) {
//                partialResult[index].1.append(equipment)
//            } else {
//                partialResult.append((equipment.category, [equipment]))
//            }
//        }
//        
//        return [.pinned(pinnedItems)] +
//        partsByCategories.sorted { $0.0 < $1.0 }.map { .parts(title: $0.0.localizedName, parts: $0.1) } +
//        equipmentByCategories.sorted { $0.0 < $1.0 }.map { .equipment(title: $0.0.localizedName, equipment: $0.1) }
//    }
    
    @MainActor
    func split(_ parts: [Part]) -> (pinned: [Part], unpinned: [Part]) {
        var (pinned, unpinned) = parts.reduce(into: ([Part](), [Part]())) { partialResult, part in
            if part.category == .ficsmas/*, !showFICSMAS*/ {
                return
            }
            
            if
                searchText.isEmpty ||
                part.category.localizedName.localizedCaseInsensitiveContains(searchText) ||
                part.localizedName.localizedCaseInsensitiveContains(searchText)
            {
                if pinnedPartIDs.contains(part.id) {
                    partialResult.0.append(part)
                } else {
                    partialResult.1.append(part)
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
extension SingleItemCalculatorItemSelectionViewModel {
    enum Sorting {
        case name
        case progression
    }
}

// MARK: - Section
extension SingleItemCalculatorItemSelectionViewModel {
    struct Section: Identifiable, Hashable {
        enum ID: Hashable {
            case pinned
            case parts(title: String)
        }
        
        let id: ID
        var parts: [Part]
        var expanded: Bool
        
        var title: String {
            switch id {
            case .pinned: NSLocalizedString("new-production-pinned-section-name", value: "Pinned", comment: "")
            case let .parts(title): title
            }
        }
        
        private init(id: ID, parts: [Part]) {
            self.id = id
            self.parts = parts
            self.expanded = true
        }
        
        static func pinned(_ parts: [Part]) -> Self {
            Section(id: .pinned, parts: parts)
        }
        
        static func parts(title: String, parts: [Part]) -> Self {
            Section(id: .parts(title: title), parts: parts)
        }
    }
}
