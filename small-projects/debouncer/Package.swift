// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "debouncer",
    platforms: [
        .macOS(.v13) // 👈 Set this to .v13 for macOS 13 Ventura
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "debouncer",
            targets: ["debouncer"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "debouncer"
        ),
        .testTarget(
            name: "debouncerTests",
            dependencies: ["debouncer"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
