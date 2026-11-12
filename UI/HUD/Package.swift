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
        .package(path: "../../Utils/Prelude"),
        .package(path: "../../Domain/ArkhamHorror"),
        .package(path: "../DesignSystem")
    ],
    targets: [
        .target(
            name: "HUD",
            dependencies: [
                "Prelude",
                "ArkhamHorror",
                "DesignSystem"
            ]
        ),
        .testTarget(
            name: "HUDTests",
            dependencies: ["HUD"]),
    ]
)
