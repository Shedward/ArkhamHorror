// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HUD",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "HUD",
            targets: ["HUD"]),
    ],
    dependencies: [
        .package(name: "ArkhamHorror", path: "../Domain/ArkhamHorror"),
        .package(name: "DesignSystem", path: "../UI/DesignSystem")
    ],
    targets: [
        .target(
            name: "HUD",
            dependencies: [
                "ArkhamHorror",
                "DesignSystem"
            ]
        ),
        .testTarget(
            name: "HUDTests",
            dependencies: ["HUD"]),
    ]
)
