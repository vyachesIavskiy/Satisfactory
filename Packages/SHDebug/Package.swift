// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SHDebug",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SHDebug",
            targets: ["SHDebug"]
        ),
    ],
    targets: [
        .target(name: "SHDebug")
    ]
)
