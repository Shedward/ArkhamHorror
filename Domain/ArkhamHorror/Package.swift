// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ArkhamHorror",
    products: [
        .library(
            name: "ArkhamHorror",
            targets: ["ArkhamHorror"]),
    ],
	dependencies: [],
    targets: [
        .target(
            name: "ArkhamHorror",
            dependencies: []),
        .testTarget(
            name: "ArkhamHorrorTests",
            dependencies: ["ArkhamHorror"]),
    ]
)
