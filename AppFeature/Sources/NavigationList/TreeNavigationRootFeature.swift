import ComposableArchitecture
import Foundation

struct TreeNavigationRootFeature: Reducer {
  struct State: Equatable {
    @PresentationState var destination: Destination.State?
  }
  
  enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case toFirstTree
  }
  
  var body: some ReducerOf<Self> {
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
  struct Destination: Reducer {
    enum State: Equatable {
      case firstTree(FirstTreeFeature.State)
    }
    
    enum Action: Equatable {
      case firstTree(FirstTreeFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.firstTree, action: /Action.firstTree) {
        FirstTreeFeature()
      }
    }
  }
}
