
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
    
    subscript<Member>(dynamicMember keyPath: WritableKeyPath<Settings, Member>) -> Member {
        get {
            getSettings()[keyPath: keyPath]
        }
        nonmutating set {
            var newSettings = getSettings()
            newSettings[keyPath: keyPath] = newValue
            setSettings(newSettings)
        }
    }
}
