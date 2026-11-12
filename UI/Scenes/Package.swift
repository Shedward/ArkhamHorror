// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Scenes",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "Scenes",
            targets: ["Scenes"]),
    ],
    dependencies: [
        .package(path: "../../Utils/Prelude"),
        .package(path: "../../Domain/Common"),
        .package(path: "../../Domain/ArkhamHorror"),
        .package(path: "../../Domain/Map"),
        .package(path: "../DesignSystem"),
        .package(url: "https://github.com/hsluv/hsluv-apple.git", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "Scenes",
            dependencies: [
                "Prelude",
                "Common",
                "ArkhamHorror",
                "Map",
                "DesignSystem",
                .product(name: "HSLuvSwift", package: "hsluv-apple")
            ]
        ),
        .testTarget(
            name: "ScenesTests",
            dependencies: ["Scenes"]),
    ]
)
