import Foundation
import ComposableArchitecture

public struct NavigationListFeature: Reducer {
  public struct State {
    @PresentationState var destination: Destination.State?
    
    public init(destination: Destination.State? = nil) {
      self.destination = destination
    }
  }
  
  public enum Action {
    case destination(PresentationAction<Destination.Action>)
    case stackNavigationRoot
    case treeNavigationRoot
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { state, action in
      switch action {
      case .destination(_):
        return .none
      case .stackNavigationRoot:
        state.destination = .stackNavigationRoot(.init())
        return .none
      case .treeNavigationRoot:
        state.destination = .treeNavigationRoot(.init())
        return .none
      }
    }
    .ifLet(\.$destination, action: /Action.destination) {
      Destination()
    }
  }
}


extension NavigationListFeature {
  public struct Destination: Reducer {
    public enum State {
      case stackNavigationRoot(StackNavigationRootFeature.State)
      case treeNavigationRoot(TreeNavigationRootFeature.State)
    }
    
    public enum Action {
      case stackNavigationRoot(StackNavigationRootFeature.Action)
      case treeNavigationRoot(TreeNavigationRootFeature.Action)
    }
    
    public var body: some ReducerOf<Self> {
      Scope(state: /State.stackNavigationRoot, action: /Action.stackNavigationRoot) {
        StackNavigationRootFeature()
          ._printChanges()
      }
      Scope(state: /State.treeNavigationRoot, action: /Action.treeNavigationRoot) {
        TreeNavigationRootFeature()
          ._printChanges()
      }
    }
  }
}
