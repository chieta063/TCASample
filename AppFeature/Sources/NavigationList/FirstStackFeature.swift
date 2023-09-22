import ComposableArchitecture
import Foundation

struct FirstStackFeature: Reducer {
  struct State {}
  
  enum Action {}
  
  var body: some ReducerOf<Self> {
    Reduce { _, _ in
        .none
    }
  }
}
