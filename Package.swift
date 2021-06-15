// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "Hashical",
//	platforms: [ .iOS(.v9), .macOS(.v10_11) ],
	platforms: [ .iOS(.v13), .macOS(.v10_15) ],
	products: [
        .library(
            name: "Hashical",
            targets: ["Hashical"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "Hashical",
            dependencies: []),
        .testTarget(
            name: "HashicalTests",
            dependencies: ["Hashical"]),
    ]
)
