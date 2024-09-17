import SwiftUI
import SHSharedUI

struct WhatsNewPageFooter: View {
    private let text: LocalizedStringKey
    
    init(_ text: LocalizedStringKey) {
        self.text = text
    }
    
    var body: some View {
        Text(text)
            .multilineTextAlignment(.leading)
            .font(.headline)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}

#if DEBUG
#Preview {
    WhatsNewPageFooter("Preview footer goes here")
}
#endif
