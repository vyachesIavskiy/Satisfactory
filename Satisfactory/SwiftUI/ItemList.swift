import SwiftUI

struct ItemListV3: View {
    var body: some View {
        ZStack {
            Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            ScrollView(.vertical, showsIndicators: true) {
                VStack {
                    ForEach(PartType.allCases, id: \.self) { partType in
                        VStack(alignment: .leading) {
                            Text(partType.rawValue)
                                .font(.headline)
                                .padding(.horizontal)
                            
                            ScrollView(.horizontal, showsIndicators: false) {
                                HStack(alignment: .top, spacing: 12) {
                                    ForEach(self.parts(for: partType)) { part in
                                        if part.recipes.isEmpty {
                                            ItemViewV4(item: part)
                                        } else {
                                            NavigationLink(destination: ItemRecipeViewV3(item: part)) {
                                                ItemViewV3(name: part.name, isLiquid: part.isLiquid)
                                            }
                                            .buttonStyle(PlainButtonStyle())
                                        }
                                    }
                                }
                                .padding(.horizontal)
                                .padding(.top, 15)
                                .padding(.vertical, 30)
                            }
                        }
                    }
                }
            }
            .frame(maxWidth: .infinity)
        }
    }
    
    func parts(for partType: PartType) -> [Part] {
        Storage.shared.parts.filter { $0.partType == partType }
    }
}

#if DEBUG
struct ItemListV3_Preview: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ItemListV3()
        }
    }
}
#endif
