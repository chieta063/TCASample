import ApolloTestSupport
import ComposableArchitecture
import Foundation
import MovieListMock
import MovieListSchema
import SwiftUI

public enum MockData {
  private static let homeworld: Mock<Planet> = Mock(
    id: "cGxhbmV0czox",
    name: "Tatooine"
  )

  private static let person: Mock<Person> = Mock(
    birthYear: "19BBY",
    homeworld: homeworld,
    id: "cGVvcGxlOjE=",
    name: "Luke Skywalker"
  )

  private static let film: Mock<Film> = .init(
    characterConnection: Mock(characters: [person]),
    id: "ZmlsbXM6MQ==",
    openingCrawl: "It is a period of civil war.\r\nRebel spaceships, striking\r\nfrom a hidden base, have won\r\ntheir first victory against\r\nthe evil Galactic Empire.\r\n\r\nDuring the battle, Rebel\r\nspies managed to steal secret\r\nplans to the Empire's\r\nultimate weapon, the DEATH\r\nSTAR, an armored space\r\nstation with enough power\r\nto destroy an entire planet.\r\n\r\nPursued by the Empire's\r\nsinister agents, Princess\r\nLeia races home aboard her\r\nstarship, custodian of the\r\nstolen plans that can save her\r\npeople and restore\r\nfreedom to the galaxy...",
    releaseDate: "1977-05-25",
    title: "A New Hope"
  )

  public static let filmListResponse: [FilmData] = [
    FilmData.from(film),
  ]

  public static let filmDetailResponse: FilmDetail = FilmDetail.from(film)
}
