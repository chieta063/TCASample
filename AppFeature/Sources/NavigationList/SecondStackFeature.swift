import ComposableArchitecture
import Foundation

public struct SecondStackFeature: Reducer {
  
  public struct State: Equatable {
    public init() {}
  }
  
  public enum Action: Equatable {
    case popToRoute
  }
  
  public init() {}
  
  public var body: some ReducerOf<Self> {
    Reduce { _, _ in
        .none
    }
  }
}
