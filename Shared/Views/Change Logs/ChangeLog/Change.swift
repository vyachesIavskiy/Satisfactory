import SwiftUI

extension ChangeLog {
    struct Change: Identifiable, Equatable {
        let id = UUID()
        var log: LocalizedStringKey
        var changeType: ChangeType
    }
}

extension ChangeLog.Change {
    enum ChangeType: Equatable {
        case fix
        case addition
        case removal
        case important
    }
}

extension Sequence<ChangeLog.Change> {
    subscript(changeType: ChangeLog.Change.ChangeType) -> [Element] {
        filter { $0.changeType == changeType }
    }
}
