// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "FeatureHome",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "FeatureHome",
            type: .static,
            targets: ["FeatureHome"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Core")
    ],
    targets: [
        .target(
            name: "FeatureHome",
            dependencies: [
                "Domain",
                "Core"
            ]
        ),
        .testTarget(
            name: "FeatureHomeTests",
            dependencies: ["FeatureHome"]
        ),
    ]
)
