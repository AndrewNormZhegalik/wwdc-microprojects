// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "rate-limiter",
    platforms: [.macOS(.v12)],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "rate-limiter",
            targets: ["rate-limiter"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "rate-limiter"
        ),
        .testTarget(
            name: "rate-limiterTests",
            dependencies: ["rate-limiter"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
