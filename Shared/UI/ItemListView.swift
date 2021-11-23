import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var storage: Storage
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    @Environment(\.verticalSizeClass) var verticalSizeClass
    
    private var parts: [Part] {
        storage.parts.sortedByTiers()
    }
    
    private var equipments: [Equipment] {
        storage.equipments
    }
    
    @State private var searchTerm = ""
    
    @State private var isPresentingSettings = false
    
    private var filteredParts: [Part] {
        let unfavoriteParts = parts.filter { !$0.isFavorite }
        
        guard !searchTerm.isEmpty else { return unfavoriteParts }
        
        return unfavoriteParts.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var filteredFavoriteParts: [Part] {
        let favoriteParts = parts.filter(\.isFavorite)
        
        guard !searchTerm.isEmpty else {
            return favoriteParts
        }
        
        return favoriteParts.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var filteredEquipments: [Equipment] {
        let unfavoriteEquipments = equipments.filter { !$0.isFavorite }
        
        guard !searchTerm.isEmpty else { return unfavoriteEquipments }
        
        return equipments.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var filteredFavoriteEquipments: [Equipment] {
        let favoriteEquipments = equipments.filter(\.isFavorite)
        
        guard !searchTerm.isEmpty else {
            return favoriteEquipments
        }
        
        return favoriteEquipments.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var compactBody: some View {
        NavigationView {
            list
        }
        .navigationViewStyle(.stack)
    }
    
    private var regularBody: some View {
        NavigationView {
            list
        }
        .navigationViewStyle(.columns)
    }
    
    private var list: some View {
        List {
            if !filteredFavoriteParts.isEmpty {
                Section {
                    itemsList(filteredFavoriteParts)
                } header: {
                    Text("Favorite parts")
                }

            }
            
            if !filteredParts.isEmpty {
                Section {
                    itemsList(filteredParts)
                } header: {
                    Text("Parts")
                }
            }
            
            if !filteredFavoriteEquipments.isEmpty {
                Section {
                    itemsList(filteredFavoriteEquipments)
                } header: {
                    Text("Favorite equipment")
                }
            }
            
            if !filteredEquipments.isEmpty {
                Section {
                    itemsList(filteredEquipments)
                } header: {
                    Text("Equipment")
                }
            }
        }
        .listStyle(.insetGrouped)
        .searchable(
            text: $searchTerm,
            placement: .navigationBarDrawer(displayMode: .always),
            prompt: "Search for an item..."
        )
        .navigationTitle("Select an item to produce")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    isPresentingSettings = true
                } label: {
                    Image(systemName: "gear")
                }
            }
        }
        .sheet(isPresented: $isPresentingSettings) {
            SettingsView()
        }
    }
    
    var body: some View {
        if horizontalSizeClass == .regular && verticalSizeClass == .regular {
            regularBody
        } else {
            compactBody
        }
    }
    
    private func itemsList(_ items: [Item]) -> some View {
        ForEach(items, id: \.id) { item in
            itemView(item)
        }
    }
    
    private func itemView(_ item: Item) -> some View {
        Group {
            if storage[recipesFor: item.id].isEmpty {
                ItemRow(item: item, showAmountOfProductionChains: true)
            } else {
                NavigationLink {
                    RecipeCalculationView(item: item)
                } label: {
                    ItemRow(item: item, showAmountOfProductionChains: true)
                }
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button {
                withAnimation {
                    storage[itemID: item.id]?.isFavorite.toggle()
                }
            } label: {
                Label(
                    item.isFavorite ? "Unfavorite" : "Favorite",
                    systemImage: item.isFavorite ? "heart.slash" : "heart"
                )
            }
            .tint(.orange)
        }
    }
}

struct ItemListPreview: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ItemListView()
            .environmentObject(storage)
    }
}
