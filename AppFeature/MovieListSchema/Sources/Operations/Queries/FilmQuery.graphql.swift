// @generated
// This file was automatically generated and should not be edited.

@_exported import ApolloAPI

public class FilmQuery: GraphQLQuery {
  public static let operationName: String = "Film"
  public static let operationDocument: ApolloAPI.OperationDocument = .init(
    definition: .init(
      #"query Film($filmId: ID) { film(id: $filmId) { __typename id title releaseDate characterConnection { __typename characters { __typename id name birthYear homeworld { __typename id name } } } openingCrawl } }"#
    ))

  public var filmId: GraphQLNullable<ID>

  public init(filmId: GraphQLNullable<ID>) {
    self.filmId = filmId
  }

  public var __variables: Variables? { ["filmId": filmId] }

  public struct Data: MovieListSchema.SelectionSet {
    public let __data: DataDict
    public init(_dataDict: DataDict) { __data = _dataDict }

    public static var __parentType: ApolloAPI.ParentType { MovieListSchema.Objects.Root }
    public static var __selections: [ApolloAPI.Selection] { [
      .field("film", Film?.self, arguments: ["id": .variable("filmId")]),
    ] }

    public var film: Film? { __data["film"] }

    /// Film
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
        .field("releaseDate", String?.self),
        .field("characterConnection", CharacterConnection?.self),
        .field("openingCrawl", String?.self),
      ] }

      /// The ID of an object
      public var id: MovieListSchema.ID { __data["id"] }
      /// The title of this film.
      public var title: String? { __data["title"] }
      /// The ISO 8601 date format of film release at original creator country.
      public var releaseDate: String? { __data["releaseDate"] }
      public var characterConnection: CharacterConnection? { __data["characterConnection"] }
      /// The opening paragraphs at the beginning of this film.
      public var openingCrawl: String? { __data["openingCrawl"] }

      /// Film.CharacterConnection
      ///
      /// Parent Type: `FilmCharactersConnection`
      public struct CharacterConnection: MovieListSchema.SelectionSet {
        public let __data: DataDict
        public init(_dataDict: DataDict) { __data = _dataDict }

        public static var __parentType: ApolloAPI.ParentType { MovieListSchema.Objects.FilmCharactersConnection }
        public static var __selections: [ApolloAPI.Selection] { [
          .field("__typename", String.self),
          .field("characters", [Character?]?.self),
        ] }

        /// A list of all of the objects returned in the connection. This is a convenience
        /// field provided for quickly exploring the API; rather than querying for
        /// "{ edges { node } }" when no edge data is needed, this field can be be used
        /// instead. Note that when clients like Relay need to fetch the "cursor" field on
        /// the edge to enable efficient pagination, this shortcut cannot be used, and the
        /// full "{ edges { node } }" version should be used instead.
        public var characters: [Character?]? { __data["characters"] }

        /// Film.CharacterConnection.Character
        ///
        /// Parent Type: `Person`
        public struct Character: MovieListSchema.SelectionSet {
          public let __data: DataDict
          public init(_dataDict: DataDict) { __data = _dataDict }

          public static var __parentType: ApolloAPI.ParentType { MovieListSchema.Objects.Person }
          public static var __selections: [ApolloAPI.Selection] { [
            .field("__typename", String.self),
            .field("id", MovieListSchema.ID.self),
            .field("name", String?.self),
            .field("birthYear", String?.self),
            .field("homeworld", Homeworld?.self),
          ] }

          /// The ID of an object
          public var id: MovieListSchema.ID { __data["id"] }
          /// The name of this person.
          public var name: String? { __data["name"] }
          /// The birth year of the person, using the in-universe standard of BBY or ABY -
          /// Before the Battle of Yavin or After the Battle of Yavin. The Battle of Yavin is
          /// a battle that occurs at the end of Star Wars episode IV: A New Hope.
          public var birthYear: String? { __data["birthYear"] }
          /// A planet that this person was born on or inhabits.
          public var homeworld: Homeworld? { __data["homeworld"] }

          /// Film.CharacterConnection.Character.Homeworld
          ///
          /// Parent Type: `Planet`
          public struct Homeworld: MovieListSchema.SelectionSet {
            public let __data: DataDict
            public init(_dataDict: DataDict) { __data = _dataDict }

            public static var __parentType: ApolloAPI.ParentType { MovieListSchema.Objects.Planet }
            public static var __selections: [ApolloAPI.Selection] { [
              .field("__typename", String.self),
              .field("id", MovieListSchema.ID.self),
              .field("name", String?.self),
            ] }

            /// The ID of an object
            public var id: MovieListSchema.ID { __data["id"] }
            /// The name of this planet.
            public var name: String? { __data["name"] }
          }
        }
      }
    }
  }
}
