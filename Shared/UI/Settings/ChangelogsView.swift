import SwiftUI

struct ChangelogsView: View {
    var body: some View {
        List {
            ForEach(Disclaimer.Version.validVersions, id: \.self) { version in
                NavigationLink(versionTitle(for: version)) {
                    DisclaimerViewContainer(Disclaimer[version], showOkButton: false)
                }
            }
        }
        .navigationTitle("Changes")
    }
    
    private func versionTitle(for version: Disclaimer.Version) -> String {
        switch version {
        case .preview: return "Preview (should not be visible in production)"
        case .v1_4: return "Version 1.4"
        case .v1_5: return "Version 1.5"
        case .v1_5_1: return "Version 1.5.1"
        case .v1_6: return "Version 1.6"
        case .v1_7: return "Version 1.7"
        case .v1_7_1: return "Version 1.7.1"
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ChangelogsView()
    }
}
#endif
