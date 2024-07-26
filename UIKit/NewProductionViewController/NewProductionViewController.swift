import UIKit
import SwiftUI
import SHModels
import SHStorage
import SHSettings

final class NewProductionViewModel {
    private let parts: [Part]
    private let equipment: [Equipment]
    private var pinnedItemIDs: Set<String>
    private var showFICSMAS: Bool
    
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
    
    private func buildSections() {
//        var newSections = buildCategoriesSections()
//        
//        if sections.isEmpty {
//            sections = newSections
//        } else {
//            for (index, newSection) in newSections.enumerated() {
//                let expanded = sections.first { $0.id == newSection.id }?.expanded ?? true
//                newSections[index].expanded = expanded
//            }
//            
//            withAnimation {
//                self.sections = newSections
//            }
//        }
    }
}

final class NewProductionViewController: UIViewController {
    private let collectionView: UICollectionView = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        configuration.showsSeparators = false
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        return UICollectionView(frame: .zero, collectionViewLayout: layout)
    }()
    
    private var dataSource: UICollectionViewDiffableDataSource<Section, String>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(collectionView)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, String> { cell, indexPath, itemID in
            cell.contentConfiguration = UIHostingConfiguration {
                ItemRow(itemID: itemID)
            }
        }
        
        dataSource = UICollectionViewDiffableDataSource<Section, String>(collectionView: collectionView) { collectionView, indexPath, itemID in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemID)
        }
        
        update()
    }
    
    func update() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, String>()
        snapshot.appendSections([.main])
        snapshot.appendItems(["part-iron-ore", "part-iron-ingot"])
        dataSource.apply(snapshot)
    }
    
    enum Section {
        case main
    }
}

private struct ItemRow: View {
    let itemID: String
    let item: (any Item)?
    
    @Environment(\.displayScale)
    private var displayScale
    
    @ScaledMetric(relativeTo: .body)
    private var imageSize = 40.0
    
    @ScaledMetric(relativeTo: .body)
    private var paddingSize = 6.0
    
    @ScaledMetric(relativeTo: .body)
    private var cornerRadius = 5.0
    
    @ScaledMetric(relativeTo: .body)
    private var titleSpacing = 12.0
    
    private var resolvedImageSize: Double {
        min(imageSize, 90)
    }
    
    private var resolvedPaddingSize: Double {
        min(paddingSize, 10)
    }
    
    private var resolvedCornerRadius: Double {
        min(cornerRadius, 10)
    }
    
    private var resolvedTitleSpacing: Double {
        min(titleSpacing, 32)
    }
    
    private var backgroundIconShape: AnyShape {
        switch (item as? Part)?.form {
        case .solid, nil:
            AnyShape(AngledRectangle(cornerRadius: resolvedCornerRadius).inset(by: 1 / displayScale))
            
        case .fluid, .gas:
            AnyShape(UnevenRoundedRectangle(
                bottomLeadingRadius: resolvedCornerRadius * 2,
                topTrailingRadius: resolvedCornerRadius * 2
            ).inset(by: 1 / displayScale))
        }
    }
    
    private var backgroundShape: some Shape {
        AngledRectangle(cornerRadius: 8).inset(by: -6)
    }
    
    init(itemID: String) {
        @Dependency(\.storageService)
        var storageService
        
        self.itemID = itemID
        item = storageService.item(id: itemID)
    }
    
    var body: some View {
        HStack(spacing: resolvedTitleSpacing) {
            Group {
                if let item {
                    Image(item.id)
                        .resizable()
                } else {
                    Image(systemName: "questionmark")
                        .resizable()
                }
            }
            .frame(width: resolvedImageSize, height: resolvedImageSize)
            .padding(resolvedPaddingSize)
            .background {
                backgroundIconShape
                    .fill(.sh(.midnight10))
                    .stroke(.sh(.midnight30), lineWidth: 2 / displayScale)
            }
            
            ZStack {
                if let item {
                    HStack {
                        Text(item.localizedName)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .fontWeight(.light)
                            .foregroundColor(.sh(.gray40))
                    }
                } else {
                    Text("No item with ID '\(itemID)'")
                }
                
                LinearGradient(
                    colors: [.sh(.midnight30), .sh(.midnight10)],
                    startPoint: .leading,
                    endPoint: UnitPoint(x: 0.85, y: 0.5)
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .background(.background, in: backgroundShape)
        .contentShape(.interaction, Rectangle())
        .contentShape(.contextMenuPreview, backgroundShape)
        .fixedSize(horizontal: false, vertical: true)
        .contentShape(.interaction, Rectangle())
    }
}

#Preview("New Production") {
    NewProductionViewController()
}
