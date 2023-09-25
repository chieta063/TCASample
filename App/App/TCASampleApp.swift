import ComposableArchitecture
import FeatureList
import SwiftUI

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
