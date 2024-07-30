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
        
        private var backgroundIconShape: AnyShape {
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
        
        private var backgroundShape: some Shape {
            AngledRectangle(cornerRadius: 8).inset(by: -6)
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
                        backgroundIconShape
                            .fill(.sh(.gray20))
                            .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
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
                        colors: [.sh(.midnight40), .sh(.gray10)],
                        startPoint: .leading,
                        endPoint: UnitPoint(x: 0.85, y: 0.5)
                    )
                    .frame(height: 2 / displayScale)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
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
        ScrollView {
            ForEach(items, id: \.id) { item in
                NewProductionView.ItemRow(item)
                    .contextMenu {
                        Button("Preview") {
                            
                        }
                    }
            }
            .padding(.horizontal, 16)
        }
    }
}

#Preview("List item row") {
    _ItemRowPreview()
}
#endif
