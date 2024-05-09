
extension StorageClient {
    @dynamicMemberLookup
    final class Preview {
        private let staticStorage = Storage.Static()
        private var persistentStorage = Storage.Persistent()
        
        init() {
            try? staticStorage.load(onlyData: true)
            try? persistentStorage.load(staticStorage: staticStorage)
        }
        
        subscript<Member>(dynamicMember keyPath: KeyPath<Storage.Static, Member>) -> Member {
            staticStorage[keyPath: keyPath]
        }
        
        subscript<Member>(dynamicMember keyPath: KeyPath<Storage.Persistent, Member>) -> Member {
            persistentStorage[keyPath: keyPath]
        }
        
        subscript<Member>(dynamicMember keyPath: WritableKeyPath<Storage.Persistent, Member>) -> Member {
            get { persistentStorage[keyPath: keyPath] }
            set { persistentStorage[keyPath: keyPath] = newValue }
        }
    }
}
