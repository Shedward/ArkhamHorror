// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Graph",
    products: [
        .library(
            name: "Graph",
            targets: ["Graph"]),
    ],
    dependencies: [
		.package(name: "XCTestUtils", path: "../Utils/XCTestUtils")
	],
    targets: [
        .target(
            name: "Graph",
            dependencies: []),
        .testTarget(
            name: "GraphTests",
            dependencies: [
				"Graph",
				"XCTestUtils"
			]),
    ]
)
