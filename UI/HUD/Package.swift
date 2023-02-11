// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HUD",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "HUD",
            targets: ["HUD"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "HUD",
            dependencies: []),
        .testTarget(
            name: "HUDTests",
            dependencies: ["HUD"]),
    ]
)
