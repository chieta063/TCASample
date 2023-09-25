import ComposableArchitecture
import SwiftUI

public struct TreeNavigationRootView: View {
  let store: StoreOf<TreeNavigationRootFeature>
  public var body: some View {
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

public struct TreeNavigationRootView_Previews: PreviewProvider {
  public static var previews: some View {
    TreeNavigationRootView(
      store: Store(
        initialState: TreeNavigationRootFeature.State(),
        reducer: { TreeNavigationRootFeature() }
      )
    )
  }
}
