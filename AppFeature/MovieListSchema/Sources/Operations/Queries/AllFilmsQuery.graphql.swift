// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class AllFilmsQuery: GraphQLQuery {
  public static let operationName: String = "AllFilms"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query AllFilms { allFilms { __typename films { __typename id title } } }"#
    ))

  public init() {}

  public struct Data: MovieListSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { MovieListSchema.Objects.Root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("allFilms", AllFilms?.self),
    ] }

    public var allFilms: AllFilms? { __data["allFilms"] }

    /// AllFilms
    ///
    /// Parent Type: `FilmsConnection`
    public struct AllFilms: MovieListSchema.SelectionSet {
      public let __data: DataDict
      public init(_dataDict: DataDict) { __data = _dataDict }

      public static var __parentType: ApolloAPI.ParentType { MovieListSchema.Objects.FilmsConnection }
      public static var __selections: [ApolloAPI.Selection] { [
        .field("__typename", String.self),
        .field("films", [Film?]?.self),
      ] }

      /// A list of all of the objects returned in the connection. This is a convenience
      /// field provided for quickly exploring the API; rather than querying for
      /// "{ edges { node } }" when no edge data is needed, this field can be be used
      /// instead. Note that when clients like Relay need to fetch the "cursor" field on
      /// the edge to enable efficient pagination, this shortcut cannot be used, and the
      /// full "{ edges { node } }" version should be used instead.
      public var films: [Film?]? { __data["films"] }

      /// AllFilms.Film
      ///
      /// Parent Type: `Film`
      public struct Film: MovieListSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { MovieListSchema.Objects.Film }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("id", MovieListSchema.ID.self),
          .field("title", String?.self),
        ] }

        /// The ID of an object
        public var id: MovieListSchema.ID { __data["id"] }
        /// The title of this film.
        public var title: String? { __data["title"] }
      }
    }
  }
}
