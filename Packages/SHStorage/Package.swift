// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SHStorage",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
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
        .package(path: "../SHDependencies"),
        .package(path: "../SHLogger"),
        .package(path: "../SHPersistence"),
        .package(path: "../SHFileManager")
    ],
    targets: [
        .target(
            name: "SHStorage",
            dependencies: [
                "SHStaticStorage",
                "SHPersistentStorage",
                "SHPersistentModels",
                "SHStaticModels",
                "SHModels",
                .product(name: "SHLogger", package: "SHLogger")
            ],
            swiftSettings: [
                .define("SWIFT_EMIT_LOC_STRINGS=NO")
            ]
        ),
        .target(
            name: "SHStaticStorage",
            dependencies: [
                "SHModels",
                "SHStaticModels",
                .product(name: "SHLogger", package: "SHLogger")
            ],
            resources: [
                .copy("Data")
            ]
        ),
        .target(
            name: "SHPersistentStorage",
            dependencies: [
                "SHStaticStorage",
                "SHModels",
                "SHPersistentModels",
                "SHStaticModels",
                .product(name: "SHPersistence", package: "SHPersistence"),
                .product(name: "SHLogger", package: "SHLogger")
            ]
        ),
        .target(name: "SHModels"),
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
        
        // Executable targets
        .executableTarget(
            name: "SHGenerator",
            dependencies: [
                "SHPersistentModels",
                "SHStaticModels",
                "SHModels",
                .product(name: "SHLogger", package: "SHLogger"),
            ]
        ),
        
        // Test targets
        .testTarget(
            name: "SHStorageTests",
            dependencies: [
                "SHStorage",
                .product(name: "SHFileManager", package: "SHFileManager"),
                .product(name: "SHDependencies", package: "SHDependencies")
            ]
        ),
    ]
)
