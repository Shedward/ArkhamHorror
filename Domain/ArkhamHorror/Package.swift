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
	dependencies: [
		.package(name: "Graph", path: "../Utils/Graph"),
		.package(name: "XCTestUtils", path: "../Utils/XCTestUtils")
	],
    targets: [
        .target(
			name: "ArkhamHorror",
			dependencies: [
				"Graph"
			]
		),
		.testTarget(
			name: "ArkhamHorrorTests",
			dependencies: [
				"ArkhamHorror",
				"XCTestUtils"
			],
			resources: [
				.copy("Resources/TestData/")
			]
		),
	]
)
