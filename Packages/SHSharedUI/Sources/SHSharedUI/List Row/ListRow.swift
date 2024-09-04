import SwiftUI
import SHModels

public struct ListRow<Icon: View, Label: View, Accessory: View>: View {
    private let icon: Icon
    private let label: Label
    private let accessory: Accessory
    
    public var body: some View {
        HStack(spacing: 12) {
            icon
            
            HStack {
                if Accessory.self == EmptyView.self {
                    label
                        .frame(maxWidth: .infinity, alignment: .leading)
                } else {
                    label
                    
                    Spacer()
                    
                    accessory
                }
            }
            .addListGradientSeparator()
        }
        .fixedSize(horizontal: false, vertical: true)
    }
    
    public init(
        @ViewBuilder icon: () -> Icon,
        @ViewBuilder label: () -> Label,
        @ViewBuilder accessory: () -> Accessory
    ) {
        self.icon = icon()
        self.label = label()
        self.accessory = accessory()
    }
    
    public init(
        @ViewBuilder icon: () -> Icon,
        @ViewBuilder label: () -> Label
    ) where Accessory == EmptyView {
        self.icon = icon()
        self.label = label()
        self.accessory = EmptyView()
    }
    
    public init(
        accessory: ListRowAccessory,
        @ViewBuilder icon: () -> Icon,
        @ViewBuilder label: () -> Label
    ) where Accessory == AnyView {
        self.init(icon: icon, label: label) {
            AnyView(accessory.view)
        }
    }
}

public enum ListRowAccessory {
    case chevron
    case checkmark
    
    @ViewBuilder
    var view: some View {
        switch self {
        case .chevron:
            Image(systemName: "chevron.forward")
                .fontWeight(.light)
                .foregroundStyle(.sh(.gray40))
            
        case .checkmark:
            Image(systemName: "checkmark")
                .fontWeight(.medium)
                .foregroundStyle(.sh(.orange))
        }
    }
}

#if DEBUG
import SHStorage

#Preview("List rows") {
    List {
        Group {
            ListRow {
                ListRowIcon(imageName: "part-iron-plate", backgroundShape: .angledRectangle)
            } label: {
                Text(verbatim: "Iron Plate")
            }
            
            ListRow(accessory: .chevron) {
                ListRowIcon(imageName: "part-reinforced-iron-plate", backgroundShape: .angledRectangle)
            } label: {
                Text(verbatim: "Reinforced Iron Plate")
            }
            
            ListRow {
                ListRowIcon(imageName: "part-iron-plate", backgroundShape: .angledRectangle)
            } label: {
                Text(verbatim: "Iron Plate")
            } accessory: {
                Image(systemName: "star.fill")
                    .foregroundStyle(.sh(.green))
            }
        }
        .listRowSeparator(.hidden)
        .listRowBackground(Color.clear)
    }
    .listStyle(.plain)
}
#endif

