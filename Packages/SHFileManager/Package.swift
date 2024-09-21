// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHFileManager",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
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
