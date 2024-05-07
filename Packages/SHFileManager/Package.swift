// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHFileManager",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SHFileManager",
            targets: ["SHFileManager"]
        )
    ],
    dependencies: [
        .package(path: "../SHLogger")
    ],
    targets: [
        .target(
            name: "SHFileManager",
            dependencies: [
                .product(name: "SHLogger", package: "SHLogger")
            ]
        ),
        .testTarget(
            name: "SHFileManagerTests",
            dependencies: ["SHFileManager"]
        )
    ]
)
