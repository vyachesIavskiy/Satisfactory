// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHUtils",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SHCombine",
            targets: [
                "SHCombine"
            ]
        ),
        .library(
            name: "SHFileManager",
            targets: [
                "SHFileManager"
            ]
        ),
        .library(
            name: "SHLogger",
            targets: [
                "SHLogger"
            ]
        )
    ],
    targets: [
        .target(
            name: "SHCombine"
        ),
        .target(
            name: "SHFileManager",
            dependencies: [
                "SHLogger"
            ]
        ),
        .target(
            name: "SHLogger"
        ),
        
        //Test targets
        .testTarget(
            name: "SHFileManagerTests",
            dependencies: [
                "SHFileManager"
            ]
        ),
        .testTarget(
            name: "SHLoggerTests",
            dependencies: [
                "SHLogger"
            ]
        )
    ]
)
