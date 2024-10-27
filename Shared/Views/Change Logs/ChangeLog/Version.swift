import SwiftUI

extension ChangeLog {
    enum Version: Hashable, CaseIterable {
        #if DEBUG
        case preview
        #endif
        case v1_4
        case v1_5
        case v1_5_1
        case v1_6
        case v1_7
        case v1_7_1
        case v2_0
        case v2_0_1
        case v2_0_2
        case v2_0_3
        case v2_0_4
        
        #if DEBUG
        static let validVersions = Array(allCases.dropFirst())
        #else
        static let validVersions = Array(allCases)
        #endif
        
        var title: LocalizedStringKey {
            switch self {
            #if DEBUG
            case .preview: "change-log-preview-version-title"
            #endif
            case .v1_4: "change-log-v1-4-version-title"
            case .v1_5: "change-log-v1-5-version-title"
            case .v1_5_1: "change-log-v1-5-1-version-title"
            case .v1_6: "change-log-v1-6-version-title"
            case .v1_7: "change-log-v1-7-version-title"
            case .v1_7_1: "change-log-v1-7-1-version-title"
            case .v2_0: "change-log-v2-0-version-title"
            case .v2_0_1: "change-log-v2-0-1-version-title"
            case .v2_0_2: "change-log-v2-0-2-version-title"
            case .v2_0_3: "change-log-v2-0-3-version-title"
            case .v2_0_4: "change-log-v2-0-4-version-title"
            }
        }
    }
}
