// swift-tools-version:6.0
import PackageDescription

let package = Package(
    name: "SpotlightLyrics",
    platforms: [
        .macOS(.v13), // adjust as needed
        .iOS(.v16)
    ],
    products: [
        .library(
            name: "SpotlightLyrics",
            targets: ["SpotlightLyrics"]
        ),
    ],
    targets: [
        .target(
            name: "SpotlightLyrics",
            dependencies: []
        )
    ]
)

