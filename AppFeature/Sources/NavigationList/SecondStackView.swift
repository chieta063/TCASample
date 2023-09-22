import ComposableArchitecture
import SwiftUI

struct SecondStackView: View {
  let store: StoreOf<SecondStackFeature>
  
  var body: some View {
    WithViewStore(store, observe: {$0}) { viewStore in
      VStack {
        Text("Second Stack View")
        Button("PopToRoot") {
          viewStore.send(.popToRoute)
        }
      }
    }
  }
}

struct SecondStackView_Previews: PreviewProvider {
  static var previews: some View {
    SecondStackView(
      store: Store(
        initialState: SecondStackFeature.State(),
        reducer: {
          SecondStackFeature()
        }
      )
    )
  }
}
