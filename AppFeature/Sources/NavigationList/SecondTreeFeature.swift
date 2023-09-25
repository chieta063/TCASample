import ComposableArchitecture
import Foundation

public struct SecondTreeFeature: Reducer {
  public struct State: Equatable {}
  
  public enum Action: Equatable {
    case dismiss
  }
  
  @Dependency(\.dismiss) var dismiss
  
  public var body: some ReducerOf<Self> {
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
