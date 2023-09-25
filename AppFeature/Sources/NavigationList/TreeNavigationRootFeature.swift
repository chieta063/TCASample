import ComposableArchitecture
import Foundation

public struct TreeNavigationRootFeature: Reducer {
  public struct State: Equatable {
    @PresentationState var destination: Destination.State?
  }
  
  public enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case toFirstTree
  }
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination(_):
        return .none
      case .toFirstTree:
        state.destination = .firstTree(.init())
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}

extension TreeNavigationRootFeature {
  public struct Destination: Reducer {
    public enum State: Equatable {
      case firstTree(FirstTreeFeature.State)
    }
    
    public enum Action: Equatable {
      case firstTree(FirstTreeFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
      Scope(state: /State.firstTree, action: /Action.firstTree) {
        FirstTreeFeature()
      }
    }
  }
}
