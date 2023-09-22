import Foundation
import ComposableArchitecture

struct FirstTreeFeature: Reducer {
  struct State: Equatable {
    @PresentationState var destination: Destination.State?
  }
  
  enum Action: Equatable {
    case destination(PresentationAction<Destination.Action>)
    case toSecondTree
    case dismiss
  }
  
  @Dependency(\.dismiss) var dismiss
  
  var body: some ReducerOf<Self> {
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
  struct Destination: Reducer {
    enum State: Equatable {
      case secondTree(SecondTreeFeature.State)
    }
    
    enum Action: Equatable {
      case secondTree(SecondTreeFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.secondTree, action: /Action.secondTree) {
        SecondTreeFeature()
      }
    }
  }
}
