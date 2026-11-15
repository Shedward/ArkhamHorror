// swift-tools-version: 6.2
import PackageDescription

let package = Package(
    name: "Scripting",
    platforms: [.iOS(.v18), .macOS(.v15)],
    products: [.library(name: "Scripting", targets: ["Scripting"])],
    targets: [
        .target(name: "Scripting"),
        .testTarget(name: "ScriptingTests", dependencies: ["Scripting"])
    ]
)
