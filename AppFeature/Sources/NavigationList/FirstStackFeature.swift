import ComposableArchitecture
import Foundation

public struct FirstStackFeature: Reducer {
  public struct State {}
  
  public enum Action {}
  
  public var body: some ReducerOf<Self> {
    Reduce { _, _ in
        .none
    }
  }
}
