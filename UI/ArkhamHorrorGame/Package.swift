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
        .package(name: "ArkhamHorror", path: "../Domain/ArkhamHorror"),
        .package(name: "HUD", path: "../UI/HUD"),
        .package(name: "DesignSystem", path: "../UI/DesignSystem"),
        .package(name: "XCTestUtils", path: "../Utils/XCTestUtils")
    ],
    targets: [
        .target(
            name: "ArkhamHorrorGame",
            dependencies: [
                "ArkhamHorror",
                "HUD",
                "DesignSystem"
            ],
            resources: [
                .copy("Resources/Campaigns")
            ]
        ),
        .testTarget(
            name: "ArkhamHorrorGameTests",
            dependencies: [
                "ArkhamHorrorGame",
                "XCTestUtils"
            ]),
    ]
)
