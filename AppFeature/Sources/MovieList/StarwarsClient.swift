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

public struct User: Equatable {}

public struct StarwarsClient {
  var fetchAllFilms: () async throws -> [AllFilmsQuery.Data.AllFilms.Film]
  var fetchFilm: (String) async throws -> FilmQuery.Data.Film
  var post: (User) async throws -> User
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
  } post: { user in
    do {
      // TODO: apolloのMutation実行
//      try await withCheckedThrowingContinuation { continuation in
//        Network.shared.apollo.perform(mutation: EditUserMutation(
//          _eq: .init(integerLiteral: user.id),
//          memo: .init(stringLiteral: user.memo ?? ""),
//          name: .init(stringLiteral: user.name),
//          updated_at: .init(stringLiteral: user.updatedAt?.description ?? "")
//        )) { result in
//          guard let data = try? result.get().data else {
//            let error = NSError(domain: "data is nil", code: 0, userInfo: nil)
//            continuation.resume(throwing: error)
//            return
//          }
//          continuation.resume(returning: data)
//        }
//      }
      return User()
    } catch {
      // TODO: エラー処理
    }
  }

  public static var testValue: StarwarsClient = Self {
    MockData.filmListResponse
  } fetchFilm: { _ in
    MockData.filmDetailResponse
  } post: { _ in
    User()
  }

  public static var previewValue: StarwarsClient = Self {
    MockData.filmListResponse
  } fetchFilm: { _ in
    MockData.filmDetailResponse
  } post: { _ in
    User()
  }
}

public extension DependencyValues {
  var starwarsClient: StarwarsClient {
    get { self[StarwarsClient.self] }
    set { self[StarwarsClient.self] = newValue }
  }
}
