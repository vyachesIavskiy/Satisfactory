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
                "SHStorage",
            ]
        ),
    ],
    dependencies: [
        .package(path: "../TCA"),
        .package(path: "../SHLogger"),
        .package(path: "../SHFileManager")
    ],
    targets: [
        .target(
            name: "SHStorage",
            dependencies: [
                "SHPersistentModels",
                "SHStaticModels",
                "SHModels",
                .product(name: "SHLogger", package: "SHLogger"),
                .product(name: "SHFileManager", package: "SHFileManager"),
                .product(name: "TCA", package: "TCA")
            ],
            resources: [
                .copy("Data")
            ]
        ),
        .executableTarget(
            name: "SHGenerator",
            dependencies: [
                "SHPersistentModels",
                "SHStaticModels",
                "SHModels",
                .product(name: "SHLogger", package: "SHLogger"),
            ]
        ),
        .target(
            name: "SHModels"
        ),
        .target(
            name: "SHStaticModels",
            dependencies: [
                "SHModels"
            ]
        ),
        .target(
            name: "SHPersistentModels",
            dependencies: [
                "SHModels"
            ]
        ),
        
        // Test targets
        .testTarget(
            name: "SHStorageTests",
            dependencies: [
                "SHStorage",
                .product(name: "SHFileManager", package: "SHFileManager"),
                .product(name: "TCA", package: "TCA")
            ]
        ),
    ]
)
