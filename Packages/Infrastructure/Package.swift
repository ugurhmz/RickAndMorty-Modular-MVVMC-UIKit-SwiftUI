// swift-tools-version: 6.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Infrastructure",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(
            name: "Infrastructure",
            targets: ["Infrastructure"]),
    ],
    dependencies: [
        .package(url: "https://github.com/Alamofire/Alamofire.git", from: "5.11.0")
    ],
    targets: [
        .target(
            name: "Infrastructure",
            dependencies: [
                "Alamofire"
            ]
        ),
        .testTarget(
            name: "InfrastructureTests",
            dependencies: ["Infrastructure"]
        ),
    ]
)
