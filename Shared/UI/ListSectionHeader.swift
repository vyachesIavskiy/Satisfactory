import SwiftUI

struct ListSectionHeader: View {
    var title: String
    
    var body: some View {
        Text(title)
            .font(.title2.weight(.semibold))
            .frame(maxWidth: .infinity, minHeight: 30, alignment: .leading)
            .padding(.horizontal, 12)
            .background {
                AngledRectangle(cornerRadius: 8, corners: .bottom)
                    .foregroundStyle(.background)
                    .shadow(color: .gray, radius: 2, x: 0, y: 1)
            }
    }
}

struct ListSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.green
                .ignoresSafeArea()
            
            ListSectionHeader(title: "Test")
        }
    }
}
