
public struct SHSettingsService: Sendable {
    public var settings: @Sendable () -> AsyncStream<Settings>
    public var currentSettings: @Sendable () -> Settings
    public var setSettings: @Sendable (_ settings: Settings) -> Void
}
