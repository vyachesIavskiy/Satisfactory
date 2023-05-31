import SwiftUI

struct DisclaimerViewContainer: View {
    var disclaimer: Disclaimer
    var showOkButton: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    @State private var headerSize = CGSize.zero
    
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    
    private var isIPad: Bool {
        verticalSizeClass == .regular &&
        horizontalSizeClass == .regular
    }

    var body: some View {
        GeometryReader { geometry in
            ScrollView(showsIndicators: false) {
                VStack {
                    DisclaimerView(disclaimer)
                        .frame(maxWidth: 600)
                    
                    Spacer(minLength: 24)
                    
                    if showOkButton {
                        Button {
                            Disclaimer.allDisclaimersAreShown = true
                            dismiss()
                        } label: {
                            Text("Ok")
                                .font(.system(size: 30, design: .rounded))
                                .frame(maxWidth: .infinity)
                        }
                        .buttonBorderShape(.roundedRectangle(radius: 15))
                        .buttonStyle(.borderedProminent)
                        .padding([.horizontal, .bottom])
                        .frame(maxWidth: 320)
                    }
                }
                .padding([.horizontal, .bottom], isIPad ? 16 : 0)
                .frame(minHeight: geometry.size.height - headerSize.height - 8)
            }
            .frame(maxWidth: .infinity)
            .safeAreaInset(edge: .top, spacing: isIPad ? 24 : 12) {
                if showOkButton {
                    Text(whatsNewTitle)
                        .font(.system(size: 35, weight: .semibold, design: .rounded))
                        .padding(.horizontal)
                        .frame(maxWidth: 600, alignment: .leading)
                        .frame(maxWidth: .infinity)
                        .padding(.horizontal, isIPad ? 16 : 0)
                        .padding(.top, 16)
                        .background(.ultraThinMaterial)
                        .anchorPreference(key: PreferenceKey.self, value: .bounds) { $0 }
                        .onPreferenceChange(PreferenceKey.self) { anchor in
                            guard let anchor else { return }
                            
                            headerSize = geometry[anchor].size
                        }
                }
            }
        }
        .background(Color(uiColor: .secondarySystemBackground), ignoresSafeAreaEdges: .all)
        .navigationTitle(navigationTitle)
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var whatsNewTitle: String {
        var result = "What's new in version "
        switch disclaimer.version {
        case .v1_4: result.append("v1.4")
        case .v1_5: result.append("v1.5")
            
        case .preview: result.append("preview value (should not be visible in production)")
        }
        
        return result
    }
    
    private var navigationTitle: String {
        guard !showOkButton else { return "" }
        
        var result = "Version "
        switch disclaimer.version {
        case .v1_4: result.append("v1.4")
        case .v1_5: result.append("v1.5")
            
        case .preview: result.append("preview value (should not be visible in production)")
        }
        
        return result
    }
    
    init(_ disclaimer: Disclaimer, showOkButton: Bool = true) {
        self.disclaimer = disclaimer
        self.showOkButton = showOkButton
    }
    
    private struct PreferenceKey: SwiftUI.PreferenceKey {
        static var defaultValue: Anchor<CGRect>?
        
        static func reduce(value: inout Anchor<CGRect>?, nextValue: () -> Anchor<CGRect>?) {}
    }
}

struct DisclaimerViewContainer_Previews: PreviewProvider {
    static var previews: some View {
        DisclaimerViewContainer(.previewValue)
        
        NavigationView {
            DisclaimerViewContainer(.previewValue, showOkButton: false)
        }
        .navigationViewStyle(.stack)
    }
}
