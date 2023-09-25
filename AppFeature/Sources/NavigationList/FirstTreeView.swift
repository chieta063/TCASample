import SwiftUI
import ComposableArchitecture

public struct FirstTreeView: View {
  let store: StoreOf<FirstTreeFeature>
  
  public var body: some View {
    WithViewStore(store, observe: {$0}) { viewStore in
      List {
        Text("To Second View")
          .onTapGesture {
            viewStore.send(.toSecondTree)
          }
        Text("Dismiss")
          .onTapGesture {
            viewStore.send(.dismiss)
          }
      }
    }
    .fullScreenCover(
      store: store.scope(state: \.$destination, action: {.destination($0)}),
      state: /FirstTreeFeature.Destination.State.secondTree,
      action: FirstTreeFeature.Destination.Action.secondTree) { store in
        SecondTreeView(store: store)
      }
  }
}

public struct FirstTreeView_Previews: PreviewProvider {
  public static var previews: some View {
    FirstTreeView(store: Store(initialState: FirstTreeFeature.State(), reducer: {
      FirstTreeFeature()
    }))
  }
}
