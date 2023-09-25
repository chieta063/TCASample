import Foundation
import ComposableArchitecture

public struct FirstTreeFeature: Reducer {
  public struct State: Equatable {
    @PresentationState var destination: Destination.State?
  }
  
  public enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case toSecondTree
    case dismiss
  }
  
  @Dependency(\.dismiss) var dismiss
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination(_):
        return .none
      case .toSecondTree:
        state.destination = .secondTree(.init())
        return .none
      case .dismiss:
        return .run { send in
          await dismiss()
        }
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}


extension FirstTreeFeature {
  public struct Destination: Reducer {
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
