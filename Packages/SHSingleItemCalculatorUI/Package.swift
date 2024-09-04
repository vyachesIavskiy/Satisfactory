// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHSingleItemCalculatorUI",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SHSingleItemCalculatorUI",
            targets: ["SHSingleItemCalculatorUI"]
        ),
    ],
    dependencies: [
        .package(path: "../SHSharedUI"),
        .package(path: "../SHModels"),
        .package(path: "../SHSingleItemCalculator"),
        .package(path: "../SHStatistics"),
        .package(path: "../SHEditProduction"),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SHSingleItemCalculatorUI",
            dependencies: [
                .product(name: "SHSharedUI", package: "SHSharedUI"),
                .product(name: "SHModels", package: "SHModels"),
                .product(name: "SHSingleItemCalculator", package: "SHSingleItemCalculator"),
                .product(name: "SHStatistics", package: "SHStatistics"),
                .product(name: "SHEditProduction", package: "SHEditProduction"),
            ]
        ),
        .testTarget(
            name: "SHSingleItemCalculatorUITests",
            dependencies: ["SHSingleItemCalculatorUI"]
        ),
    ]
)
