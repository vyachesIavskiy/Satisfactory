import SwiftUI

struct NeumorficView: View {
    var body: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7721024752, green: 0.863529563, blue: 0.9148943424, alpha: 1)).opacity(0.5), Color.white]),
            startPoint: .topLeading,
            endPoint: .bottomTrailing)
            .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .shadow(color: Color(#colorLiteral(red: 0.7721024752, green: 0.863529563, blue: 0.9148943424, alpha: 1)), radius: 20, x: 20, y: 20)
            .shadow(color: Color.white, radius: 20, x: -20, y: -20)
    }
}

struct NeumorficView_Previews: PreviewProvider {
    static var previews: some View {
        NeumorficView()
            .padding(50)
            .frame(width: 400, height: 400)
            .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)))
            .previewLayout(.sizeThatFits)
    }
}

struct NeumorphicModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color(#colorLiteral(red: 0.7721024752, green: 0.863529563, blue: 0.9148943424, alpha: 1)).opacity(0.5), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing)
                .clipShape(RoundedRectangle(cornerRadius: 30, style: .continuous))
                .shadow(color: Color(#colorLiteral(red: 0.7721024752, green: 0.863529563, blue: 0.9148943424, alpha: 1)), radius: 20, x: 20, y: 20)
                .shadow(color: Color.white, radius: 20, x: -20, y: -20)
        )
    }
}

extension View {
    func neumorphic() -> some View {
        modifier(NeumorphicModifier())
    }
}
