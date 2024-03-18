// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "SHTheme",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SHTheme",
            targets: [
                "Theme"
            ]
        )
    ],
    dependencies: [
        .package(
            name: "SHDebug",
            path: "../SHDebug"
        )
    ],
    targets: [
        .target(
            name: "Theme",
            dependencies: [
                "SHDebug"
            ]
        )
    ]
)
