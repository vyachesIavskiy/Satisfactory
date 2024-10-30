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
        .navigationTitle("change-log-navigation-title")
    }
    
    private func versionTitle(for version: ChangeLog.Version) -> LocalizedStringKey {
        switch version {
        #if DEBUG
        case .preview: "change-log-preview-name"
        #endif
        case .v1_4: "change-log-v1-4-name"
        case .v1_5: "change-log-v1-5-name"
        case .v1_5_1: "change-log-v1-5-1-name"
        case .v1_6: "change-log-v1-6-name"
        case .v1_7: "change-log-v1-7-name"
        case .v1_7_1: "change-log-v1-7-1-name"
        case .v2_0: "change-log-v2-0-name"
        case .v2_0_1: "change-log-v2-0-1-name"
        case .v2_0_2: "change-log-v2-0-2-name"
        case .v2_0_3: "change-log-v2-0-3-name"
        case .v2_0_4: "change-log-v2-0-4-name"
        case .v2_0_5: "change-log-v2-0-5-name"
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
