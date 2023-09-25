//
//  CounterFeatureTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部 紘明 on 2023/07/25.
//

import ComposableArchitecture
import XCTest
@testable import Counter

@MainActor
final class CounterFeatureTests: XCTestCase {
  func testCounter() async {
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    } withDependencies: { dependency in
      dependency.continuousClock = ContinuousClock()
    }
    // カウントのテスト
    await store.send(.incrementButtonTapped) {
      // countが1であること
      $0.count = 1
    }
    await store.send(.decrementButtonTapped) {
      $0.count = 0
    }
    // 時間カウントのテスト
    await store.send(.toggleTimerButtonTapped) {
      $0.isTimerRunning = true
    }
    // 2秒待機してActionの発行を待機する
    await store.receive(.timerTick, timeout: .seconds(2)) {
      $0.count = 1
    }
    await store.send(.toggleTimerButtonTapped) {
      $0.isTimerRunning = false
    }
  }
  
  func testNumberFact() async {
    let store = TestStore(initialState: CounterFeature.State()) {
      CounterFeature()
    } withDependencies: { dependencies in
      // ここで通信の結果をMockする
      dependencies.numberFact.fetch = {"\($0) is a good number."}
    }
    await store.send(.factButtonTapped) {
      $0.isLoading = true
    }
    await store.receive(.factResponse("0 is a good number.")) {
      $0.isLoading = false
      $0.fact = "0 is a good number."
    }
  }
}
