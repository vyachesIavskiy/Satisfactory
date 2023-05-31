import SwiftUI

struct ItemListView: View {
    @EnvironmentObject private var storage: Storage
    @EnvironmentObject private var settings: Settings
    
    @State private var searchTerm = ""
    @State private var isShowingStatistics = false
    @State private var presentedItem: Item?
    
    @Namespace private var namespace
    
    private var parts: [Part] {
        storage.parts
            .filter { !storage[recipesFor: $0.id].isEmpty }
            .sortedByTiers()
    }
    
    private var equipments: [Equipment] {
        storage.equipments
            .filter { !storage[recipesFor: $0.id].isEmpty }
    }
    
    private var filteredParts: [Part] {
        let unpinnedParts = parts.filter { !$0.isPinned }
        
        guard !searchTerm.isEmpty else { return unpinnedParts }
        
        return unpinnedParts.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var filteredPinnedParts: [Part] {
        let pinnedParts = parts.filter(\.isPinned)
        
        guard !searchTerm.isEmpty else {
            return pinnedParts
        }
        
        return pinnedParts.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var filteredEquipments: [Equipment] {
        let unpinnedEquipments = equipments.filter { !$0.isPinned }
        
        guard !searchTerm.isEmpty else { return unpinnedEquipments }
        
        return unpinnedEquipments.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var filteredPinnedEquipments: [Equipment] {
        let pinnedEquipments = equipments.filter(\.isPinned)
        
        guard !searchTerm.isEmpty else {
            return pinnedEquipments
        }
        
        return pinnedEquipments.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var productions: [ProductionChain] {
        storage.productionChains.sortedByTiers()
    }
    
    private var statistics: [CalculationStatisticsModel] {
        productions
            .map(\.statistics)
            .reduce([], +)
            .reduceDuplicates()
    }
    
    private var machineStatistics: [CalculationMachineStatisticsModel] {
        productions
            .map(\.machineStatistics)
            .reduce([], +)
            .reduceDuplicates()
            .sorted { lhs, rhs in
                (lhs.item as? Part)?.sortingPriority ?? 1 > (rhs.item as? Part)?.sortingPriority ?? 0
            }
    }
    
    // MARK: - UI
    private var list: some View {
        List {
            section("Pinned parts", items: filteredPinnedParts)
            section("Pinned equipment", items: filteredPinnedEquipments)
            section("Parts", items: filteredParts)
            section("Equipment", items: filteredEquipments)
        }
        .frame(maxWidth: 600)
        .listStyle(.plain)
        .searchable(
            text: $searchTerm,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search"
        )
        .navigationTitle("Production")
        .safeAreaInset(edge: .bottom) {
            if !productions.isEmpty {
                Button {
                    isShowingStatistics = true
                } label: {
                    Text("Production chains statistics")
                }
                .buttonStyle(.borderedProminent)
                .padding(.bottom)
                .sheet(isPresented: $isShowingStatistics) {
                    NavigationView {
                        CalculationStatistics(data: statistics, machines: machineStatistics)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
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
        }
    }
    
    var body: some View {
        NavigationView {
            list
        }
        .navigationViewStyle(.stack)
    }
    
    @ViewBuilder private func section(_ title: String, items: [Item]) -> some View {
        Section {
            itemsList(items)
        } header: {
            if !items.isEmpty {
                ListSectionHeader(title: title)
                    .foregroundStyle(.primary)
            }
        }
        .listSectionSeparator(.hidden)
        .listRowSeparator(.hidden)
        .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
        .listRowBackground(Color.clear)
    }
    
    private func itemsList(_ items: [Item]) -> some View {
        ForEach(items, id: \.id) { item in
            itemView(item)
        }
    }
    
    private func itemView(_ item: Item) -> some View {
        Button {
            presentedItem = item
        } label: {
            ListItemRow(item: item)
                .padding(.horizontal, 10)
        }
        .fullScreenCover(isPresented: Binding(
            get: { presentedItem != nil },
            set: { newValue in
                if !newValue {
                    presentedItem = nil
                }
            }
        )) {
            if let presentedItem {
                NavigationView {
                    RecipeCalculationView(item: presentedItem)
                }
                .navigationViewStyle(.stack)
            }
        }
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
        ItemListView()
            .environmentObject(storage)
            .environmentObject(Settings())
    }
}
