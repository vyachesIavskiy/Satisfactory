import SwiftUI

struct WhatsNewWelcomePage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 40) {
            WhatsNewPageTitle("whats-new-welcome-page-title")
            
            Spacer()
            
            WhatsNewPageSubtitle("whats-new-welcome-page-subtitle")
            
            VStack(alignment: .leading, spacing: 12) {
                Text("whats-new-bullet-new-design")
                Text("whats-new-bullet-new-factories-tab")
                Text("whats-new-bullet-new-production-calculator")
                Text("whats-new-bullet-new-statistics")
            }
            .font(.title3)
            .foregroundStyle(.sh(.midnight50))
            .frame(maxWidth: .infinity, alignment: .leading)
            
            Spacer()
            
            Spacer()
        }
        .padding(20)
    }
}

#if DEBUG
#Preview("Welcome") {
    WhatsNewWelcomePage()
}
#endif
