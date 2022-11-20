// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArkhamHorrorGame",
    platforms: [
        .iOS(.v15),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ArkhamHorrorGame",
            targets: ["ArkhamHorrorGame"]),
    ],
    dependencies: [
        .package(name: "Map", path: "../Domain/Map"),
        .package(name: "ArkhamHorror", path: "../Domain/ArkhamHorror")
    ],
    targets: [
        .target(
            name: "ArkhamHorrorGame",
            dependencies: [
                "Map",
                "ArkhamHorror"
            ],
            resources: [
                .process("Resources/SceeneAssets.scnassets"),
                .process("Resources/Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "ArkhamHorrorGameTests",
            dependencies: ["ArkhamHorrorGame"]),
    ]
)
