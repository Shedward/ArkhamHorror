// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DistrictDeckUI",
    platforms: [.iOS(.v16), .macOS(.v13)],
    products: [
        .library(name: "DistrictDeckUI", targets: ["DistrictDeckUI"])
    ],
    targets: [
        .target(name: "DistrictDeckUI")
    ]
)
