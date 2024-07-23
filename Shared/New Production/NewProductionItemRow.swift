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
                        
//                        Image(systemName: "chevron.right")
//                            .foregroundColor(.gray)
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
            .background(
                .background,
                in: AngledRectangle(cornerRadius: resolvedCornerRadius + 4).inset(by: -4)
            )
            .contentShape(.interaction, Rectangle())
            .contentShape(
                .contextMenuPreview,
                AngledRectangle(cornerRadius: resolvedCornerRadius + 4).inset(by: -4)
            )
        }
    }
}

#if DEBUG
import SHDebug

private struct _ItemRowPreview: View {
    @Dependency(\.storageService)
    private var storageService
    
    var parts: [Part] {
        let parts = storageService.parts()
        return [
            parts.first(id: "part-iron-ore"),
            parts.first(id: "part-iron-ingot"),
            parts.first(id: "part-iron-plate"),
            parts.first(id: "part-heavy-modular-frame"),
            parts.first(id: "part-water"),
            parts.first(id: "part-nitrogen-gas"),
            parts.first(id: "part-packaged-oil")
        ].compactMap { $0 }
    }
    
    var body: some View {
        ScrollView {
            VStack {
                ForEach(parts) { part in
                    NewProductionView.ItemRow(part)
                        .contextMenu {
                            Button("Preview") {
                                
                            }
                        }
                }
            }
            .padding()
        }
        .scrollBounceBehavior(.basedOnSize)
    }
}

#Preview("List item row") {
    _ItemRowPreview()
}
#endif
