import ComposableArchitecture
import Foundation

public struct FirstTreeFeature: Reducer {
  public struct State: Equatable {
    @PresentationState var destination: Destination.State?

    public init(destination: Destination.State? = nil) {
      self.destination = destination
    }
  }

  public enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case toSecondTree
    case dismiss
  }

  @Dependency(\.dismiss) var dismiss

  public init() {}

  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination:
        return .none
      case .toSecondTree:
        state.destination = .secondTree(.init())
        return .none
      case .dismiss:
        return .run { _ in
          await dismiss()
        }
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}

public extension FirstTreeFeature {
  struct Destination: Reducer {
    public enum State: Equatable {
      case secondTree(SecondTreeFeature.State)
    }

    public enum Action: Equatable {
      case secondTree(SecondTreeFeature.Action)
    }

    public var body: some ReducerOf<Self> {
      Scope(state: /State.secondTree, action: /Action.secondTree) {
        SecondTreeFeature()
      }
    }
  }
}
