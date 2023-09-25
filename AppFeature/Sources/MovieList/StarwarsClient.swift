import Apollo
import ApolloTestSupport
import ComposableArchitecture
import Foundation
import MovieListSchema

public enum StarwarsClientError: Error, LocalizedError {
  case filmNotFound
  
  public var errorDescription: String? {
    switch self {
    case .filmNotFound:
      return "Film Not Found"
    }
  }
}

public struct StarwarsClient {
  var fetchAllFilms: () async throws -> [AllFilmsQuery.Data.AllFilms.Film]
  var fetchFilm: (String) async throws -> FilmQuery.Data.Film
}

extension StarwarsClient: DependencyKey {
  public static var liveValue: StarwarsClient = Self {
    try await withCheckedThrowingContinuation { continuation in
      Network.shared.apollo.fetch(query: AllFilmsQuery()) { result in
        switch result {
        case let .success(data):
          let films = data.data?.allFilms?.films?.compactMap { $0 } ?? []
          continuation.resume(returning: films)
        case let .failure(error):
          continuation.resume(throwing: error)
        }
      }
    }
  } fetchFilm: { filmId in
    try await withCheckedThrowingContinuation { continuation in
      Network.shared.apollo.fetch(query: FilmQuery(filmId: .some(filmId))) { result in
        switch result {
        case let .success(data):
          guard let film = data.data?.film else {
            continuation.resume(throwing: StarwarsClientError.filmNotFound)
            return
          }
          continuation.resume(returning: film)
        case let .failure(error):
          continuation.resume(throwing: error)
        }
      }
    }
  }
  
  public static var testValue: StarwarsClient = Self {
    return MockData.filmListResponse
  } fetchFilm: { _ in
    return MockData.filmDetailResponse
  }
  
  public static var previewValue: StarwarsClient = Self {
    return MockData.filmListResponse
  } fetchFilm: { _ in
    return MockData.filmDetailResponse
  }
}

extension DependencyValues {
  public var starwarsClient: StarwarsClient {
    get { self[StarwarsClient.self] }
    set { self[StarwarsClient.self] = newValue }
  }
}
