import ComposableArchitecture
import SwiftUI

public struct SecondStackView: View {
  let store: StoreOf<SecondStackFeature>
  
  public init(store: StoreOf<SecondStackFeature>) {
    self.store = store
  }
  
  public var body: some View {
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

public struct SecondStackView_Previews: PreviewProvider {
  public static var previews: some View {
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
