// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArkhamHorrorGame",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "ArkhamHorrorGame",
            targets: ["ArkhamHorrorGame"]),
    ],
    dependencies: [
        .package(name: "Map", path: "../Domain/Map"),
        .package(name: "ArkhamHorror", path: "../Domain/ArkhamHorror"),
        .package(name: "HUD", path: "../Application/HUD")
    ],
    targets: [
        .target(
            name: "ArkhamHorrorGame",
            dependencies: [
                "Map",
                "ArkhamHorror",
                "HUD"
            ],
            resources: [
                .copy("Resources/Campaigns"),
                .process("Resources/Assets.xcassets")
            ]
        ),
        .testTarget(
            name: "ArkhamHorrorGameTests",
            dependencies: ["ArkhamHorrorGame"]),
    ]
)
