// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SHDebug",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
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
