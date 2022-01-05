// swift-tools-version:5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "XCTestUtils",
    products: [
        .library(
            name: "XCTestUtils",
            targets: ["XCTestUtils"]),
    ],
    dependencies: [],
    targets: [
        .target(
            name: "XCTestUtils",
            dependencies: [])
    ]
)
