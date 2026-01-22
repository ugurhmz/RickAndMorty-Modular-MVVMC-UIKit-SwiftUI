// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Data",
            type: .static,
            targets: ["Data"]),
    ],
    dependencies: [
        .package(path: "../Domain"),
        .package(path: "../Infrastructure")
    ],
    targets: [
        .target(
            name: "Data",
            dependencies: [
                "Domain",
                "Infrastructure"
            ]
        ),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]
        ),
    ]
)
