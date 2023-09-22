import SwiftUI
import ComposableArchitecture

struct SecondTreeView: View {
  let store: StoreOf<SecondTreeFeature>
  
  var body: some View {
    WithViewStore(store, observe: {$0}) { viewStore in
      VStack {
        Text("Second Tree View")
          .padding()
        Button("Dismiss") {
          viewStore.send(.dismiss)
        }
      }
    }
  }
}

struct SecondTreeView_Previews: PreviewProvider {
  static var previews: some View {
    SecondTreeView(store: Store(initialState: SecondTreeFeature.State(), reducer: {
      SecondTreeFeature()
    }))
  }
}
