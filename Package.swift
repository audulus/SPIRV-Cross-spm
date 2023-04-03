// swift-tools-version:5.3
import PackageDescription

let package = Package(
    name: "SPIRV-Cross",
    platforms: [
        .macOS(.v11), .iOS(.v13)
    ],
    products: [
        .library(
            name: "SPIRV-Cross",
            targets: ["SPIRV-Cross"])
    ],
    targets: [
        .binaryTarget(
            name: "SPIRV-Cross",
            path: "SPIRV-Cross.xcframework"
        )
    ]
)
