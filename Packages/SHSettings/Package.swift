// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHSettings",
    platforms: [
        .iOS(.v16)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "SHSettings",
            targets: [
                "Settings"
            ]
        ),
    ],
    dependencies: [
        .package(path: "../TCA"),
        .package(path: "../SHStorage"),
        .package(path: "../SHUtils")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "Settings",
            dependencies: [
                .product(
                    name: "TCA",
                    package: "TCA"
                ),
                .product(
                    name: "SHStorage",
                    package: "SHStorage"
                ),
                .product(
                    name: "SHCombine",
                    package: "SHUtils"
                )
            ]
        ),
        .testTarget(
            name: "SettingsTests",
            dependencies: ["Settings"]
        ),
    ]
)
