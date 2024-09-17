import SwiftUI

struct WhatsNewPageSubtitle: View {
    let text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .font(.headline)
            .foregroundStyle(.sh(.midnight80))
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    WhatsNewPageSubtitle("Preview subtitle goes here")
}
#endif