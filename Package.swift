// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "PlanetSwift",
    products: [
        .library(name: "PlanetSwift", targets: ["PlanetSwift"])
    ],
    dependencies: [
		.package(url: "https://github.com/SmallPlanetSporks/AEXML.git", .branch("spmaster")),
    ],
    targets: [
        .target(
            name: "PlanetSwift",
            dependencies: [
				"AEXML"
            ]
        ),
        .testTarget(
            name: "PlanetSwiftTests",
            dependencies: [
				"AEXML"
            ],
            exclude: [
                "Resources"
            ]
        )
    ]
)
