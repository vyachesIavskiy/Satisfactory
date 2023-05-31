import SwiftUI

struct ListSectionHeader: View {
    var title: String
    
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        Text(title)
            .font(.title2.weight(.semibold))
            .frame(maxWidth: .infinity, minHeight: 30, alignment: .leading)
            .padding(.horizontal, 12)
            .background {
                AngledRectangle(cornerRadius: 8, corners: .bottom)
                    .foregroundStyle(.background)
                    .shadow(color: colorScheme == .dark ? Color(white: 0.25) : .gray, radius: 2, x: 0, y: 1)
            }
    }
}

struct ListSectionHeader_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            VStack(spacing: 0) {
                Color.white
                    .ignoresSafeArea()
                
                Color(uiColor: .systemGroupedBackground)
                    .ignoresSafeArea()
                    .preferredColorScheme(.dark)
            }
            
            VStack {
                ListSectionHeader(title: "Test")
                
                ListSectionHeader(title: "Test")
                    .preferredColorScheme(.dark)
            }
        }
    }
}
