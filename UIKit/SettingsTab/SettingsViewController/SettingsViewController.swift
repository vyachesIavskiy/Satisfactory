import UIKit
import SwiftUI
import Combine

final class SettingsViewController: UIViewController {
    private let viewModel = SettingsViewModel()
    private var cancellables = Set<AnyCancellable>()
    
//    enum Section {
//        case other
//        case feedback
//    }
//    
//    struct NavigationItem: Hashable {
//        let id = UUID()
//        
//        var title: String
//    }
//    
//    struct FeedbackItem: Hashable {
//        let id = UUID()
//        
//        var title: String
//    }
//    
//    enum Item: Hashable {
//        case navigation(NavigationItem)
//        case feedback(FeedbackItem)
//    }
    
    private let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())
    private var dataSource: UICollectionViewDiffableDataSource<SettingsViewModel.Section.ID, SettingsViewModel.ListItem>!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        layout()
        configureCollectionView()
        observeViewModel()
        
        title = "Settings"
    }
}

private extension SettingsViewController {
    func layout() {
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    func configureCollectionView() {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, env in
            var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
            configuration.headerMode = .firstItemInSection
            let section = NSCollectionLayoutSection.list(using: configuration, layoutEnvironment: env)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
            return section
        }
        
        collectionView.setCollectionViewLayout(layout, animated: false)
        collectionView.backgroundColor = .systemGroupedBackground
        
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SettingsViewModel.HeaderListItem> { cell, indexPath, item in
            var configuration = cell.defaultContentConfiguration()
            configuration.text = item.text
            cell.contentConfiguration = configuration
        }
        
        let toggleCellRegistration = UICollectionView.CellRegistration<ToggleCell, SettingsViewModel.ToggleListItem> { [unowned collectionView, unowned viewModel] cell, indexPath, item in
            cell.index = indexPath.item
            cell.numberOfItems = collectionView.numberOfItems(inSection: indexPath.section)
            cell.contentConfiguration = ToggleCellConfiguration(
                title: item.title,
                subtitle: item.subtitle,
                isOn: item.isOn
            ) { newValue in
                viewModel.change(toggleListItem: item, to: newValue)
            }
        }
        
//        let navigationCellRegistration = UICollectionView.CellRegistration<SHListCell, NavigationItem> { [unowned collectionView] cell, indexPath, item in
//            var configuration = cell.defaultContentConfiguration()
//            configuration.text = item.title
//            cell.contentConfiguration = configuration
//            cell.index = indexPath.item
//            cell.numberOfItems = collectionView.numberOfItems(inSection: indexPath.section)
//            cell.accessories = [
//                .disclosureIndicator()
//            ]
//        }
        
//        let feedbackCellRegistration = UICollectionView.CellRegistration<SHListCell, FeedbackItem> { [unowned collectionView] cell, indexPath, item in
//            cell.contentConfiguration = FeedbackCellConfiguration(text: item.title)
//            cell.index = indexPath.item
//            cell.numberOfItems = collectionView.numberOfItems(inSection: indexPath.section)
//            cell.backgroundConfiguration?.backgroundColor = .sh(.orange)
//        }
        
        dataSource = UICollectionViewDiffableDataSource(collectionView: collectionView) { collectionView, indexPath, item in
            switch item {
            case let .header(header):
                collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: header)
                
            case let .toggle(toggle):
                collectionView.dequeueConfiguredReusableCell(using: toggleCellRegistration, for: indexPath, item: toggle)
                
//            case let .navigation(navigation):
//                collectionView.dequeueConfiguredReusableCell(using: navigationCellRegistration, for: indexPath, item: navigation)
//                
//            case let .feedback(feedback):
//                collectionView.dequeueConfiguredReusableCell(using: feedbackCellRegistration, for: indexPath, item: feedback)
            }
        }
    }
    
    func observeViewModel() {
        viewModel.$sections
            .receive(on: RunLoop.main)
            .sink { [weak self] sections in
                self?.updateDataSource(with: sections)
            }
            .store(in: &cancellables)
    }
    
    func updateDataSource(with sections: [SettingsViewModel.Section]) {
        for section in sections {
            let snapshot = buildSectionSnapshot(section)
            dataSource.apply(snapshot, to: section.id, animatingDifferences: false)
        }
    }
    
    func buildSectionSnapshot(
        _ section: SettingsViewModel.Section
    ) -> NSDiffableDataSourceSectionSnapshot<SettingsViewModel.ListItem> {
        var snapshot = NSDiffableDataSourceSectionSnapshot<SettingsViewModel.ListItem>()
        snapshot.append(section.items)
        return snapshot
    }
}

#Preview("Settings") {
    SHNavigationController(rootViewController: SettingsViewController())
}
