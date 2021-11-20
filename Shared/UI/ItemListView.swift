import SwiftUI

struct ItemListView: View {
    @EnvironmentObject var storage: BaseStorage
    
    private var parts: [Part] {
        storage.parts.sortedByTiers()
    }
    
    private var equipments: [Equipment] {
        storage.equipments
    }
    
    @State private var searchTerm = ""
    
    @State private var isPresentingSettings = false
    
    private var filteredParts: [Part] {
        guard !searchTerm.isEmpty else { return parts }
        
        return parts.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    private var filteredEquipment: [Equipment] {
        guard !searchTerm.isEmpty else { return equipments }
        
        return equipments.filter { $0.name.lowercased().contains(searchTerm.lowercased()) }
    }
    
    var body: some View {
        NavigationView {
            List {
                if !filteredParts.isEmpty {
                    Section(header: Text("Parts")) {
                        ForEach(filteredParts) { part in
                            Group {
                                if storage[recipesFor: part.id].isEmpty {
                                    ItemRow(item: part)
                                } else {
                                    NavigationLink {
                                        RecipeCalculationView(item: part)
                                    } label: {
                                        ItemRow(item: part)
                                    }
                                }
                            }
                        }
                    }
                }
                
                if !filteredEquipment.isEmpty {
                    Section(header: Text("Equipment")) {
                        ForEach(filteredEquipment) { equipment in
                            Group {
                                if storage[recipesFor: equipment.id].isEmpty {
                                    ItemRow(item: equipment)
                                } else {
                                    NavigationLink {
                                        RecipeCalculationView(item: equipment)
                                    } label: {
                                        ItemRow(item: equipment)
                                    }
                                }
                            }
                        }
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
        .navigationViewStyle(.stack)
    }
    
    func parts(in rawValue: Int) -> [Part] {
        guard let tier = Tier(rawValue: rawValue) else { return [] }
        return parts.filter { $0.tier == tier }
    }
    
    func parts(in rawValue: Int, milestone: Int) -> [Part] {
        guard let tier = Tier(rawValue: rawValue) else { return [] }
        return parts.filter { $0.tier == tier && $0.milestone == milestone }
    }
}

struct ItemListPreview: PreviewProvider {
    @StateObject private static var storage: BaseStorage = PreviewStorage()
    
    static var previews: some View {
        ItemListView()
            .environmentObject(storage)
    }
}
