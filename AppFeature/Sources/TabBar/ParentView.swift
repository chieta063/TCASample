import SwiftUI
import ComposableArchitecture

public struct ParentView: View {
  public let store: StoreOf<ParentFeature>
  
  public init(store: StoreOf<ParentFeature>) {
    self.store = store
  }
  
  public var body: some View {
    WithViewStore(store, observe: {$0}) { viewStore in
      TabView {
        FirstView(store: store.scope(state: \.firstFeature, action: \.firstFeature))
          .tabItem {
            TabItemView(systemImageName: "folder.fill", screenName: "Home")
          }
        SecondView()
          .tabItem {
            TabItemView(systemImageName: "folder.fill", screenName: "Sub")
          }
      }
    }
  }
}

#Preview {
  ParentView(store: Store(initialState: ParentFeature.State(firstFeature: .init(), secondFeature: .init()), reducer: {
    ParentFeature()
  }))
}
