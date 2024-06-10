import SwiftUI
import Dependencies
import SHModels
import SHStorage

final class ItemListViewModel: ObservableObject {
    struct PinnedSection: Identifiable {
        var items: [any SHModels.Item]
        var isExpanded = true
        
        var id: String { "Pinned" }
    }
    
    struct Section<SectionItem: SHModels.Item>: Identifiable, Comparable {
        var category: SHModels.Category
        var items: [SectionItem]
        var isExpanded = true
        
        var id: String { category.id }
        
        static func < (lhs: ItemListViewModel.Section<SectionItem>, rhs: ItemListViewModel.Section<SectionItem>) -> Bool {
            lhs.category < rhs.category
        }
    }
    
    private var _parts = [SHModels.Part]()
    private var _equipment = [SHModels.Equipment]()
    
    @Published var pinnedSection = PinnedSection(items: [])
    @Published var partSections = [Section<SHModels.Part>]()
    @Published var equipmentSections = [Section<SHModels.Equipment>]()
    
//    @Dependency(\.storageClient)
//    private var storageClient
    
    @Published var pinnedExpanded = true
    @Published var partsExpanded = true
    @Published var equipmentExpanded = true
    
    @Published var searchTerm = ""
    
    let storage = Storage()
    
    private func satisfySearchTerm(_ item: some SHModels.Item) -> Bool {
        guard !searchTerm.isEmpty else { return true }
        
        let searchTerm = searchTerm.lowercased()
        
        return item.id.lowercased().contains(searchTerm) ||
        item.localizedName.lowercased().contains(searchTerm) ||
        item.localizedDescription.lowercased().contains(searchTerm)
    }
    
    @MainActor
    func pinItem(_ item: some SHModels.Item) {
        // TODO: Pin item
    }
    
    @MainActor
    func viewAppear() {
        func automaticallyCraftable(_ item: some SHModels.Item) -> Bool {
//            let recipes = storageClient.recipesForItem(item, .output) + storageClient.recipesForItem(item, .byproduct)
//            
//            return !recipes.filter { $0.machine != nil }.isEmpty
            true
        }
        
        // Fetch and store all parts and equipment since their data is static
//        _parts = storageClient.parts().filter(automaticallyCraftable)
//        _equipment = storageClient.equipment().filter(automaticallyCraftable)
        
        _parts = []
        _equipment = []
        
        // Collect pinned items
        pinnedSection.items = _parts + _equipment
        
        // Devide pinned/not pinned items
        partSections = _parts.reduce(into: []) { partialResult, part in
            if let index = partialResult.firstIndex(where: { $0.category == part.category }) {
                partialResult[index].items.append(part)
            } else {
                partialResult.append(Section(category: part.category, items: [part]))
            }
        }.sorted()
        
        equipmentSections = _equipment.reduce(into: []) { partialResult, equipment in
            if let index = partialResult.firstIndex(where: { $0.category == equipment.category }) {
                partialResult[index].items.append(equipment)
            } else {
                partialResult.append(Section(category: equipment.category, items: [equipment]))
            }
        }.sorted()
        
        for index in partSections.indices {
            partSections[index].items.sortByName()
        }
        
        for index in equipmentSections.indices {
            equipmentSections[index].items.sortByName()
        }
    }
    
    @MainActor
    func pinsTask() async {
//        for await pins in storageClient.pinsStream() {
//            objectWillChange.send()
//        }
    }
}

struct ItemListView: View {
    @ObservedObject var viewModel: ItemListViewModel
    
    // MARK: - UI
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
//                    ListItemSection(
//                        title: "Pinned",
//                        items: viewModel.pinnedSection.items,
//                        isSearching: !viewModel.searchTerm.isEmpty,
//                        isExpanded: $viewModel.pinnedSection.isExpanded
//                    ) { viewModel.pinItem($0) }
                    
                    pinnedSection($viewModel.pinnedSection)
                    
                    ForEach($viewModel.partSections) { $section in
                        sectionView($section)
                        
//                        ListItemSection(
//                            title: section.category.localizedName,
//                            items: section.items,
//                            isSearching: !viewModel.searchTerm.isEmpty,
//                            isExpanded: $section.isExpanded
//                        ) { viewModel.pinItem($0) }
                    }
                    
                    ForEach($viewModel.equipmentSections) { $section in
                        sectionView($section)
//                        ListItemSection(
//                            title: section.category.localizedName,
//                            items: section.items,
//                            isSearching: !viewModel.searchTerm.isEmpty,
//                            isExpanded: $section.isExpanded
//                        ) { viewModel.pinItem($0) }
                    }
                }
                .padding(.horizontal, 16)
            }
            .searchable(
                text: $viewModel.searchTerm,
                placement: .navigationBarDrawer,
                prompt: "Search"
            )
            .autocorrectionDisabled(true)
            .navigationTitle("New Production")
        }
        .onAppear(perform: viewModel.viewAppear)
        .task {
            await viewModel.pinsTask()
        }
    }
    
    @ViewBuilder
    private func pinnedSection(_ section: Binding<ItemListViewModel.PinnedSection>) -> some View {
        if !section.wrappedValue.items.isEmpty {
            Section {
                if section.wrappedValue.isExpanded {
                    ForEach(section.wrappedValue.items, id: \.id) { item in
                        itemView(item)
                            .tag(item.id)
                            .id(item.id)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
//                    if viewModel.searchTerm.isEmpty {
//                        sectionFooter
//                    }
                }
            } header: {
                if viewModel.searchTerm.isEmpty {
                    sectionHeader(
                        title: "Pinned",
                        isExpanded: section.isExpanded
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    private func sectionView<I: SHModels.Item>(_ section: Binding<ItemListViewModel.Section<I>>) -> some View {
        if !section.wrappedValue.items.isEmpty {
            Section {
                if section.wrappedValue.isExpanded {
                    ForEach(section.wrappedValue.items, id: \.id) { item in
                        itemView(item)
                            .tag(item.id)
                            .id(item.id)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
//                    if viewModel.searchTerm.isEmpty {
//                        sectionFooter
//                    }
                }
            } header: {
                if viewModel.searchTerm.isEmpty {
                    sectionHeader(
                        title: section.wrappedValue.category.localizedName,
                        isExpanded: section.isExpanded
                    )
                }
            }
        }
    }
    
    @ViewBuilder
    private func sectionHeader(title: String, isExpanded: Binding<Bool>) -> some View {
//        ListSectionHeaderNew(title: title, isExpanded: isExpanded)
        Text(title)
    }
    
    @ViewBuilder
    private func itemView(_ item: any SHModels.Item) -> some View {
        NavigationLink {
//            RecipeCalculationView(item: item)
        } label: {
            NewProductionView.ItemRow(item)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 10)
//        .contextMenu {
//            Button {
//                withAnimation {
//                    storage[itemID: item.id]?.isPinned.toggle()
//                }
//            } label: {
//                Label(
//                    storage[itemID: item.id]?.isPinned == true ? "Unpin" : "Pin",
//                    systemImage: storage[itemID: item.id]?.isPinned == true ? "pin.fill" : "pin"
//                )
//            }
//        }
    }
}

struct ItemListPreview: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ItemListView(viewModel: ItemListViewModel())
            .environmentObject(storage)
            .environmentObject(Settings())
    }
}
