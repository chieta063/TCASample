// swift-tools-version:5.7

import PackageDescription

let package = Package(
  name: "MovieListSchema",
  platforms: [
    .iOS(.v12),
    .macOS(.v10_14),
    .tvOS(.v12),
    .watchOS(.v5),
  ],
  products: [
    .library(name: "MovieListSchema", targets: ["MovieListSchema"]),
    .library(name: "MovieListMock", targets: ["MovieListMock"]),
  ],
  dependencies: [
    .package(url: "https://github.com/apollographql/apollo-ios.git", from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "MovieListSchema",
      dependencies: [
        .product(name: "ApolloAPI", package: "apollo-ios"),
      ],
      path: "./Sources"
    ),
    .target(
      name: "MovieListMock",
      dependencies: [
        .product(name: "ApolloTestSupport", package: "apollo-ios"),
        .target(name: "MovieListSchema"),
      ],
      path: "./MovieListMock"
    ),
  ]
)
