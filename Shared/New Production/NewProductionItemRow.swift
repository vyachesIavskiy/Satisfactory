import SwiftUI
import SHModels
import SHStorage

extension NewProductionView {
    struct ItemRow: View {
        var item: any Item
        
        @Environment(\.displayScale) 
        private var displayScale
        
        init(_ item: any Item) {
            self.item = item
        }
        
        var body: some View {
            HStack(spacing: 12) {
                ListRowIcon(item: item)
                
                HStack {
                    Text(item.localizedName)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .fontWeight(.light)
                        .foregroundColor(.sh(.gray40))
                }
                .addListGradientSeparator()
            }
            .fixedSize(horizontal: false, vertical: true)
        }
    }
}

#if DEBUG
import SHDebug

private struct _ItemRowPreview: View {
    @Dependency(\.storageService)
    private var storageService
    
    var items: [any Item] {
        [
            storageService.item(id: "part-iron-ore"),
            storageService.item(id: "part-iron-ingot"),
            storageService.item(id: "part-iron-plate"),
            storageService.item(id: "part-heavy-modular-frame"),
            storageService.item(id: "part-water"),
            storageService.item(id: "part-nitrogen-gas"),
            storageService.item(id: "part-packaged-oil")
        ].compactMap { $0 }
    }
    
    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                NewProductionView.ItemRow(item)
                    .contextMenu {
                        Button("Preview") {
                            
                        }
                    }
            }
            .listRowSeparator(.hidden)
        }
        .listStyle(.plain)
    }
}

#Preview("List item row") {
    _ItemRowPreview()
}
#endif
