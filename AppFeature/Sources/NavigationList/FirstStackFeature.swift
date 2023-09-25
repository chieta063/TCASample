import ComposableArchitecture
import Foundation

public struct FirstStackFeature: Reducer {
  public struct State {
    public init() {}
  }

  public enum Action {}

  public init() {}

  public var body: some ReducerOf<Self> {
    EmptyReducer()
  }
}
