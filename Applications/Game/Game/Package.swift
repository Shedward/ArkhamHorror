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
        .package(name: "ArkhamHorror", path: "../Domain/ArkhamHorror"),
        .package(name: "DesignSystem", path: "../UI/DesignSystem"),
        .package(name: "HUD", path: "../UI/HUD"),
        .package(name: "Scenes", path: "../UI/Scenes")
    ],
    targets: [
        .target(
            name: "Game",
            dependencies: [
                "ArkhamHorror",
                "HUD",
                "Scenes",
                "DesignSystem"
            ],
            resources: [
                .copy("Resources/Campaigns")
            ]
        )
    ]
)
