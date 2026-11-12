// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Game",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Game",
            targets: ["Game"]
        ),
    ],
    dependencies: [
        .package(path: "../../../Utils/Prelude"),
        .package(path: "../../../Domain/Common"),
        .package(path: "../../../Domain/Map"),
        .package(path: "../../../Domain/ArkhamHorror"),
        .package(path: "../../../UI/DesignSystem"),
        .package(path: "../../../UI/HUD"),
        .package(path: "../../../UI/Scenes")
    ],
    targets: [
        .target(
            name: "Game",
            dependencies: [
                "Prelude",
                "Common",
                "Map",
                "ArkhamHorror",
                "HUD",
                "Scenes",
                "DesignSystem"
            ],
            resources: [
                .copy("Resources/Campaigns")
            ]
        ),
        .testTarget(name: "GameTests", dependencies: ["Game", "ArkhamHorror"])
    ]
)
