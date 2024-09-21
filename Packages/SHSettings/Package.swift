// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHSettings",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SHSettings",
            targets: ["SHSettings"]
        ),
    ],
    dependencies: [
        .package(path: "../SHPersistence"),
        .package(path: "../SHDependencies")
    ],
    targets: [
        .target(
            name: "SHSettings",
            dependencies: [
                .product(name: "SHPersistence", package: "SHPersistence"),
                .product(name: "SHDependencies", package: "SHDependencies")
            ]
        ),
        .testTarget(
            name: "SHSettingsTests",
            dependencies: ["SHSettings"]
        ),
    ]
)
