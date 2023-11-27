import ComposableArchitecture
import Foundation
import MovieListSchema

public struct MovieListFeature: Reducer {
  public struct State: Equatable {
    var isInitialized: Bool = false
    var isLoading: Bool = false
    var filmList: IdentifiedArrayOf<FilmData> = []
    var user: User?

    public init(isInitialized: Bool = false, isLoading: Bool = false, filmList: IdentifiedArrayOf<FilmData> = []) {
      self.isInitialized = isInitialized
      self.isLoading = isLoading
      self.filmList = filmList
    }
  }

  public enum Action: Equatable {
    case onAppear
    case onLoadEnd(IdentifiedArrayOf<FilmData>)
    case films(id: ID, action: FilmDetailFeature.Action)
    case onTapSendButton(User)
    case onUpdateUser(User)
  }

  @Dependency(\.starwarsClient) var client
  var fileManager = LocalFileManager()

  public init() {}

  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .onAppear:
      state.isLoading = true
      return .run { send in
        do {
          let response = try await client.fetchAllFilms()
          await send(.onLoadEnd(IdentifiedArray(uniqueElements: response)))
        } catch {
          await send(.onLoadEnd([]))
        }
      }
    case let .onLoadEnd(filmList):
      state.isLoading = false
      state.filmList = filmList
      state.isInitialized = true
      return .none
    case let .onTapSendButton(user):
      return .run { send in
        do {
          try await fileManager.write(user: user)
          let response = try await client.post(user)
          await send(.onUpdateUser(response))
        } catch {
          // TODO: エラー処理
          // オフラインのエラーだったら何もしない
        }
      }
    case let .onUpdateUser(user):
      state.user = user
      return .none
    default:
      return .none
    }
  }
}


public final class LocalFileManager {

  public func write(user:User) async throws {
    do {
      // TODO: JSONへの書き込み処理
    } catch {
      throw error
    }
  }
}
