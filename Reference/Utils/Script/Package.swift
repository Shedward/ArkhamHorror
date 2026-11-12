// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Script",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Script",
            targets: ["Script"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Script",
            dependencies: []),
        .testTarget(
            name: "ScriptTests",
            dependencies: ["Script"]),
    ]
)
