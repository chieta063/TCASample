import ComposableArchitecture
import Foundation

struct SecondTreeFeature: Reducer {
  struct State: Equatable {}
  
  enum Action: Equatable {
    case dismiss
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
    Reduce { _, action in
      switch action {
      case .dismiss:
        return .run { send in
          await dismiss()
        }
      }
    }
  }
}
