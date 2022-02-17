// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Map",
    products: [
        .library(
            name: "Map",
            targets: ["Map"]),
    ],
	dependencies: [
		.package(name: "Graph", path: "../Utils/Graph"),
		.package(name: "XCTestUtils", path: "../Utils/XCTestUtils"),
		.package(name: "Prelude", path: "../Utils/Prelude")
	],
    targets: [
        .target(
            name: "Map",
			dependencies: [
				"Graph",
				"Prelude"
			]
		),
        .testTarget(
            name: "MapTests",
			dependencies: [
				"XCTestUtils"
			],
			resources: [
				.copy("Resources/TestData/")
			]
		),
    ]
)
