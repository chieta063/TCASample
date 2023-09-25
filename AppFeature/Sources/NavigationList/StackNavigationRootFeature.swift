import ComposableArchitecture
import Foundation

public struct StackNavigationRootFeature: Reducer {
  public struct State {
    var path = StackState<Path.State>()
    
    public init(path: StackState<StackNavigationRootFeature.Path.State> = StackState<Path.State>()) {
      self.path = path
    }
  }
  
  public enum Action {
    case path(StackAction<Path.State, Path.Action>)
  }
  
  public var body: some ReducerOf<Self> {
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
  
  public struct Path: Reducer {
    public enum State {
      case firstStack(FirstStackFeature.State)
      case secondStack(SecondStackFeature.State)
    }
    public enum Action {
      case firstStack(FirstStackFeature.Action)
      case secondStack(SecondStackFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
      Scope(state: /State.firstStack, action: /Action.firstStack) {
        FirstStackFeature()
      }
    }
  }
}
