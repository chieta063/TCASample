import ComposableArchitecture
import SwiftUI

public struct FilmDetailView: View {
  public let store: StoreOf<FilmDetailFeature>
  
  public var body: some View {
    WithViewStore(store, observe: {$0}) { viewStore in
      VStack {
        if viewStore.isLoading {
          ProgressView()
        } else if let error = viewStore.displayError {
          ErrorView(error: error)
        } else if let film = viewStore.film {
          List {
            Section("Title") {
              Text(film.title ?? "")
            }
            Section("Release Date") {
              Text(film.releaseDate?.replacingOccurrences(
                of: "-",
                with: "/"
              ) ?? "")
            }
            Section("Characters") {
              ForEach(film.characterList, id: \.id) { character in
                VStack(alignment: .leading) {
                  Text(character.name ?? "")
                  Text(character.birthYear ?? "")
                    .font(.caption)
                  Text(character.homeworld?.name ?? "")
                    .font(.caption)
                }
              }
            }
            Section("OpeningCrawl") {
              Text(film.openingCrawl ?? "")
            }
          }
        }
      }
      .onAppear {
        if !viewStore.state.isLoading, viewStore.state.film == nil {
          store.send(.onAppear(viewStore.filmId))
        }
      }
    }
  }
}

public struct FilmDetailView_Previews: PreviewProvider {
  public static var previews: some View {
    FilmDetailView(
      store: Store(
        initialState: FilmDetailFeature.State(
          filmId: UUID().uuidString,
          film: MockData.filmDetailResponse
        ),
        reducer: { FilmDetailFeature() }
      )
    )
  }
}
