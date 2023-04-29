// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "DesignSystem",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "DesignSystem",
            targets: ["DesignSystem"]),
    ],
    dependencies: [
        .package(name: "Prelude", path: "../Utils/Prelude"),
        .package(name: "Map", path: "../Domain/Map"),
        .package(name: "ArkhamHorror", path: "../Domain/ArkhamHorror"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                "Prelude",
                "Map",
                "ArkhamHorror",
            ],
            resources: [
                .process("Resources/Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "DesignSystemTests",
            dependencies: ["DesignSystem"]),
    ]
)
