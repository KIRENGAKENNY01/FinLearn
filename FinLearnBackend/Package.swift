// swift-tools-version:5.10
import PackageDescription

let package = Package(
    name: "FinLearnBackend",
    platforms: [
       .macOS(.v13)
    ],
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "4.89.0"),
        // 🗄 ORM for database interaction (using Fluent for potential SQL needs, but User asked for Firestore)
        // Since User asked for Firestore, complete "import Firestore" is not standard in Vapor without a specific wrapper.
        // We will include JWT for Auth.
        .package(url: "https://github.com/vapor/jwt.git", from: "4.0.0"),
    ],
    targets: [
        .executableTarget(
            name: "Run",
            dependencies: [
                .target(name: "App")
            ]
        ),
        .target(
            name: "App",
            dependencies: [
                .product(name: "Vapor", package: "vapor"),
                .product(name: "JWT", package: "jwt")
            ],
            swiftSettings: [
                // Enable better optimizations when building in Release configuration. Despite this being
                // the default behavior on Swift 5.5+, specifically stating it helps facilitate
                // tooling optimization for some edge cases.
                .unsafeFlags(["-cross-module-optimization"], .when(configuration: .release))
            ]
        ),

    ]
)
