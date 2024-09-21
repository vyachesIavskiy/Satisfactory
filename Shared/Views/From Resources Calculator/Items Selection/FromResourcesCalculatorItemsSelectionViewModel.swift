import SwiftUI
import SHModels
import SHStorage
import SHSettings

@Observable
final class FromResourcesCalculatorItemsSelectionViewModel {
    // MARK: Observed
    var sorting = Sorting.progression {
        didSet {
            updateSections(animated: true)
        }
    }
    
    var sections = [Section]()
    
    var selectedPartIDs = Set<String>()
    
    // MARK: Ignored
    private let parts: [Part]
    
    @ObservationIgnored
    private var pinnedPartIDs: Set<String> {
        didSet {
            if oldValue != pinnedPartIDs {
                updateSections(animated: true)
            }
        }
    }
    
    @ObservationIgnored
    private var showFICSMAS: Bool {
        didSet {
            if oldValue != showFICSMAS {
                updateSections(animated: true)
            }
        }
    }
    
    @ObservationIgnored
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
    
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        parts = storageService.parts()
        pinnedPartIDs = storageService.pinnedFromResourcesPartIDs
        showFICSMAS = settingsService.showFICSMAS
    }
    
    @MainActor
    func observeStorage() async {
        for await pinnedPartIDs in storageService.streamPinnedFromResourcesPartIDs {
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
    
    func buildInitialSections() {
        updateSections(animated: false)
    }
    
    func isPinned(_ part: Part) -> Bool {
        storageService.isPinned(part, productionType: .singleItem)
    }
    
    func changePinStatus(for part: Part) {
        storageService.changePinStatus(for: part, productionType: .singleItem)
    }
    
    func selectPart(_ part: Part) {
        if isSelected(part) {
            selectedPartIDs.remove(part.id)
        } else {
            selectedPartIDs.insert(part.id)
        }
    }
    
    func isSelected(_ part: Part) -> Bool {
        selectedPartIDs.contains(part.id)
    }
}

// MARK: Private
private extension FromResourcesCalculatorItemsSelectionViewModel {
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
    
    func buildSections() async -> [Section] {
        let automatableParts = parts.filter {
            !storageService.recipes(for: $0, as: .input).isEmpty
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
    
    func split(_ parts: [Part]) -> (pinned: [Part], unpinned: [Part]) {
        var (pinned, unpinned) = parts.reduce(into: ([Part](), [Part]())) { partialResult, part in
            if part.category == .ficsmas, !showFICSMAS {
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
extension FromResourcesCalculatorItemsSelectionViewModel {
    enum Sorting {
        case name
        case progression
    }
}

// MARK: - Section
extension FromResourcesCalculatorItemsSelectionViewModel {
    struct Section: Identifiable, Equatable {
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
