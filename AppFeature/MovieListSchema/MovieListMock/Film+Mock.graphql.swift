// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MovieListSchema

public class Film: MockObject {
  public static let objectType: Object = MovieListSchema.Objects.Film
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Film>>

  public struct MockFields {
    @Field<FilmCharactersConnection>("characterConnection") public var characterConnection
    @Field<MovieListSchema.ID>("id") public var id
    @Field<String>("openingCrawl") public var openingCrawl
    @Field<String>("releaseDate") public var releaseDate
    @Field<String>("title") public var title
  }
}

public extension Mock where O == Film {
  convenience init(
    characterConnection: Mock<FilmCharactersConnection>? = nil,
    id: MovieListSchema.ID? = nil,
    openingCrawl: String? = nil,
    releaseDate: String? = nil,
    title: String? = nil
  ) {
    self.init()
    _setEntity(characterConnection, for: \.characterConnection)
    _setScalar(id, for: \.id)
    _setScalar(openingCrawl, for: \.openingCrawl)
    _setScalar(releaseDate, for: \.releaseDate)
    _setScalar(title, for: \.title)
  }
}
