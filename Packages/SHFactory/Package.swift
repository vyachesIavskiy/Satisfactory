// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHFactory",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SHFactory",
            targets: ["SHFactory"]
        ),
    ],
    dependencies: [
        .package(path: "../SHSharedUI"),
        .package(path: "../SHModels"),
        .package(path: "../SHStorage"),
        .package(path: "../SHEditFactory"),
        .package(path: "../SHEditProduction"),
        .package(path: "../SHSingleItemCalculatorUI"),
        .package(path: "../SHStatistics"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SHFactory",
            dependencies: [
                .product(name: "SHSharedUI", package: "SHSharedUI"),
                .product(name: "SHModels", package: "SHModels"),
                .product(name: "SHStorage", package: "SHStorage"),
                .product(name: "SHEditFactory", package: "SHEditFactory"),
                .product(name: "SHEditProduction", package: "SHEditProduction"),
                .product(name: "SHSingleItemCalculatorUI", package: "SHSingleItemCalculatorUI"),
                .product(name: "SHStatistics", package: "SHStatistics"),
            ]
        ),
    ]
)
