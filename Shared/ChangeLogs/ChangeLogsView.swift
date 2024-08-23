import SwiftUI

struct ChangeLogsView: View {
    var body: some View {
        List {
            ForEach(ChangeLog.Version.validVersions, id: \.self) { version in
                NavigationLink(versionTitle(for: version)) {
                    ChangeLogView(ChangeLog[version])
                }
            }
        }
        .navigationTitle("Changes")
    }
    
    private func versionTitle(for version: ChangeLog.Version) -> String {
        switch version {
        case .preview: "Preview (should not be visible in production)"
        case .v1_4: "Version 1.4"
        case .v1_5: "Version 1.5"
        case .v1_5_1: "Version 1.5.1"
        case .v1_6: "Version 1.6"
        case .v1_7: "Version 1.7"
        case .v1_7_1: "Version 1.7.1"
        case .v2_0: "Version 2.0"
        }
    }
}

#if DEBUG
#Preview {
    NavigationStack {
        ChangeLogsView()
    }
}
#endif
