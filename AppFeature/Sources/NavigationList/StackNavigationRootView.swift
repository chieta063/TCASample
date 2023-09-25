import ComposableArchitecture
import SwiftUI

public struct StackNavigationRootView: View {
  let store: StoreOf<StackNavigationRootFeature>
  
  public init(store: StoreOf<StackNavigationRootFeature>) {
    self.store = store
  }
  
  public var body: some View {
    NavigationStackStore(store.scope(state: \.path, action: { .path($0) })) {
      NavigationLink("To First Stack", state: StackNavigationRootFeature.Path.State.firstStack(.init()))
    } destination: { store in
      switch store {
      case .firstStack:
        CaseLet(
          /StackNavigationRootFeature.Path.State.firstStack,
           action: StackNavigationRootFeature.Path.Action.firstStack,
           then: FirstStackView.init(store:)
        )
      case .secondStack:
        CaseLet(
          /StackNavigationRootFeature.Path.State.secondStack,
           action: StackNavigationRootFeature.Path.Action.secondStack,
           then: SecondStackView.init(store:)
        )
      }
    }
  }
}

public struct StackNavigationRootView_Previews: PreviewProvider {
  public static var previews: some View {
    StackNavigationRootView(
      store: Store(
        initialState: StackNavigationRootFeature.State(),
        reducer: {
          StackNavigationRootFeature()
        }
      )
    )
  }
}
