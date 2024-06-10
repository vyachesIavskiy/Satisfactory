// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SHDependencies",
    platforms: [
        .macOS(.v13),
        .iOS(.v16)
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
            url: "https://github.com/pointfreeco/swift-case-paths",
            from: "1.4.1"
        )
    ],
    targets: [
        .target(
            name: "SHDependencies",
            dependencies: [
                .product(name: "Dependencies", package: "swift-dependencies"),
                .product(name: "CasePaths", package: "swift-case-paths")
            ]
        )
    ]
)