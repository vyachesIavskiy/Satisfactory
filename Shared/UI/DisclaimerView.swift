import SwiftUI

struct DisclaimerView: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ScrollView(showsIndicators: false) {
            Text("""
                It's been a while since you saw an update here. I promised on **reddit**, on **AppStore** and other places that you should expect a lot of changes in the next version, including a new design.
                
                Well... This is not an update we were talking about. Unfortunatelly, I'm still working on it and I don't have even rough estimation on when it will be available. What bothered me very much all this time is that currently my app does not represent relaity of **Satisfactory** and I constantly thought that I need to fix it. So that's why we have this update.
                """)
            .insideBubble()
            .padding(.horizontal)
            .font(.system(.body, design: .rounded))
            
            Text("Changes:")
                .font(.system(size: 30, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
            
            VStack(alignment: .leading) {
                bulletPoint(color: .green, message: "All recipes and items are updated to the latest data in the game")
                bulletPoint(color: .green, message: "It's now possible to hide items that do not have recipes.")
                bulletPoint(color: .green, message: "Fixed a bug with keyboard is not able to hide when you type amount of produced item.")
                bulletPoint(color: .green, message: "In **Settings** menu there is now a new entry for sending your feedback. With this you can have more direct contact with me. All proposals, issues or anything else related to this app is much appreciated.")
                bulletPoint(color: .red, message: "Unfortunately if you had any saved production chains for items that are no longer in games (primarely weapons), these production chains are no longer available and you will have to create new ones.")
            }
            .padding(.horizontal)
            
            Spacer(minLength: 24)
            
            Button {
                dismiss()
            } label: {
                Text("Ok")
                    .font(.system(size: 30, design: .rounded))
                    .frame(maxWidth: .infinity)
            }
            .buttonBorderShape(.roundedRectangle(radius: 15))
            .buttonStyle(.borderedProminent)
            .padding([.horizontal, .bottom])
        }
        .frame(maxWidth: .infinity)
        .safeAreaInset(edge: .top, spacing: 8) {
            Text("What's new")
                .font(.system(size: 50, weight: .semibold, design: .rounded))
                .padding(.horizontal)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(.ultraThinMaterial)
        }
        .background(Color(uiColor: .secondarySystemBackground), ignoresSafeAreaEdges: .all)
    }
    
    @ViewBuilder
    private func bulletPoint(color: Color, message: LocalizedStringKey) -> some View {
        HStack(alignment: .firstTextBaseline) {
            Circle()
                .frame(width: 15, height: 15)
                .foregroundColor(color)
                .brightness(-0.25)
            
            Text(message)
                .font(.system(.body, design: .rounded))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .insideBubble()
    }
}

private struct BubbleModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .background(.background, in: RoundedRectangle(cornerRadius: 15, style: .continuous))
    }
}

private extension View {
    @ViewBuilder
    func insideBubble() -> some View {
        modifier(BubbleModifier())
    }
}

struct DisclaimerView_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerView()
    }
}
