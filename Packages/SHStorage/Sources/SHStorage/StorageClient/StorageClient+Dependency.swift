import Dependencies

extension StorageClient: DependencyKey {
    public static let liveValue = live
    public static let testValue = failing
    public static let previewValue = preview
}

public extension DependencyValues {
    var storageClient: StorageClient {
        get { self[StorageClient.self] }
        set { self[StorageClient.self] = newValue }
    }
}
