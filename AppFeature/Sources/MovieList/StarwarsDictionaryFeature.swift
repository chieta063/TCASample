import Foundation
import ComposableArchitecture
import MovieListSchema

public struct StarwarsDictionaryFeature: Reducer {
  public struct State: Equatable {
    var isInitialized: Bool = false
    var isLoading: Bool = false
    var filmList: IdentifiedArrayOf<FilmData> = []
  }
  
  public enum Action: Equatable {
    case onAppear
    case onLoadEnd(IdentifiedArrayOf<FilmData>)
    case films(id: ID, action: FilmDetailFeature.Action)
  }
  
  @Dependency(\.starwarsClient) var client
  
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
    case .onLoadEnd(let filmList):
      state.isLoading = false
      state.filmList = filmList
      state.isInitialized = true
      return .none
    default:
      return .none
    }
  }
}
