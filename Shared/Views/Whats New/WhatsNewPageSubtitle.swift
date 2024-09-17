import SwiftUI

struct WhatsNewPageSubtitle: View {
    let text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(.center)
            .font(.system(size: 20))
            .frame(maxWidth: .infinity)
    }
}

#if DEBUG
#Preview {
    WhatsNewPageSubtitle("Preview subtitle goes here")
}
#endif
