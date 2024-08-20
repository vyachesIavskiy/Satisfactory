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
        .package(path: "../SHFileManager"),
        .package(path: "../SHModels")
    ],
    targets: [
        .target(
            name: "SHStorage",
            dependencies: [
                "SHDependencies",
                "SHStaticStorage",
                "SHPersistentStorage",
                "SHPersistentModels",
                "SHStaticModels",
                .product(name: "SHModels", package: "SHModels"),
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
        .target(
            name: "SHStaticModels",
            dependencies: [
                .product(name: "SHModels", package: "SHModels")
            ]
        ),
        .target(
            name: "SHPersistentModels",
            dependencies: [
                .product(name: "SHModels", package: "SHModels"),
                "SHStaticModels"
            ]
        ),
        
        // Executable targets
        .executableTarget(
            name: "SHGenerator",
            dependencies: [
                "SHPersistentModels",
                "SHStaticModels",
                .product(name: "SHModels", package: "SHModels"),
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
