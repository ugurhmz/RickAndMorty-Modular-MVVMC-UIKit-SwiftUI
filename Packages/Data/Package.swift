// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Data",
    products: [
        .library(
            name: "Data",
            type: .static,
            targets: ["Data"]
        ),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "Data"),
        .testTarget(
            name: "DataTests",
            dependencies: ["Data"]
        ),
    ]
)
