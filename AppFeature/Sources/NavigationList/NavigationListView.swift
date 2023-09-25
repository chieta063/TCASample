import ComposableArchitecture
import SwiftUI

public struct NavigationListView: View {
  let store: StoreOf<NavigationListFeature>
  
  public init(store: StoreOf<NavigationListFeature>) {
    self.store = store
  }
  
  public var body: some View {
    List {
      Text("Stack-based-Navigation")
        .onTapGesture {
          store.send(.stackNavigationRoot)
        }
      Text("Tree-based-Navigation")
        .onTapGesture {
          store.send(.treeNavigationRoot)
        }
    }
    .fullScreenCover(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /NavigationListFeature.Destination.State.stackNavigationRoot,
      action: NavigationListFeature.Destination.Action.stackNavigationRoot
    ) { store in
      StackNavigationRootView(store: store)
    }
    .fullScreenCover(
      store: store.scope(state: \.$destination, action: { .destination($0) }),
      state: /NavigationListFeature.Destination.State.treeNavigationRoot,
      action: NavigationListFeature.Destination.Action.treeNavigationRoot
    ) { store in
      TreeNavigationRootView(store: store)
    }
  }
}

public struct NavigationListView_Previews: PreviewProvider {
  public static var previews: some View {
    NavigationListView(
      store: Store(
        initialState: NavigationListFeature.State(),
        reducer: { NavigationListFeature() }
      )
    )
  }
}
