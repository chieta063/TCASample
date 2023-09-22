// @generated
// This file was automatically generated and should not be edited.

import ApolloTestSupport
import MovieListSchema

public class Planet: MockObject {
  public static let objectType: Object = MovieListSchema.Objects.Planet
  public static let _mockFields = MockFields()
  public typealias MockValueCollectionType = Array<Mock<Planet>>

  public struct MockFields {
    @Field<MovieListSchema.ID>("id") public var id
    @Field<String>("name") public var name
  }
}

public extension Mock where O == Planet {
  convenience init(
    id: MovieListSchema.ID? = nil,
    name: String? = nil
  ) {
    self.init()
    _setScalar(id, for: \.id)
    _setScalar(name, for: \.name)
  }
}
