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
    targets: [
        .target(name: "SHModels"),
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
