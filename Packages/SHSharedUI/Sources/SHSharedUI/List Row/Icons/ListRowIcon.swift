import SwiftUI
import SHModels

public struct ListRowIcon<Icon: View>: View {
    private let icon: Icon
    private let backgroundShape: ListRowIconBackgroundShape
    
    @Environment(\.displayScale)
    private var displayScale
    
    private var backgroundIconShape: AnyShape {
        switch backgroundShape {
        case .angledRectangle:
            AnyShape(AngledRectangle(cornerRadius: 5).inset(by: 1 / displayScale))
            
        case .roundedRectangle:
            AnyShape(UnevenRoundedRectangle(
                bottomLeadingRadius: 8,
                topTrailingRadius: 8
            ).inset(by: 1 / displayScale))
        }
    }
    
    public var body: some View {
        icon
            .frame(width: 40, height: 40)
            .padding(6)
            .background {
                backgroundIconShape
                    .fill(.sh(.gray20))
                    .stroke(.sh(.midnight40), lineWidth: 2 / displayScale)
            }
    }
    
    public init(backgroundShape: ListRowIconBackgroundShape, @ViewBuilder icon: () -> Icon) {
        self.icon = icon()
        self.backgroundShape = backgroundShape
    }
    
    public init(imageName: String, backgroundShape: ListRowIconBackgroundShape) where Icon == Image {
        self.init(backgroundShape: backgroundShape) {
            Image(imageName)
                .resizable()
        }
    }
}

public enum ListRowIconBackgroundShape {
    case angledRectangle
    case roundedRectangle
}

#if DEBUG
import SHStorage

#Preview("Icons") {
    HStack {
        ListRowIcon(imageName: "part-iron-plate", backgroundShape: .angledRectangle)
        
        ListRowIcon(imageName: "part-water", backgroundShape: .roundedRectangle)
    }
}
#endif
