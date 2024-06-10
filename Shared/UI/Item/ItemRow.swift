import SwiftUI

struct ItemRow: View {
    @EnvironmentObject private var storage: Storage
    @Environment(\.displayScale) private var displayScale
    
    var item: Item
    var amount: Double
    
    var body: some View {
        HStack(spacing: 10) {
            Image(item.imageName)
                .resizable()
                .frame(width: 40, height: 40)
                .padding(4)
                .overlay(
                    Color("Secondary").opacity(0.3),
                    in: AngledRectangle(cornerRadius: 6).stroke(style: StrokeStyle(lineWidth: 1))
                )
            
            ZStack {
                HStack {
                    Text(item.name)
                    
                    Spacer()
                    
                    Text("\(amount.formatted(.fractionFromZeroToFour)) / min")
                        .font(.callout)
                        .fontWeight(.medium)
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

struct ItemRowPreviews: PreviewProvider {
    @StateObject private static var storage: Storage = PreviewStorage()
    
    static var previews: some View {
        ItemRow(item: storage[partID: "iron-plate"]!, amount: 25)
            .previewLayout(.sizeThatFits)
            .environmentObject(storage)
            .padding()
    }
}
