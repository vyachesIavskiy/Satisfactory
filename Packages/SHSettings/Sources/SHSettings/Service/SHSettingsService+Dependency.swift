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
        settings: { .never },
        currentSettings: { Settings() },
        setSettings: { _ in }
    )
    
    static let failing = SHSettingsService(
        settings: unimplemented("SHSettingsService.settings"),
        currentSettings: unimplemented("SHSettingsService.currentSettings"),
        setSettings: unimplemented("SHSettingsService.setSettings")
    )
    
    static let live = {
        let live = Live()
        
        return SHSettingsService(
            settings: { live.settings },
            currentSettings: { live.currentSettings },
            setSettings: { live.setSettings($0) }
        )
    }()
    
    static let preview = {
        let preview = Preview()
        
        return SHSettingsService(
            settings: { preview.settings },
            currentSettings: { preview.currentSettings },
            setSettings: { preview.setSettings($0) }
        )
    }()
}
