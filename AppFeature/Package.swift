// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "AppFeature",
  platforms: [.iOS(.v17)],
  products: [
    // Products define the executables and libraries a package produces, making them visible to other packages.
    .library(name: "Counter", targets: ["Counter"]),
    .library(name: "ContactList", targets: ["ContactList"]),
    .library(name: "NavigationList", targets: ["NavigationList"]),
    .library(name: "MovieList", targets: ["MovieList"]),
    .library(name: "FeatureList", targets: ["FeatureList"]),
    .library(name: "RecipeList", targets: ["RecipeList"]),
    .library(name: "TabBar", targets: ["TabBar"])
  ],
  dependencies: [
    .package(url: "https://github.com/pointfreeco/swift-composable-architecture", from: "1.2.0"),
    .package(url: "https://github.com/apollographql/apollo-ios", from: "1.4.0"),
    .package(path: "MovieListSchema"),
    .package(url: "https://github.com/pointfreeco/swift-snapshot-testing", from: "1.12.0"),
  ],
  targets: [
    .target(
      name: "Counter",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "ContactList",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "NavigationList",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .target(
      name: "MovieList",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        .product(name: "Apollo", package: "apollo-ios"),
        .product(name: "ApolloTestSupport", package: "apollo-ios"),
        .product(name: "MovieListSchema", package: "MovieListSchema"),
        .product(name: "MovieListMock", package: "MovieListSchema"),
      ]
    ),
    .target(
      name: "FeatureList",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
        "Counter",
        "ContactList",
        "NavigationList",
        "MovieList",
        "TabBar"
      ]
    ),
    .target(
      name: "RecipeList"
    ),
    .target(
      name: "TabBar",
      dependencies: [
        .product(name: "ComposableArchitecture", package: "swift-composable-architecture"),
      ]
    ),
    .testTarget(
      name: "CounterTests",
      dependencies: [
        "Counter",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ]
    ),
    .testTarget(
      name: "ContactListTests",
      dependencies: [
        "ContactList",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ]
    ),
    .testTarget(
      name: "MovieListTests",
      dependencies: [
        "MovieList",
        .product(name: "SnapshotTesting", package: "swift-snapshot-testing"),
      ]
    ),
  ]
)
