import SwiftUI

struct MyShape: Shape {
    let isCircular: Bool
    
    func path(in rect: CGRect) -> Path {
        isCircular
            ? Circle().path(in: rect)
            : RoundedRectangle(cornerRadius: 15, style: .continuous).path(in: rect)
    }
}

struct ItemViewV3: View {
    var name: String
    var amount: Int? = nil
    var isLiquid = false
    
    @Environment(\.colorScheme) var colorScheme
    
    var lightShadow: Color {
        colorScheme == .light
            ? Color.white.opacity(0.4)
            : Color.gray.opacity(0.05)
    }
    
    var darkShadow: Color {
        colorScheme == .light
            ? Color.black.opacity(0.2)
            : Color.gray.opacity(0.15)
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(name)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(10)
                    .background(Color(.systemBackground))
                    .clipShape(MyShape(isCircular: isLiquid))
                    .padding(5)
                    .alignmentGuide(.itemAlignment) { $0[VerticalAlignment.center] }
                
                if amount ?? 0 > 0 {
                    Text("\(amount!)")
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .frame(minWidth: 20)
                        .background(Color(.factoryPrimaryColor))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                }
            }
            .drawingGroup()
            .frame(width: 100, height: 100)
            .shadow(color: self.lightShadow, radius: 15, x: -10, y: -10)
            .shadow(color: self.darkShadow, radius: 15, x: 10, y: 10)
            
            Text(name)
                .font(.footnote)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
            .frame(width: 100)
        }
    }
}

struct ItemViewV4: View {
    var item: Item
    var amount: Int? = nil
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottomTrailing) {
                Image(item.name)
                    .resizable()
                    .aspectRatio(1, contentMode: .fit)
                    .padding(15)
                    .alignmentGuide(.itemAlignment) { $0[VerticalAlignment.center] }
                
                if amount ?? 0 > 0 {
                    Text("\(amount!)")
                        .foregroundColor(.white)
                        .padding(.horizontal, 4)
                        .padding(.vertical, 2)
                        .frame(minWidth: 20)
                        .background(Color(.factoryPrimaryColor))
                        .clipShape(RoundedRectangle(cornerRadius: 5, style: .continuous))
                }
            }
            .frame(width: 100, height: 100)
            
            Text(item.name)
                .font(.footnote)
                .lineLimit(nil)
                .multilineTextAlignment(.center)
                .frame(width: 100)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ItemViewV3(name: "Limestone", amount: 100)
            ItemViewV3(name: "Steel Beam", amount: 1)
            ItemViewV3(name: "Steel Pipe")
            ItemViewV3(name: "Encased Industrial Beam")
            ItemViewV3(name: "Water", isLiquid: true)
            
            ItemViewV4(item: Storage.shared[partName: "Limestone"]!, amount: 100)
            ItemViewV4(item: Storage.shared[partName: "Steel Beam"]!, amount: 1)
            ItemViewV4(item: Storage.shared[partName: "Steel Pipe"]!)
            ItemViewV4(item: Storage.shared[partName: "Encased Industrial Beam"]!)
            ItemViewV4(item: Storage.shared[partName: "Water"]!)
        }
        .padding(40)
        .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
        .previewLayout(.sizeThatFits)
    }
}
