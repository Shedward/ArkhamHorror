// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "MapScene",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "MapScene",
            targets: ["MapScene"]),
    ],
    dependencies: [
        .package(name: "Map", path: "../Domain/Map"),
        .package(name: "DesignSystem", path: "../UI/DesignSystem"),
        .package(url: "https://github.com/hsluv/hsluv-swift.git", from: "2.1.0"),
    ],
    targets: [
        .target(
            name: "MapScene",
            dependencies: [
                "Map",
                "DesignSystem",
                .product(name: "HSLuvSwift", package: "hsluv-swift")
            ]
        ),
        .testTarget(
            name: "MapSceneTests",
            dependencies: ["MapScene"]),
    ]
)
