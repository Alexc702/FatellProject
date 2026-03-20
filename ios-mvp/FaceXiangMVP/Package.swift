// swift-tools-version: 5.7
import PackageDescription

let package = Package(
    name: "FaceXiangMVP",
    platforms: [
        .iOS(.v16),
        .macOS(.v13)
    ],
    products: [
        .library(
            name: "FaceXiangCore",
            targets: ["FaceXiangCore"]
        ),
        .executable(
            name: "FaceXiangApp",
            targets: ["FaceXiangApp"]
        ),
        .executable(
            name: "FaceXiangValidator",
            targets: ["FaceXiangValidator"]
        )
    ],
    targets: [
        .target(
            name: "FaceXiangCore"
        ),
        .executableTarget(
            name: "FaceXiangApp",
            dependencies: ["FaceXiangCore"],
            path: "Sources/FaceXiangApp"
        ),
        .executableTarget(
            name: "FaceXiangValidator",
            dependencies: ["FaceXiangCore"],
            path: "Sources/FaceXiangValidator",
            resources: [
                .process("fixtures")
            ]
        ),
        .testTarget(
            name: "FaceXiangCoreTests",
            dependencies: ["FaceXiangCore"],
            resources: [
                .process("fixtures")
            ]
        )
    ]
)
