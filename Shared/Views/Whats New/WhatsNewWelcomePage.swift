import SwiftUI

struct WhatsNewWelcomePage: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
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
            
            WhatsNewPageFooter("whats-new-welcome-page-footer")
                .foregroundStyle(.sh(.midnight80))
            
            Spacer()
            
            Spacer()
        }
        .padding(20)
        .padding(.top, 20)
    }
}

#if DEBUG
#Preview("Welcome") {
    WhatsNewWelcomePage()
}
#endif
