// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "Files",
    products: [
        .library(
            name: "Files",
            targets: ["Files"]),
    ],
    targets: [
        .target(
            name: "Files",
            dependencies: []),
        .testTarget(
            name: "FilesTests",
            dependencies: ["Files"]),
    ]
)
