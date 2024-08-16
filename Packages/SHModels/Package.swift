// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "SHModels",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v17),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "SHModels",
            targets: [
                "SHModels",
            ]
        ),
    ],
    dependencies: [
        .package(path: "../SHDependencies")
    ],
    targets: [
        .target(
            name: "SHModels",
            dependencies: [
                .product(name: "SHDependencies", package: "SHDependencies")
            ]
        ),
//        .target(
//            name: "SHStaticModels",
//            dependencies: [
//                "SHModels"
//            ]
//        ),
//        .target(
//            name: "SHPersistentModels",
//            dependencies: [
//                "SHModels"
//            ]
//        ),
    ]
)
