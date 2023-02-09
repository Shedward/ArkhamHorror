// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
	name: "ArkhamHorror",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
	products: [
		.library(
			name: "ArkhamHorror",
			targets: ["ArkhamHorror"]),
    ],
	dependencies: [
        .package(name: "Prelude", path: "../Utils/Prelude"),
        .package(name: "Common", path: "../Domain/Common"),
		.package(name: "Map", path: "../Domain/Map"),
	],
    targets: [
        .target(
			name: "ArkhamHorror",
			dependencies: [
                "Prelude",
                "Common",
				"Map",
			]
		),
		.testTarget(
			name: "ArkhamHorrorTests",
			dependencies: [
                "ArkhamHorror"
            ]
		),
	]
)
