// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Cards",
    platforms: [
        .iOS(.v14),
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "Cards",
            targets: ["Cards"]),
    ],
    dependencies: [
		.package(url: "https://github.com/jpsim/Yams.git", from: "5.0.0"),
		.package(name: "Prelude", path: "../Utils/Prelude"),
		.package(name: "Script", path: "../Utils/Script"),
		.package(name: "FormattedText", path: "../Utils/FormattedText"),
		.package(name: "Common", path: "../Domain/Common")
    ],
    targets: [
        .target(
            name: "Cards",
            dependencies: ["Yams", "Prelude", "Script", "FormattedText", "Common"]),
        .testTarget(
            name: "CardsTests",
            dependencies: ["Cards"],
			resources: [
				.copy("Resources/TestData/")
			]
		),
    ]
)
