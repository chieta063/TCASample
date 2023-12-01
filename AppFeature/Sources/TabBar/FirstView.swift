import SwiftUI
import ComposableArchitecture

public struct FirstView: View {
  public let store: StoreOf<FirstFeature>
  public var body: some View {
    WithViewStore(store, observe: {$0}) { viewStore in
      Button("PUSH!") {
        viewStore.send(.onTapButton)
      }
    }
  }
}

#Preview {
  FirstView(store: Store(initialState: FirstFeature.State(), reducer: {
    FirstFeature()
  }))
}
