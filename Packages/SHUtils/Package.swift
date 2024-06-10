// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SHUtils",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "SHCombine",
            targets: [
                "SHCombine"
            ]
        )
    ],
    targets: [
        .target(
            name: "SHCombine"
        )
    ]
)
