// swift-tools-version: 5.8

import PackageDescription

let package = Package(
    name: "BackendStack",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .library(name: "BackendStack", targets: ["BackendStack"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0")
    ],
    targets: [
        .target(name: "BackendStack", dependencies: [
            .product(name: "Vapor", package: "vapor")
        ]),
        .testTarget(name: "BackendStackTests", dependencies: ["BackendStack"]),
    ]
)
