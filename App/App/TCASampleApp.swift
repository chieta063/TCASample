import SwiftUI
import FeatureList
import ComposableArchitecture

@main
struct TCASampleApp: App {
  var body: some Scene {
    WindowGroup {
      FeatureListView(store: Store(initialState: FeatureListFeature.State(), reducer: {
        FeatureListFeature()
      }))
    }
  }
}
