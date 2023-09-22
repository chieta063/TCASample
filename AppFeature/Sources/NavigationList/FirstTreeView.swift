import SwiftUI
import ComposableArchitecture

struct FirstTreeView: View {
  let store: StoreOf<FirstTreeFeature>
  
  var body: some View {
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

struct FIrstTreeView_Previews: PreviewProvider {
  static var previews: some View {
    FirstTreeView(store: Store(initialState: FirstTreeFeature.State(), reducer: {
      FirstTreeFeature()
    }))
  }
}
