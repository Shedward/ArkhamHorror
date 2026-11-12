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
        .package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0"),
        .package(path: "../../Utils/Prelude"),
        .package(path: "../Common"),
		.package(path: "../Map"),
	],
    targets: [
        .target(
			name: "ArkhamHorror",
			dependencies: [
                "Yams",
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
