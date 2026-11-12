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
        .package(path: "../../../Utils/Prelude"),
        .package(path: "../../../Domain/ArkhamHorror"),
        .package(path: "../../../UI/DesignSystem")
    ],
    targets: [
        .target(
            name: "ArkhamHorrorGame",
            dependencies: [
                "Prelude",
                "ArkhamHorror",
                "DesignSystem"
            ]
        )
    ]
)
