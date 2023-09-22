import ComposableArchitecture
import SwiftUI

struct FirstStackView: View {
  let store: StoreOf<FirstStackFeature>
  
  var body: some View {
    NavigationLink(
      "To Second View",
      state: StackNavigationRootFeature.Path.State.secondStack(.init())
    )
  }
}

struct FirstStackView_Previews: PreviewProvider {
  static var previews: some View {
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
