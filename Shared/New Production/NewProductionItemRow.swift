import SwiftUI
import SHModels
import SHStorage

extension NewProductionView {
    struct ItemRow: View {
        var item: any Item
        
        @Environment(\.displayScale) 
        private var displayScale
        
        @ScaledMetric(relativeTo: .body)
        private var imageSize = 40.0
        
        @ScaledMetric(relativeTo: .body)
        private var paddingSize = 6.0
        
        @ScaledMetric(relativeTo: .body)
        private var cornerRadius = 5.0
        
        @ScaledMetric(relativeTo: .body)
        private var titleSpacing = 12.0
        
        private var resolvedImageSize: Double {
            min(imageSize, 90)
        }
        
        private var resolvedPaddingSize: Double {
            min(paddingSize, 10)
        }
        
        private var resolvedCornerRadius: Double {
            min(cornerRadius, 10)
        }
        
        private var resolvedTitleSpacing: Double {
            min(titleSpacing, 32)
        }
        
        private var backgroundShape: AnyShape {
            switch (item as? Part)?.form {
            case .solid, nil:
                AnyShape(AngledRectangle(cornerRadius: resolvedCornerRadius).inset(by: 1 / displayScale))
                
            case .fluid, .gas:
                AnyShape(UnevenRoundedRectangle(
                    bottomLeadingRadius: resolvedCornerRadius * 2,
                    topTrailingRadius: resolvedCornerRadius * 2
                ).inset(by: 1 / displayScale))
            }
        }
        
        init(_ item: any Item) {
            self.item = item
        }
        
        var body: some View {
            HStack(spacing: resolvedTitleSpacing) {
                Image(item.id)
                    .resizable()
                    .frame(width: resolvedImageSize, height: resolvedImageSize)
                    .padding(resolvedPaddingSize)
                    .background {
                        backgroundShape
                            .fill(.sh(.midnight10))
                            .stroke(.sh(.midnight30), lineWidth: 2 / displayScale)
                    }
                
                ZStack {
                    HStack {
                        Text(item.localizedName)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .fontWeight(.light)
                            .foregroundColor(.sh(.gray40))
                    }
                    
                    LinearGradient(
                        colors: [.sh(.midnight30), .sh(.midnight10)],
                        startPoint: .leading,
                        endPoint: UnitPoint(x: 0.85, y: 0.5)
                    )
                    .frame(height: 2 / displayScale)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .contentShape(.interaction, Rectangle())
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
            storageService.item(withID: "part-iron-ore"),
            storageService.item(withID: "part-iron-ingot"),
            storageService.item(withID: "part-iron-plate"),
            storageService.item(withID: "part-heavy-modular-frame"),
            storageService.item(withID: "part-water"),
            storageService.item(withID: "part-nitrogen-gas"),
            storageService.item(withID: "part-packaged-oil")
        ].compactMap { $0 }
    }
    
    var body: some View {
        List {
            ForEach(items, id: \.id) { item in
                NewProductionView.ItemRow(item)
                    .listRowSeparator(.hidden)
                    .contextMenu {
                        Button("Preview") {
                            
                        }
                    }
            }
        }
        .listStyle(.plain)
    }
}

#Preview("List item row") {
    _ItemRowPreview()
}
#endif
