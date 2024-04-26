import SwiftUI

struct ListItemSection: View {
    var title: LocalizedStringKey
    var items: [Item]
    var isSearching: Bool
    @Binding var isExpanded: Bool
    
    @EnvironmentObject private var storage: Storage
    
    var body: some View {
        if !items.isEmpty {
            Section {
                if isExpanded {
                    ForEach(items, id: \.id) { item in
                        itemView(item)
                            .tag(item.id)
                            .id(item.id)
                            .transition(.move(edge: .top).combined(with: .opacity))
                    }
                    
                    if !isSearching {
                        ListSectionFooterShape(cornerRadius: 10)
                            .stroke(lineWidth: 0.75)
                            .foregroundStyle(Color("Secondary").opacity(0.75))
                            .shadow(color: Color("Secondary").opacity(0.5), radius: 2)
                    }
                }
            } header: {
                if !isSearching {
                    ListSectionHeaderNew(
                        title: title,
                        isExpanded: $isExpanded
                    )
                }
            }
        }
    }
    
    private func itemView(_ item: Item) -> some View {
        NavigationLink {
            RecipeCalculationView(item: item)
        } label: {
            ListItemRow(item: item)
                .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
        .padding(.horizontal, 10)
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

struct ListItemSection_Previews: PreviewProvider {
    private struct Preview: View {
        @State private var isExpanded = false
        
        @EnvironmentObject private var storage: Storage
        
        var body: some View {
            ListItemSection(
                title: "Preview Section",
                items: storage.equipments
                    .filter { !storage[recipesFor: $0.id].isEmpty },
                isSearching: false,
                isExpanded: $isExpanded
            )
        }
    }
    
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        Preview()
            .environmentObject(storage)
    }
}
