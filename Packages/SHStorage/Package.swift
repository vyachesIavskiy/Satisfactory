// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SHStorage",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SHStorage",
            targets: [
                "Storage",
            ]
        ),
    ],
    dependencies: [
        .package(path: "../TCA"),
        .package(path: "../SHUtils")
    ],
    targets: [
        .target(
            name: "Storage",
            dependencies: [
                "PersistentModels",
                "StaticModels",
                "Models",
                .product(name: "SHLogger", package: "SHUtils"),
                .product(name: "SHFileManager", package: "SHUtils"),
                .product(name: "TCA", package: "TCA")
            ],
            resources: [
                .copy("Data")
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
            name: "StaticModels",
            dependencies: [
                "Models"
            ]
        ),
        .target(
            name: "PersistentModels",
            dependencies: [
                "Models"
            ]
        ),
        
        // Test targets
        .testTarget(
            name: "StorageTests",
            dependencies: [
                "Storage",
                .product(name: "SHFileManager", package: "SHUtils"),
                .product(name: "TCA", package: "TCA")
            ]
        ),
    ]
)
