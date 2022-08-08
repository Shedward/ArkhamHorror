// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Deck",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Deck",
            targets: ["Deck"]),
    ],
    dependencies: [
		.package(name: "XCTestUtils", path: "../Utils/XCTestUtils")
	],
    targets: [
        .target(
            name: "Deck",
            dependencies: []),
        .testTarget(
            name: "DeckTests",
            dependencies: [
				"Deck",
				"XCTestUtils"
			]),
    ]
)
