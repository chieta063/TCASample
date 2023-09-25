import ComposableArchitecture
import SwiftUI

public struct FirstStackView: View {
  let store: StoreOf<FirstStackFeature>
  
  public init(store: StoreOf<FirstStackFeature>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationLink(
      "To Second View",
      state: StackNavigationRootFeature.Path.State.secondStack(.init())
    )
  }
}

public struct FirstStackView_Previews: PreviewProvider {
  public static var previews: some View {
    FirstStackView(
      store: Store(
        initialState: FirstStackFeature.State(),
        reducer: {
          FirstStackFeature()
        }
      )
    )
  }
}
