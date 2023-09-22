import Foundation
import ComposableArchitecture

struct NavigationListFeature: Reducer {
  struct State {
    @PresentationState var destination: Destination.State?
  }
  
  enum Action {
    case destination(PresentationAction<Destination.Action>)
    case stackNavigationRoot
    case treeNavigationRoot
  }
  
  var body: some ReducerOf<Self> {
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
  struct Destination: Reducer {
    enum State {
      case stackNavigationRoot(StackNavigationRootFeature.State)
      case treeNavigationRoot(TreeNavigationRootFeature.State)
    }
    
    enum Action {
      case stackNavigationRoot(StackNavigationRootFeature.Action)
      case treeNavigationRoot(TreeNavigationRootFeature.Action)
    }
    
    var body: some ReducerOf<Self> {
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
