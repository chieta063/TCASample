// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MovieListSchema

public class FilmsConnection: MockObject {
  public static let objectType: Object = MovieListSchema.Objects.FilmsConnection
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<FilmsConnection>>

  public struct MockFields {
    @Field<[Film?]>("films") public var films
  }
}

public extension Mock where O == FilmsConnection {
  convenience init(
    films: [Mock<Film>?]? = nil
  ) {
    self.init()
    _setList(films, for: \.films)
  }
}
