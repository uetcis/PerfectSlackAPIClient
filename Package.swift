// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "PerfectSlackAPIClient",
    products: [
        .library(
            name: "PerfectSlackAPIClient",
            targets: ["PerfectSlackAPIClient"]
        ),
    ],
    dependencies: [
        .package(url: "https://github.com/jorik041/PerfectAPIClient.git", from: "1.0.0")
    ],
    targets: [
        .target(
            name: "PerfectSlackAPIClient",
            dependencies: ["PerfectAPIClient"]
        ),
        .testTarget(
            name: "PerfectSlackAPIClientTests",
            dependencies: ["PerfectSlackAPIClient"]
        ),
    ]
)
