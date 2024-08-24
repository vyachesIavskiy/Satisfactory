import Foundation

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
        
        #if DEBUG
        static let validVersions = Array(allCases.dropFirst())
        #else
        static let validVersions = Array(allCases)
        #endif
        
        var title: String {
            switch self {
            #if DEBUG
            case .preview: "Preview"
            #endif
            case .v1_4: "v 1.4"
            case .v1_5: "v 1.5"
            case .v1_5_1: "v 1.5.1"
            case .v1_6: "v 1.6"
            case .v1_7: "v 1.7"
            case .v1_7_1: "v 1.7.1"
            case .v2_0: "v 2.0"
            }
        }
    }
}
