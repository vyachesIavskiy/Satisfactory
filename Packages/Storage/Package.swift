// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Storage",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Storage",
            targets: [
                "Storage",
            ]
        ),
    ],
    targets: [
        .target(
            name: "Storage",
            dependencies: [
                "PersistentModels",
                "StaticModels",
                "Models"
            ],
            resources: [
                .copy("Resources")
            ]
        ),
        .executableTarget(
            name: "Generator",
            dependencies: [
                "PersistentModels",
                "StaticModels",
                "Models"
            ]
        ),
        .target(
            name: "Models"
        ),
        .target(
            name: "StaticModels"
        ),
        .target(
            name: "PersistentModels"
        ),
        .testTarget(
            name: "StorageTests",
            dependencies: ["Storage"]
        ),
    ]
)
