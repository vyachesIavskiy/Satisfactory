import UniformTypeIdentifiers
import StorageLogger
import Dependencies

struct FileManagerClient {
    var homeDirectoyName = ""
    
    var homeDirectoryExist: () throws -> Bool
    var removeHomeDirectory: () throws -> Void
    
    var urlForFile: (_ path: String, _ fileType: UTType) throws -> URL
    var urlForDirectory: (_ path: String) throws -> URL
    
    var fileExistsAt: (_ path: String, _ fileType: UTType) throws -> Bool
    var createFileAt: (_ path: String, _ fileType: UTType) throws -> Void
    var removeFileAt: (_ path: String, _ fileType: UTType) throws -> Void
    
    var directoryExistsAt: (_ path: String) throws -> Bool
    var createDirectoryAt: (_ path: String) throws -> Void
    var removeDirectoryAt: (_ path: String) throws -> Void
    var contentsOfDirectoryAt: (_ path: String) throws -> [URL]
    
    func fileManagerFor(directoryName: String) -> FileManagerClient {
        FileManagerClient(
            homeDirectoyName: directoryName,
            homeDirectoryExist: { try directoryExistsAt(directoryName) },
            removeHomeDirectory: { try removeDirectoryAt(directoryName) },
            urlForFile: { path, fileType in try urlForFile("\(directoryName)/\(path)", fileType) },
            urlForDirectory: { path in try urlForDirectory("\(directoryName)/\(path)") },
            fileExistsAt: { path, fileType in try fileExistsAt("\(directoryName)/\(path)", fileType) },
            createFileAt: { path, fileType in try createFileAt("\(directoryName)/\(path)", fileType) },
            removeFileAt: { path, fileType in try removeFileAt("\(directoryName)/\(path)", fileType) },
            directoryExistsAt: { path in try directoryExistsAt("\(directoryName)/\(path)") },
            createDirectoryAt: { path in try createDirectoryAt("\(directoryName)/\(path)") },
            removeDirectoryAt: { path in try removeDirectoryAt("\(directoryName)/\(path)") },
            contentsOfDirectoryAt: { path in try contentsOfDirectoryAt("\(directoryName)/\(path)") }
        )
    }
}

extension FileManagerClient: DependencyKey {
    static let liveValue = live
    static let testValue = failing
    static let previewValue = noop
}

extension DependencyValues {
    var fileManagerClient: FileManagerClient {
        get { self[FileManagerClient.self] }
        set { self[FileManagerClient.self] = newValue }
    }
}

extension FileManagerClient {
    static let live = {
        let fileManager = Live()
        
        return FileManagerClient(
            homeDirectoryExist: fileManager.homeDirectoryExist,
            removeHomeDirectory: { }, // This should be empty
            urlForFile: fileManager.url(for:fileType:),
            urlForDirectory: fileManager.url(for:),
            fileExistsAt: fileManager.fileExists(at:fileType:),
            createFileAt: fileManager.createFile(at:fileType:),
            removeFileAt: fileManager.removeFile(at:fileType:),
            directoryExistsAt: fileManager.directoryExists(at:),
            createDirectoryAt: fileManager.createDirectory(at:),
            removeDirectoryAt: fileManager.removeDirectory(at:),
            contentsOfDirectoryAt: fileManager.contentsOfDirectory(at:)
        )
    }()
    
    static let failing = FileManagerClient(
        homeDirectoryExist: unimplemented("\(Self.self).homeDirectoryExist", placeholder: false),
        removeHomeDirectory: unimplemented("\(Self.self).removeHomeDirectory"),
        urlForFile: unimplemented("\(Self.self).urlForFile"),
        urlForDirectory: unimplemented("\(Self.self).urlForDirectory"),
        fileExistsAt: unimplemented("\(Self.self).fileExistsAt", placeholder: false),
        createFileAt: unimplemented("\(Self.self).createFileAt"),
        removeFileAt: unimplemented("\(Self.self).removeFileAt"),
        directoryExistsAt: unimplemented("\(Self.self).directoryExistsAt", placeholder: false),
        createDirectoryAt: unimplemented("\(Self.self).createDirectoryAt"),
        removeDirectoryAt: unimplemented("\(Self.self).removeDirectoryAt"),
        contentsOfDirectoryAt: unimplemented("\(Self.self).contentsOfDirectoryAt", placeholder: [])
    )
    
    static let noop = FileManagerClient(
        homeDirectoryExist: { true },
        removeHomeDirectory: { },
        urlForFile: { URL(filePath: $0).appendingPathExtension(for: $1) },
        urlForDirectory: { URL(filePath: $0) },
        fileExistsAt: { _, _ in true },
        createFileAt: { _, _ in },
        removeFileAt: { _, _ in },
        directoryExistsAt: { _ in true },
        createDirectoryAt: { _ in },
        removeDirectoryAt: { _ in },
        contentsOfDirectoryAt: { _ in [] }
    )
}

private extension FileManagerClient {
    final class Live {
        private let fileManager = FileManager.default
        private let logger = Logger(category: .fileManager)
        
        private var homeDirectoryURL: URL {
            get throws {
                try fileManager.url(
                    for: .documentDirectory,
                    in: .userDomainMask,
                    appropriateFor: nil,
                    create: true
                )
            }
        }
        
        // MARK: Home
        func homeDirectoryExist() throws -> Bool {
            try fileManager.fileExists(atPath: homeDirectoryURL.path())
        }
        
        // MARK: URLs
        func url(for directoryName: String) throws -> URL {
            try homeDirectoryURL.appending(path: directoryName)
        }
        
        func url(for fileName: String, fileType: UTType) throws -> URL {
            try url(for: fileName).appendingPathExtension(for: fileType)
        }
        
        // MARK: Files
        func fileExists(at relativePath: String, fileType: UTType) throws -> Bool {
            let fileURL = try url(for: relativePath, fileType: fileType)
            return fileManager.fileExists(atPath: fileURL.path())
        }
        
        func createFile(at relativePath: String, fileType: UTType) throws {
            logger.debug("Creating file '\(relativePath).\(fileType)'")
            let fileURL = try url(for: relativePath, fileType: fileType)
            fileManager.createFile(atPath: fileURL.path(), contents: nil)
        }
        
        func removeFile(at relativePath: String, fileType: UTType) throws {
            logger.debug("Removing file '\(relativePath).\(fileType)'")
            let fileURL = try url(for: relativePath, fileType: fileType)
            try fileManager.removeItem(at: fileURL)
        }
        
        // MARK: Directories
        func directoryExists(at relativePath: String) throws -> Bool {
            let fileURL = try url(for: relativePath)
            return fileManager.fileExists(atPath: fileURL.path())
        }
        
        func createDirectory(at relativePath: String) throws {
            logger.debug("Creating directory '\(relativePath)'")
            let directoryURL = try url(for: relativePath)
            try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true)
        }
        
        func removeDirectory(at relativePath: String) throws {
            logger.debug("Removing directory '\(relativePath)'")
            let directoryURL = try url(for: relativePath)
            try fileManager.removeItem(at: directoryURL)
        }
        
        func contentsOfDirectory(at relativePath: String) throws -> [URL] {
            let directoryURL = try url(for: relativePath)
            return try fileManager.contentsOfDirectory(at: directoryURL, includingPropertiesForKeys: nil)
        }
    }
}
