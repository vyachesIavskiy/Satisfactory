import SHModels
import SwiftUI

struct ListItemCell: View {
    var item: any SHModels.Item
    
    @Environment(\.displayScale) private var displayScale
    
    var body: some View {
        Image(item.id)
            .resizable()
            .frame(width: 65, height: 65)
            .padding(6)
            .overlay(
                Color("Secondary").opacity(0.3),
                in: AngledRectangle(cornerRadius: 10).stroke(style: StrokeStyle(lineWidth: 2))
            )
    }
}

#if DEBUG
#Preview("List item cell") {
    ListItemCell(item: SHModels.Part(id: "part-iron-ingot", category: .aliens, progressionIndex: 0, form: .solid))
        .padding()
}
#endif
