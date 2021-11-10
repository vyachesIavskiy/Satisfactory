//
//  ItemListView.swift
//  ItemListView
//
//  Created by Slava Nagornyak on 17.07.2021.
//

import SwiftUI

struct ItemListView: View {
    private let parts = Storage.shared.parts.sortedByTiers()
    private let equipments = Storage.shared.equipments
    
    @State private var searchTerm = ""
    
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
                Section(header: Text("Parts")) {
                    ForEach(filteredParts) { part in
                        Group {
                            if part.recipes.isEmpty {
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
                
                Section(header: Text("Equipment")) {
                    ForEach(filteredEquipment) { equipment in
                        Group {
                            if equipment.recipes.isEmpty {
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
            .listStyle(.insetGrouped)
            .searchable(
                text: $searchTerm,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: "Search for an item..."
            )
            .navigationTitle("Select an item to produce")
            .navigationBarTitleDisplayMode(.inline)
        }
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
    static var previews: some View {
        ItemListView()
    }
}
