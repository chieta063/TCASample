import ComposableArchitecture
import Foundation

struct StackNavigationRootFeature: Reducer {
  struct State {
    var path = StackState<Path.State>()
  }
  
  enum Action {
    case path(StackAction<Path.State, Path.Action>)
  }
  
  var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case let .path(.element(_, action)):
        switch action {
        case .secondStack(.popToRoute):
          state.path.removeAll()
          return .none
        }
      default:
        return .none
      }
    }
    .forEach(\.path, action: /Action.path) {
      Path()
    }
  }
  
  struct Path: Reducer {
    enum State {
      case firstStack(FirstStackFeature.State)
      case secondStack(SecondStackFeature.State)
    }
    enum Action {
      case firstStack(FirstStackFeature.Action)
      case secondStack(SecondStackFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
      Scope(state: /State.firstStack, action: /Action.firstStack) {
        FirstStackFeature()
      }
    }
  }
}
