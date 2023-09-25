import ComposableArchitecture
import SwiftUI

public struct CounterView: View {
  let store: StoreOf<CounterFeature>

  public init(store: StoreOf<CounterFeature>) {
    self.store = store
  }

  public var body: some View {
    WithViewStore(store, observe: { $0 }) { viewStore in
      VStack {
        Text("\(viewStore.count)")
          .font(.largeTitle)
          .padding()
          .background(Color.black.opacity(0.1))
          .cornerRadius(10)

        HStack {
          Button("-") {
            viewStore.send(.decrementButtonTapped)
          }
          .font(.largeTitle)
          .padding()
          .background(Color.black.opacity(0.1))
          .cornerRadius(10)

          Button("+") {
            viewStore.send(.incrementButtonTapped)
          }
          .font(.largeTitle)
          .padding()
          .background(Color.black.opacity(0.1))
          .cornerRadius(10)
        }

        Button(viewStore.isTimerRunning ? "Stop timer" : "Start timer") {
          viewStore.send(.toggleTimerButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)

        Button("Fact") {
          viewStore.send(.factButtonTapped)
        }
        .font(.largeTitle)
        .padding()
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)

        if viewStore.isLoading {
          ProgressView()
        } else if let fact = viewStore.fact {
          Text(fact)
            .font(.largeTitle)
            .multilineTextAlignment(.center)
            .padding()
        }
      }
    }
  }
}

public struct CounterView_Previews: PreviewProvider {
  public static var previews: some View {
    CounterView(
      store: Store(
        initialState: CounterFeature.State(),
        reducer: {
          CounterFeature()
        }
      )
    )
  }
}
