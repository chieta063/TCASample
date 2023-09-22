import ComposableArchitecture
import SwiftUI

struct TreeNavigationRootView: View {
  let store: StoreOf<TreeNavigationRootFeature>
  var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      List {
        Text("To First View")
          .onTapGesture {
            viewStore.send(.toFirstTree)
          }
      }
    }
    .fullScreenCover(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /TreeNavigationRootFeature.Destination.State.firstTree,
      action: TreeNavigationRootFeature.Destination.Action.firstTree
    ) { store in
      FirstTreeView(store: store)
    }
  }
}

struct TreeNavigationRootView_Previews: PreviewProvider {
  static var previews: some View {
    TreeNavigationRootView(
      store: Store(
        initialState: TreeNavigationRootFeature.State(),
        reducer: { TreeNavigationRootFeature() }
      )
    )
  }
}
