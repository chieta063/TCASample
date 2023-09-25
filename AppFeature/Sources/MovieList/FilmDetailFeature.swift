import Foundation
import ComposableArchitecture
import MovieListSchema

public struct FilmDetailFeature: Reducer {
  public struct State: Equatable {
    let filmId: ID
    var isLoading: Bool = false
    var film: FilmDetail?
    var displayError: DisplayError?
  }
  
  public enum Action: Equatable {
    case onAppear(ID)
    case onFilmLoaded(FilmDetail)
    case loadFilmFailure(DisplayError)
  }
  
  @Dependency(\.starwarsClient) var client
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case let .onAppear(filmId):
      state.isLoading = true
      return .run { send in
        do {
          let response = try await client.fetchFilm(filmId)
          
          await send(.onFilmLoaded(response))
        } catch {
          await send(.loadFilmFailure(.filmNotFound))
        }
      }
    case .onFilmLoaded(let filmData):
      state.isLoading = false
      state.film = filmData
    case let .loadFilmFailure(error):
      state.isLoading = false
      state.displayError = error
    }
    return .none
  }
}
