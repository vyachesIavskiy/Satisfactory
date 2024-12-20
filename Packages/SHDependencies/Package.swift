// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SHDependencies",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SHDependencies",
            targets: ["SHDependencies"]
        ),
    ],
    dependencies: [
        .package(
            url: "https://github.com/pointfreeco/swift-dependencies",
            from: "1.3.0"
        ),
        .package(
            url: "https://github.com/apple/swift-async-algorithms",
            from: "1.0.0"
        )
    ],
    targets: [
        .target(
            name: "SHDependencies",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "AsyncAlgorithms", package: "swift-async-algorithms"),
            ]
        )
    ]
)
