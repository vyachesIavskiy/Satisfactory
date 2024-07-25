
@dynamicMemberLookup
public struct SHSettingsService: Sendable {
    public var streamSettings: @Sendable () -> AsyncStream<Settings>
    
    var getSettings: @Sendable () -> Settings
    var setSettings: @Sendable (_ settings: Settings) -> Void
}

public extension SHSettingsService {
    var settings: Settings {
        get { getSettings() }
        nonmutating set { setSettings(newValue) }
    }
    
    subscript<Member>(dynamicMember keyPath: KeyPath<Settings, Member>) -> Member {
        getSettings()[keyPath: keyPath]
    }
}
