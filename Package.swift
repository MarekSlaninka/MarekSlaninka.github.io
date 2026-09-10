// swift-tools-version:5.9

import PackageDescription

let package = Package(
    name: "SelfPromo",
    platforms: [.macOS(.v12)],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.9.0")
    ],
    targets: [
        .executableTarget(
            name: "SelfPromo",
            dependencies: [
                .product(name: "Publish", package: "publish")
            ]
        )
    ]
)
