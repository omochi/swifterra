// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "swifterra",
    products: [
        .library(name: "Swifterra", targets: ["Swifterra"]),
    ],
    targets: [
        .target(name: "Swifterra"),
        .testTarget(name: "SwifterraTests", dependencies: ["Swifterra"]),
    ]
)
