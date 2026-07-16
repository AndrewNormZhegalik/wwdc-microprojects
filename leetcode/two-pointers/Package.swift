// swift-tools-version: 6.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "two-pointers",
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "two-pointers",
            targets: ["two-pointers"]
        ),
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "two-pointers"
        ),
        .testTarget(
            name: "two-pointersTests",
            dependencies: ["two-pointers"]
        ),
    ],
    swiftLanguageModes: [.v6]
)
