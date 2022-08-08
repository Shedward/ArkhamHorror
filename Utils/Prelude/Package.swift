// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Prelude",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Prelude",
            targets: ["Prelude"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "Prelude",
            dependencies: []),
        .testTarget(
            name: "PreludeTests",
            dependencies: ["Prelude"]),
    ]
)
