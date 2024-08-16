// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Calculators",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "Calculators",
            targets: [
                "SingleItemCalculator",
                "FromResourcesCalculator",
                "PowerCalculator"
            ]
        )
    ],
    dependencies: [
        .package(path: "../SHModels"),
        .package(path: "../SHStorage"),
        .package(path: "../SHUtils")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "SingleItemCalculator",
            dependencies: [
                .product(name: "SHModels", package: "SHModels"),
                .product(name: "SHStorage", package: "SHStorage"),
                .product(name: "SHUtils", package: "SHUtils")
            ]
        ),
        .target(
            name: "FromResourcesCalculator",
            dependencies: [
                .product(name: "SHModels", package: "SHModels"),
                .product(name: "SHStorage", package: "SHStorage"),
                .product(name: "SHUtils", package: "SHUtils")
            ]
        ),
        .target(
            name: "PowerCalculator",
            dependencies: [
                .product(name: "SHModels", package: "SHModels"),
                .product(name: "SHStorage", package: "SHStorage"),
                .product(name: "SHUtils", package: "SHUtils")
            ]
        ),
        
        // Test targets
        .testTarget(
            name: "SingleItemCalculatorTests",
            dependencies: [
                "SingleItemCalculator"
            ]
        ),
    ]
)
