// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "TCA",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "TCA",
            targets: ["TCA"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", exact: "1.2.0")
    ],
    targets: [
        .target(
            name: "TCA",
            dependencies: [
                .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
            ],
            sources: ["TCA.swift"]
        )
    ]
)
