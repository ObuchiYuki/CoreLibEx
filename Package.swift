// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "CoreLibEx",
    products: [
        .library(name: "CoreLibEx", targets: ["CoreLibEx"]),
    ],
    targets: [
        .target(name: "CoreLibEx"),
        .testTarget(name: "CoreLibExTests", dependencies: ["CoreLibEx"]),
    ]
)
