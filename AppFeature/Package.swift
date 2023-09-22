// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppFeature",
  platforms: [.iOS(.v16)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(
      name: "AppFeature",
      targets: ["Counter"]
    ),
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.2.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.4.0"),
  ],
  targets: [
    .target(
      name: "Counter",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture")
      ]
    ),
    .testTarget(
      name: "AppFeatureTests",
      dependencies: ["Counter"]
    ),
  ]
)
