// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "thread-explosion",
    platforms: [.macOS(.v12)],
    targets: [
        .executableTarget(
            name: "thread-explosion"
        ),
        .testTarget(
            name: "thread-explosionTests",
            dependencies: ["thread-explosion"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
