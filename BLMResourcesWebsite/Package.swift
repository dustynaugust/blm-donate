// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "BLMResourcesWebsite",
    products: [
        .executable(name: "BLMResourcesWebsite", targets: ["BLMResourcesWebsite"])
    ],
    dependencies: [
        .package(url: "https://github.com/johnsundell/publish.git", from: "0.3.0")
    ],
    targets: [
        .target(
            name: "BLMResourcesWebsite",
            dependencies: ["Publish"]
        )
    ]
)