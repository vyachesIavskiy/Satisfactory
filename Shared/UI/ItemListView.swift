import SwiftUI

extension ItemListView {
    final class Model: ObservableObject {
        @Published var pinnedExpanded = true
        @Published var partsExpanded = true
        @Published var equipmentExpanded = true
        
        @Published var searchTerm = ""
        
        var pinnedItems: [Item] {
            filteredParts.filter(\.isPinned) +
            filteredEquipment.filter(\.isPinned)
        }
        
        var parts: [Part] {
            filteredParts.filter { !$0.isPinned }
        }
        
        var equipment: [Equipment] {
            filteredEquipment.filter { !$0.isPinned }
        }
        
        var productions: [ProductionChain] {
            storage.productionChains.sortedByTiers()
        }
        
        var statistics: [CalculationStatisticsModel] {
            productions
                .map(\.statistics)
                .reduce([], +)
                .reduceDuplicates()
        }
        
        var machineStatistics: [CalculationMachineStatisticsModel] {
            productions
                .map(\.machineStatistics)
                .reduce([], +)
                .reduceDuplicates()
                .sorted { lhs, rhs in
                    (lhs.item as? Part)?.sortingPriority ?? 1 > (rhs.item as? Part)?.sortingPriority ?? 0
                }
        }
        
        private let storage: Storage
        
        private var filteredParts: [Part] {
            storage.parts.filter {
                !storage[recipesFor: $0.id].isEmpty &&
                (
                    searchTerm.isEmpty ||
                    (
                        $0.id.lowercased().contains(searchTerm.lowercased()) ||
                        $0.name.lowercased().contains(searchTerm.lowercased())
                    )
                )
            }
            .sortedByTiers()
        }
        
        private var filteredEquipment: [Equipment] {
            storage.equipments.filter {
                !storage[recipesFor: $0.id].isEmpty &&
                (
                    searchTerm.isEmpty ||
                    (
                        $0.id.lowercased().contains(searchTerm.lowercased()) ||
                        $0.name.lowercased().contains(searchTerm.lowercased())
                    )
                )
            }
        }
        
        init(storage: Storage) {
            self.storage = storage
        }
    }
}

struct ItemListView: View {
    @ObservedObject var model: Model
    
    @EnvironmentObject private var storage: Storage
    
    @State private var isShowingStatistics = false
    
    // MARK: - UI
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 18) {
                    ListItemSection(title: "Pinned", items: model.pinnedItems, isSearching: !model.searchTerm.isEmpty, isExpanded: $model.pinnedExpanded)
                    ListItemSection(title: "Parts", items: model.parts, isSearching: !model.searchTerm.isEmpty, isExpanded: $model.partsExpanded)
                    ListItemSection(title: "Equipment", items: model.equipment, isSearching: !model.searchTerm.isEmpty, isExpanded: $model.equipmentExpanded)
                }
                .padding(.horizontal, 16)
            }
            .searchable(
                text: $model.searchTerm,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search"
            )
            .autocorrectionDisabled(true)
            .navigationTitle("Production")
            .toolbar {
                if !model.productions.isEmpty {
                    ToolbarItem(placement: .primaryAction) {
                        Button {
                            isShowingStatistics = true
                        } label: {
                            Image(systemName: "checklist.unchecked")
                        }
                    }
                }
            }
            .sheet(isPresented: $isShowingStatistics) {
                NavigationStack {
                    CalculationStatistics(data: model.statistics, machines: model.machineStatistics)
                        .toolbar {
                            ToolbarItem(placement: .confirmationAction) {
                                Button("Done") {
                                    isShowingStatistics = false
                                }
                            }
                        }
                        .navigationTitle("Production chains statistics")
                        .navigationBarTitleDisplayMode(.inline)
                }
            }
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder private func section(
        _ title: LocalizedStringKey,
        items: [Item],
        isExpanded: Binding<Bool>
    ) -> some View {
        if !items.isEmpty {
            Section {
                if isExpanded.wrappedValue {
                    VStack(spacing: 0) {
                        itemsList(items)
                        
                        ListSectionFooterShape(cornerRadius: 10)
                            .stroke(lineWidth: 0.75)
                            .foregroundStyle(Color("Secondary").opacity(0.75))
                            .listRowInsets(.none)
                            .padding(.bottom, 10)
                    }
                    .transition(.move(edge: .top).combined(with: .opacity))
                }
            } header: {
                ListSectionHeaderNew(title: title, isExpanded: isExpanded)
                    .padding(.vertical, 10)
            }
            
        }
    }
    
    private func itemsList(_ items: [Item]) -> some View {
        ForEach(items, id: \.id) { item in
            itemView(item)
        }
    }
    
    private func itemView(_ item: Item) -> some View {
        NavigationLink {
            RecipeCalculationView(item: item)
        } label: {
            ListItemRow(item: item)
        }
        .buttonStyle(.plain)
        .padding(10)
        .contextMenu {
            Button {
                withAnimation {
                    storage[itemID: item.id]?.isPinned.toggle()
                }
            } label: {
                Label(
                    storage[itemID: item.id]?.isPinned == true ? "Unpin" : "Pin",
                    systemImage: storage[itemID: item.id]?.isPinned == true ? "pin.fill" : "pin"
                )
            }
        }
    }
}

struct ItemListPreview: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ItemListView(model: ItemListView.Model(storage: storage))
            .environmentObject(storage)
            .environmentObject(Settings())
    }
}
