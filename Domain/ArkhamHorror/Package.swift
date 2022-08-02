// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ArkhamHorror",
    platforms: [.iOS(.v10), .macOS(.v10_11)],
	products: [
		.library(
			name: "ArkhamHorror",
			targets: ["ArkhamHorror"]),
    ],
	dependencies: [
        .package(url: "https://github.com/hsluv/hsluv-swift.git", from: "2.1.0"),
		.package(name: "Map", path: "../Domain/Map"),
	],
    targets: [
        .target(
			name: "ArkhamHorror",
			dependencies: [
				"Map",
                .product(name: "HSLuvSwift", package: "hsluv-swift")
			]
		),
		.testTarget(
			name: "ArkhamHorrorTests",
			dependencies: []
		),
	]
)
