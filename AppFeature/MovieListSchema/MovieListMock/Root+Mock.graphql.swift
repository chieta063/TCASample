// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MovieListSchema

public class Root: MockObject {
  public static let objectType: Object = MovieListSchema.Objects.Root
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Root>>

  public struct MockFields {
    @Field<FilmsConnection>("allFilms") public var allFilms
    @Field<Film>("film") public var film
  }
}

public extension Mock where O == Root {
  convenience init(
    allFilms: Mock<FilmsConnection>? = nil,
    film: Mock<Film>? = nil
  ) {
    self.init()
    _setEntity(allFilms, for: \.allFilms)
    _setEntity(film, for: \.film)
  }
}
