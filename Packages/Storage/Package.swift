// swift-tools-version: 5.9

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
    dependencies: [
        .package(path: "../TCA")
    ],
    targets: [
        .target(
            name: "Storage",
            dependencies: [
                "PersistentModels",
                "StaticModels",
                "Models",
                "StorageLogger",
                .product(name: "TCA", package: "TCA")
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
        .target(
            name: "StorageLogger"
        ),
        .testTarget(
            name: "StorageTests",
            dependencies: [
                "Storage",
                .product(name: "TCA", package: "TCA")
            ]
        ),
    ]
)
