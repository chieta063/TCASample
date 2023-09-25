import ComposableArchitecture
import Foundation

public struct SecondTreeFeature: Reducer {
  public struct State: Equatable {
    public init() {}
  }

  public enum Action: Equatable {
    case dismiss
  }

  @Dependency(\.dismiss) var dismiss

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { _, action in
      switch action {
      case .dismiss:
        return .run { _ in
          await dismiss()
        }
      }
    }
  }
}
