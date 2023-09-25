import Foundation
import ComposableArchitecture

public struct CounterFeature: Reducer {
  public struct State: Equatable {
    var count = 0
    var fact: String?
    var isLoading = false
    var isTimerRunning = false
    
    public init(count: Int = 0, fact: String? = nil, isLoading: Bool = false, isTimerRunning: Bool = false) {
      self.count = count
      self.fact = fact
      self.isLoading = isLoading
      self.isTimerRunning = isTimerRunning
    }
  }
  
  public enum Action: Equatable {
    case decrementButtonTapped
    case factButtonTapped
    case factResponse(String)
    case incrementButtonTapped
    case timerTick
    case toggleTimerButtonTapped
  }
  
  public enum CancelID {
    case timer
  }
  
  @Dependency(\.continuousClock) var clock
  @Dependency(\.numberFact) var numberFact
  
  public init() {}
  
  public func reduce(into state: inout State, action: Action) -> Effect<Action> {
    switch action {
    case .decrementButtonTapped:
      state.count -= 1
      return .none
    case .factButtonTapped:
      state.fact = nil
      state.isLoading = true
      return .run { [count = state.count] send in
        try await send(.factResponse(self.numberFact.fetch(count)))
      }
    case let .factResponse(fact):
      state.fact = fact
      state.isLoading = false
      return .none
    case .incrementButtonTapped:
      state.count += 1
      state.fact = nil
      return .none
    case .timerTick:
      state.count += 1
      state.fact = nil
      return .none
    case .toggleTimerButtonTapped:
      state.isTimerRunning.toggle()
      if state.isTimerRunning {
        return .run { send in
          for await _ in self.clock.timer(interval: .seconds(1)) {
            await send(.timerTick)
          }
        }
        .cancellable(id: CancelID.timer)
      } else {
        return .cancel(id: CancelID.timer)
      }
    }
  }
}
