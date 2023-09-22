// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MovieListSchema

public class Person: MockObject {
  public static let objectType: Object = MovieListSchema.Objects.Person
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Person>>

  public struct MockFields {
    @Field<String>("birthYear") public var birthYear
    @Field<Planet>("homeworld") public var homeworld
    @Field<MovieListSchema.ID>("id") public var id
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Person {
  convenience init(
    birthYear: String? = nil,
    homeworld: Mock<Planet>? = nil,
    id: MovieListSchema.ID? = nil,
    name: String? = nil
  ) {
    self.init()
    _setScalar(birthYear, for: \.birthYear)
    _setEntity(homeworld, for: \.homeworld)
    _setScalar(id, for: \.id)
    _setScalar(name, for: \.name)
  }
}
