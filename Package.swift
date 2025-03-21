// swift-tools-version:5.7
import PackageDescription

let package = Package(
    name: "Pionex_DashBoard",
    platforms: [
        .macOS(.v12)
    ],
    products: [
        .executable(name: "Pionex_DashBoard", targets: ["Pionex_DashBoard"])
    ],
    dependencies: [
        // No external dependencies
    ],
    targets: [
        .executableTarget(
            name: "Pionex_DashBoard",
            dependencies: [],
            path: "Pionex",
            resources: [
                .process("Assets.xcassets"),
                .process("Preview Assets.xcassets"),
                .process("Pionex.entitlements")
            ]
        )
    ]
)