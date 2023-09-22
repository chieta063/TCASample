// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MovieListSchema

public class FilmCharactersConnection: MockObject {
  public static let objectType: Object = MovieListSchema.Objects.FilmCharactersConnection
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<FilmCharactersConnection>>

  public struct MockFields {
    @Field<[Person?]>("characters") public var characters
  }
}

public extension Mock where O == FilmCharactersConnection {
  convenience init(
    characters: [Mock<Person>?]? = nil
  ) {
    self.init()
    _setList(characters, for: \.characters)
  }
}
