// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FormattedText",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "FormattedText",
            targets: ["FormattedText"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "FormattedText",
            dependencies: []),
        .testTarget(
            name: "FormattedTextTests",
            dependencies: ["FormattedText"]),
    ]
)
