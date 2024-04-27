import SwiftUI

struct ListItemRow: View {
    var item: Item
    
    @Environment(\.displayScale) private var displayScale
    @EnvironmentObject private var storage: Storage
    
    private var productionChains: [ProductionChain] {
        storage.productionChains.filter { $0.item.id == item.id }
    }
    
    var body: some View {
        HStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .frame(width: 50, height: 50)
                .padding(10)
                .overlay(
                    Color("Secondary").opacity(0.3),
                    in: AngledRectangle(cornerRadius: 8).stroke(style: StrokeStyle(lineWidth: 1.5))
                )
            
            ZStack {
                HStack {
                    Text(item.name)
                        .font(.title3)
                    
                    Spacer()
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                
                LinearGradient(
                    colors: [Color("Secondary").opacity(0.6), .clear],
                    startPoint: .leading,
                    endPoint: .trailing
                )
                .frame(height: 2 / displayScale)
                .frame(maxHeight: .infinity, alignment: .bottom)
            }
        }
        .fixedSize(horizontal: false, vertical: true)
    }
}

struct ListItemRow_Previews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ListItemRow(item: storage[partID: "iron-plate"]!)
            .previewLayout(.sizeThatFits)
            .environmentObject(storage)
    }
}
