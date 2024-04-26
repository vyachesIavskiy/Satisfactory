import SwiftUI

struct ListItemSection: View {
    var title: LocalizedStringKey
    var items: [Item]
    var isSearching: Bool
    @Binding var isExpanded: Bool
    
    @EnvironmentObject private var storage: Storage
    
    @State private var headerSize = CGSize.zero
    
    var body: some View {
        if !items.isEmpty {
            VStack {
                if !isSearching {
                    ListSectionHeaderNew(title: title, isExpanded: $isExpanded)
                        .readSize($headerSize)
                }
                
                LazyVStack(spacing: 0) {
                    Spacer()
                    
                    ForEach(items, id: \.id) { item in
                        itemView(item)
                            .tag(item.id)
                            .id(item.id)
                    }
                    
                    if !isSearching {
                        ListSectionFooterShape(cornerRadius: 10)
                            .stroke(lineWidth: 0.75)
                            .foregroundStyle(Color("Secondary").opacity(0.75))
                            .shadow(color: Color("Secondary").opacity(0.5), radius: 2)
                    }
                }
                .frame(alignment: .bottom)
            }
            .frame(height: (isSearching || isExpanded) ? nil : headerSize.height, alignment: .top)
            .clipShape(Rectangle().inset(by: -1))
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
