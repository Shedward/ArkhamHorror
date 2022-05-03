// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Gameboard",
    products: [
        .library(
            name: "Gameboard",
            targets: ["Gameboard"]
        )
    ],
    dependencies: [
        .package(name: "Cards", path: "../Domain/Map")
    ],
    targets: [
        .target(
            name: "Gameboard",
            dependencies: []
        ),
        .testTarget(
            name: "GameboardTests",
            dependencies: ["Gameboard"]
        )
    ]
)
