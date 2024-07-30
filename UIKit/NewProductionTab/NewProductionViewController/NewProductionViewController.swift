import UIKit
import SwiftUI
import Combine
import SHModels
import SHStorage
import SHSettings

final class NewProductionViewModel {
    private let parts: [Part]
    private let equipment: [Equipment]
    private var pinnedItemIDs: Set<String>
    private var showFICSMAS: Bool
    
    @Published
    var sorting = Sorting.progression {
        didSet {
            buildSections()
        }
    }
    
    @Published
    var sections = [Section]()
    
    var searchText = ""
    
    @Dependency(\.storageService)
    private var storageService
    
    @Dependency(\.settingsService)
    private var settingsService
    
    init() {
        @Dependency(\.storageService)
        var storageService
        
        @Dependency(\.settingsService)
        var settingsService
        
        parts = storageService.automatableParts()
        equipment = storageService.automatableEquipment()
        pinnedItemIDs = storageService.pinnedItemIDs
        showFICSMAS = settingsService.showFICSMAS
        
        observeSettingsAndStorage()
        buildSections()
    }
    
    private func observeSettingsAndStorage() {
        Task {
            await withTaskGroup(of: Void.self) { group in
                group.addTask { @MainActor [weak self] in
                    guard let self else { return }
                    
                    for await pinnedItemIDs in storageService.streamPinnedItemIDs {
                        guard !Task.isCancelled else { break }
                        guard self.pinnedItemIDs != pinnedItemIDs else { continue }
                        
                        self.pinnedItemIDs = pinnedItemIDs
                        buildSections()
                    }
                }
                
                group.addTask { @MainActor [weak self] in
                    guard let self else { return }
                    
                    for await showFICSMAS in settingsService.streamSettings().map(\.showFICSMAS) {
                        guard !Task.isCancelled else { break }
                        guard self.showFICSMAS != showFICSMAS else { continue }
                        
                        self.showFICSMAS = showFICSMAS
                        buildSections()
                    }
                }
            }
        }
    }
    
    func isPinned(_ item: any Item) -> Bool {
        storageService.isPinned(item)
    }
    
    func changePinStatus(for item: some Item) {
        storageService.changePinStatus(for: item)
    }
    
    private func buildSections() {
        sections = buildCategoriesSections()
    }
    
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
        
        var result: [Section] = if pinnedItems.isEmpty {
            []
        } else {
            [.pinned(pinnedItems)]
        }
        
        result += partsByCategories.filter { !$0.1.isEmpty }.sorted { $0.0 < $1.0 }.map { .parts(title: $0.0.localizedName, parts: $0.1) } +
        equipmentByCategories.filter { !$0.1.isEmpty }.sorted { $0.0 < $1.0 }.map { .equipment(title: $0.0.localizedName, equipment: $0.1) }
        
        return result
    }
    
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

extension NewProductionViewModel {
    enum Sorting {
        case name
        case progression
    }
}

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
            case .pinned: "Pinned"
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

final class NewProductionViewController: UIViewController {
    private let viewModel = NewProductionViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let collectionView: UICollectionView = {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            // Not pinned items sections
            var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
            configuration.showsSeparators = false
            configuration.headerMode = .firstItemInSection
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: env)
            return section
        }
        layout.configuration.interSectionSpacing = 24
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var nameSortingAction: UIAction!
    private var progressionSortingAction: UIAction!
    
    private var dataSource: UICollectionViewDiffableDataSource<NewProductionViewModel.Section.ID, ListItem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "New Production"
        
        configureSortingBarButtonItem()
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.delegate = self
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, HeaderItem> { cell, indexPath, item in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = item.text
            cell.contentConfiguration = configuration
        }
        
        let cellRegistration = UICollectionView.CellRegistration<ItemCell, CellItem> { [unowned collectionView] cell, indexPath, item in
            cell.itemID = item.itemID
            cell.index = indexPath.item
            cell.numberOfItems = collectionView.numberOfItems(inSection: indexPath.section)
        }
        
        dataSource = UICollectionViewDiffableDataSource<NewProductionViewModel.Section.ID, ListItem>(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case let .header(header):
                collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: header)
                
            case let .cell(cell):
                collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: cell)
            }
        }
        
        viewModel.$sections
            .receive(on: RunLoop.main)
            .sink { [weak self] sections in
                self?.update(sections)
            }
            .store(in: &cancellables)
        
        viewModel.$sorting
            .receive(on: RunLoop.main)
            .sink { [weak self] sorting in
                self?.updateSortingButton(sorting)
            }
            .store(in: &cancellables)
    }
    
    private func configureSortingBarButtonItem() {
        nameSortingAction = UIAction(title: "Name") { [viewModel] _ in
            viewModel.sorting = .name
        }
        
        progressionSortingAction = UIAction(title: "Progression") { [viewModel] _ in
            viewModel.sorting = .progression
        }
        
        let deffered = UIDeferredMenuElement.uncached { [unowned self] provider in
            provider([nameSortingAction, progressionSortingAction])
        }
        
        let sortBarButtonItem = UIBarButtonItem(
            title: "Sort",
            image: UIImage(systemName: "arrow.up.arrow.down.square"),
            menu: UIMenu(
                title: "Sorting",
                options: .singleSelection,
                children: [deffered]
            )
        )
        
        navigationItem.rightBarButtonItem = sortBarButtonItem
        updateSortingButton(viewModel.sorting)
    }
    
    private func update(_ sections: [NewProductionViewModel.Section]) {
        for section in sections {
            var snapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
            snapshot.append(
                [.header(HeaderItem(text: section.title))] +
                section.items.map { ListItem.cell(CellItem(itemID: $0.id)) }
            )
            dataSource.apply(snapshot, to: section.id)
        }
    }
    
    private func updateSortingButton(_ sorting: NewProductionViewModel.Sorting) {
        switch sorting {
        case .name:
            nameSortingAction.state = .on
            
        case .progression:
            progressionSortingAction.state = .on
        }
    }
    
    enum ListItem: Hashable {
        case header(HeaderItem)
        case cell(CellItem)
    }
    
    struct HeaderItem: Hashable {
        let id = UUID()
        var text: String
    }
    
    struct CellItem: Hashable {
        let id = UUID()
        var itemID: String
    }
}

extension NewProductionViewController: UICollectionViewDelegate {
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfigurationForItemsAt indexPaths: [IndexPath],
        point: CGPoint
    ) -> UIContextMenuConfiguration? {
        guard let firstIndexPath = indexPaths.first else { return nil }
        
        return UIContextMenuConfiguration(previewProvider: nil) { [viewModel] elements in
            let item = viewModel.sections[firstIndexPath.section].items[firstIndexPath.item - 1]
            let isPinned = viewModel.isPinned(item)
            let pinAction = UIAction(title: isPinned ? "Unpin" : "Pin") { _ in
                viewModel.changePinStatus(for: item)
            }
            
            return UIMenu(children: [pinAction])
        }
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        contextMenuConfiguration configuration: UIContextMenuConfiguration,
        highlightPreviewForItemAt indexPath: IndexPath
    ) -> UITargetedPreview? {
        guard let cell = collectionView.cellForItem(at: indexPath) else { return nil }
        
        let item = viewModel.sections[indexPath.section].items[indexPath.item - 1]
        let form = (item as? Part)?.form
        
        let visibleCGPath = switch form {
        case .solid, nil:
            AngledRectangle(cornerRadius: 8)
                .path(in: cell.bounds)
                .cgPath
            
        case .fluid, .gas:
            UnevenRoundedRectangle(bottomLeadingRadius: 16, topTrailingRadius: 16)
                .path(in: cell.bounds)
                .cgPath
        }
        
        let parameters = UIPreviewParameters()
        parameters.visiblePath = UIBezierPath(cgPath: visibleCGPath)
        
        return UITargetedPreview(view: cell, parameters: parameters)
    }
}

#Preview("New Production") {
    UINavigationController(rootViewController: NewProductionViewController())
}
