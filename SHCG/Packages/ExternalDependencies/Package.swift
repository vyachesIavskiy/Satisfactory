// swift-tools-version: 5.10

import PackageDescription

let package = Package(
    name: "ExternalDependencies",
    platforms: [
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "ExternalDependencies",
            targets: ["ExternalDependencies"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.9.2")
    ],
    targets: [
        .target(
            name: "ExternalDependencies",
            dependencies: [
                .product(
                    name: "ComposableArchitecture",
                    package: "swift-composable-architecture"
                )
            ]
        )
    ]
)
