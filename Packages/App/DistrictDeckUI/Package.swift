// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "DistrictDeckUI",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [
        .library(name: "DistrictDeckUI", targets: ["DistrictDeckUI"])
    ],
    targets: [
        .target(name: "DistrictDeckUI")
    ]
)
