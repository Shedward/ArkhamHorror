// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "GameEngine",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [.library(name: "GameEngine", targets: ["GameEngine"])],
    dependencies: [
        .package(path: "../../Core/Scripting"),
        .package(url: "https://github.com/jpsim/Yams.git", from: "6.2.2")
    ],
    targets: [
        .target(name: "GameEngine", dependencies: ["Scripting"]),
        .testTarget(name: "GameEngineTests", dependencies: [
            "GameEngine", "Scripting", .product(name: "Yams", package: "Yams")
        ])
    ]
)
