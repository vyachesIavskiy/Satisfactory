// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SHTheme",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SHTheme",
            targets: ["SHTheme"]
        )
    ],
    dependencies: [
        .package(name: "SHDebug", path: "../SHDebug")
    ],
    targets: [
        .target(
            name: "SHTheme",
            dependencies: ["SHDebug"]
        )
    ]
)
