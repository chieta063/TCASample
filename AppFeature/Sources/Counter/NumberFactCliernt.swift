import ComposableArchitecture
import Foundation

public struct NumberFactClient {
  var fetch: (Int) async throws -> String
}

extension NumberFactClient: DependencyKey {
  public static var liveValue: NumberFactClient = Self { number in
    let (data, _) = try await URLSession.shared
      .data(from: URL(string: "http://numbersapi.com/\(number)")!)
    return String(decoding: data, as: UTF8.self)
  }

  public static var testValue: NumberFactClient = Self { _ in
    "0 is the atomic number of the theoretical element tetraneutron."
  }

  public static var previewValue: NumberFactClient = Self { _ in
    "0 is the atomic number of the theoretical element tetraneutron."
  }
}

// 依存関係をライブラリ側に登録する
extension DependencyValues {
  var numberFact: NumberFactClient {
    get { self[NumberFactClient.self] }
    set { self[NumberFactClient.self] = newValue }
  }
}
