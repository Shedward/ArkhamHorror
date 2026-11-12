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
        .package(url: "https://github.com/hsluv/hsluv-apple.git", from: "2.1.0"),
        .package(path: "../../Utils/Prelude"),
        .package(path: "../../Domain/Map"),
        .package(path: "../../Domain/ArkhamHorror"),
    ],
    targets: [
        .target(
            name: "DesignSystem",
            dependencies: [
                "Prelude",
                "Map",
                "ArkhamHorror",
                .product(name: "HSLuvSwift", package: "hsluv-apple"),
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
