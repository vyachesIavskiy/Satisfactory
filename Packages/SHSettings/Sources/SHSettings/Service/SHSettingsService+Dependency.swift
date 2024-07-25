import SHDependencies

// MARK: Dependency value
public extension DependencyValues {
    var settingsService: SHSettingsService {
        get { self[SHSettingsService.self] }
        set { self[SHSettingsService.self] = newValue }
    }
}

// MARK: DependencyKey
extension SHSettingsService: DependencyKey {
    public static var liveValue = live
    public static var testValue = failing
    public static var previewValue = preview
}

// MARK: Instances
extension SHSettingsService {
    static let noop = SHSettingsService(
        streamSettings: { .never },
        getSettings: { Settings() },
        setSettings: { _ in }
    )
    
    static let failing = SHSettingsService(
        streamSettings: unimplemented("SHSettingsService.streamSettings"),
        getSettings: unimplemented("SHSettingsService.getSettings"),
        setSettings: unimplemented("SHSettingsService.setSettings")
    )
    
    static let live = {
        let live = Live()
        
        return SHSettingsService(
            streamSettings: { live.streamSettings },
            getSettings: { live.getSettings() },
            setSettings: { live.setSettings($0) }
        )
    }()
    
    static let preview = {
        let preview = Preview()
        
        return SHSettingsService(
            streamSettings: { preview.streamSettings },
            getSettings: { preview.getSettings() },
            setSettings: { preview.setSettings($0) }
        )
    }()
}
