// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHStatistics",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SHStatistics",
            targets: ["SHStatistics"]
        ),
    ],
    dependencies: [
        .package(path: "../SHSharedUI"),
        .package(path: "../SHModels"),
        .package(path: "../SHStorage"),
        .package(path: "../SHUtils"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SHStatistics",
            dependencies: [
                .product(name: "SHSharedUI", package: "SHSharedUI"),
                .product(name: "SHModels", package: "SHModels"),
                .product(name: "SHStorage", package: "SHStorage"),
                .product(name: "SHUtils", package: "SHUtils"),
            ]
        ),
        .testTarget(
            name: "SHStatisticsTests",
            dependencies: ["SHStatistics"]
        ),
    ]
)