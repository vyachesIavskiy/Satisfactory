import SwiftUI
import SHModels

public struct ListRowItem: View {
    private let item: any Item
    private let accessory: ListRowAccessory?
    
    public init(_ item: any Item, accessory: ListRowAccessory? = nil) {
        self.item = item
        self.accessory = accessory
    }
    
    public var body: some View {
        let icon = { ListRowIconItem(item) }
        let label = { Text(item.localizedName) }
        
        if let accessory {
            ListRow(accessory: accessory, icon: icon, label: label)
        } else {
            ListRow(icon: icon, label: label)
        }
    }
}

#if DEBUG
import SHStorage

#Preview("List item row") {
    List {
        Section {
            _ListRowItemPreview(itemID: "part-iron-plate")
            _ListRowItemPreview(itemID: "part-water")
            _ListRowItemPreview(itemID: "part-reinforced-iron-plate", accessory: nil)
            _ListRowItemPreview(itemID: "part-crude-oil", accessory: nil)
        } header: {
            SectionHeader("Items")
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    .listStyle(.plain)
}

private struct _ListRowItemPreview: View {
    private let item: any Item
    private let accessory: ListRowAccessory?
    
    init(itemID: String, accessory: ListRowAccessory? = .chevron) {
        @Dependency(\.storageService)
        var storageService
        
        item = storageService.item(id: itemID)!
        self.accessory = accessory
    }
    
    var body: some View {
        ListRowItem(item, accessory: accessory)
    }
}
#endif
