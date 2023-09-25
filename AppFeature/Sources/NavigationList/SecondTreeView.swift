import SwiftUI
import ComposableArchitecture

public struct SecondTreeView: View {
  let store: StoreOf<SecondTreeFeature>
  
  public init(store: StoreOf<SecondTreeFeature>) {
    self.store = store
  }
  
  public var body: some View {
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

public struct SecondTreeView_Previews: PreviewProvider {
  public static var previews: some View {
    SecondTreeView(store: Store(initialState: SecondTreeFeature.State(), reducer: {
      SecondTreeFeature()
    }))
  }
}
