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
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0"),
		.package(name: "Graph", path: "../Utils/Graph"),
		.package(name: "XCTestUtils", path: "../Utils/XCTestUtils"),
		.package(name: "Prelude", path: "../Utils/Prelude"),
		.package(name: "Common", path: "../Utils/Common")
	],
    targets: [
        .target(
            name: "Map",
			dependencies: [
                "Yams",
				"Graph",
				"Prelude",
				"Common"
			]
		),
        .testTarget(
            name: "MapTests",
			dependencies: [
				"Map",
				"XCTestUtils"
			],
			resources: [
				.copy("Resources/TestData/")
			]
		),
    ]
)
