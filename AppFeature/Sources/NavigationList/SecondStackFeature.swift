import ComposableArchitecture
import Foundation

struct SecondStackFeature: Reducer {
  
  struct State: Equatable {}
  
  enum Action: Equatable {
    case popToRoute
  }
  
  var body: some ReducerOf<Self> {
    Reduce { _, _ in
        .none
    }
  }
}
