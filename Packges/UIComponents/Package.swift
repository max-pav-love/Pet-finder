// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "UIComponents",
    platforms: [.iOS(.v14)],
    products: [
        .library(
            name: "UIComponents",
            targets: ["UIComponents"]),
    ],
    dependencies: [
        .package(url: "https://github.com/onevcat/Kingfisher.git", exact: .init(7, 8, 1))
    ],
    targets: [
        .target(
            name: "UIComponents",
            dependencies: [
                "Kingfisher"
            ],
            path: "Sources",
            resources: [.process("Resources/Fonts")]
        ),
    ]
)
