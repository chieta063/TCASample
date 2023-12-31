import ComposableArchitecture
import SwiftUI

public struct MovieListView: View {
  let store: StoreOf<MovieListFeature>

  public init(store: StoreOf<MovieListFeature>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }, content: { viewStore in
      VStack {
        if viewStore.isLoading {
          ProgressView()
        } else if !viewStore.filmList.isEmpty {
          List {
            ForEachStore(store.scope(
              state: \.filmList,
              action: MovieListFeature.Action.films(id:action:)
            )) { store in
              WithViewStore(store, observe: { $0 }) { viewStore in
                NavigationLink(viewStore.title ?? "") {
                  FilmDetailView(
                    store: Store(
                      initialState: FilmDetailFeature.State(
                        filmId: viewStore.id
                      ),
                      reducer: { FilmDetailFeature() }
                    )
                  )
                }
              }
            }
          }
        } else {
          VStack {
            Image(systemName: "questionmark.diamond.fill")
              .padding(.init(top: 0, leading: 0, bottom: 8, trailing: 0))
            Text("No FilmData.")
          }
        }
      }.onAppear {
        if !viewStore.state.isInitialized {
          store.send(.onAppear)
        }
      }
    })
  }
}

public struct MovieListView_Previews: PreviewProvider {
  public static var previews: some View {
    MovieListView(
      store: Store(
        initialState: MovieListFeature.State(
          isInitialized: true,
          isLoading: false,
          filmList: IdentifiedArray(
            uniqueElements: MockData.filmListResponse
          )
        ),
        reducer: { MovieListFeature() }
      )
    )
  }
}
