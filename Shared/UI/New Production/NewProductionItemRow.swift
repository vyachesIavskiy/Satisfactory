import SwiftUI
import SHModels
import SHStorage

extension NewProductionView {
    struct ItemRow: View {
        var item: any Item
        
        @Environment(\.displayScale) private var displayScale
        @ScaledMetric(relativeTo: .body) private var imageSize = 40
        @ScaledMetric(relativeTo: .body) private var paddingSize = 5
        @ScaledMetric(relativeTo: .body) private var cornerRadius = 6
        
        private var resolvedImageSize: Double {
            min(imageSize, 90)
        }
        
        private var resolvedPaddingSize: Double {
            min(paddingSize, 10)
        }
        
        private var resolvedCornerRadius: Double {
            min(cornerRadius, 10)
        }
        
        private var overlayShape: AnyShape {
            switch (item as? Part)?.form {
            case .solid, nil:
                AnyShape(AngledRectangle(cornerRadius: cornerRadius).inset(by: 1 / displayScale))
                
            case .fluid, .gas:
                AnyShape(UnevenRoundedRectangle(
                    bottomLeadingRadius: cornerRadius,
                    topTrailingRadius: cornerRadius
                ).inset(by: 1 / displayScale))
            }
        }
        
        init(_ item: any Item) {
            self.item = item
        }
        
        var body: some View {
            HStack(spacing: 10) {
                Image(item.id)
                    .resizable()
                    .frame(width: resolvedImageSize, height: resolvedImageSize)
                    .padding(resolvedPaddingSize)
                    .overlay(
                        .sh(.midnight20),
                        in: overlayShape.stroke(style: StrokeStyle(lineWidth: 3 / displayScale))
                    )
                
                ZStack {
                    HStack {
                        Text(item.localizedName)
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .foregroundColor(.gray)
                    }
                    
                    LinearGradient(
                        colors: [.sh(.midnight20), .clear],
                        startPoint: .leading,
                        endPoint: UnitPoint(x: 0.85, y: 0.5)
                    )
                    .frame(height: 2 / displayScale)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                }
            }
            .fixedSize(horizontal: false, vertical: true)
            .background(.background, in: AngledRectangle(cornerRadius: resolvedCornerRadius + 4).inset(by: -8))
            .contentShape(.interaction, Rectangle())
            .contentShape(.contextMenuPreview, AngledRectangle(cornerRadius: resolvedCornerRadius + 4).inset(by: -8))
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
