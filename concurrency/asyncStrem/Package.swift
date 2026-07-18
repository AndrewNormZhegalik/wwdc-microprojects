// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "asyncStrem",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "asyncStrem",
            targets: ["asyncStrem"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "asyncStrem"
        ),
        .testTarget(
            name: "asyncStremTests",
            dependencies: ["asyncStrem"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
