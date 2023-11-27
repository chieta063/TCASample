//
//  StarwarsDictionaryFeatureTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/23.
//

import ComposableArchitecture
@testable import MovieList
import MovieListMock
import MovieListSchema
import XCTest

@MainActor
final class MovieListFeatureTests: XCTestCase {
  /// 画面表示時の読み込みが正常に処理されること
  func testInitialLoadFlow() async {
    let store = TestStore(
      initialState: MovieListFeature.State()
    ) {
      MovieListFeature()
    } withDependencies: { dependency in
      dependency.starwarsClient = StarwarsClient.testValue
    }
    await store.send(.onAppear) {
      $0.isLoading = true
    }
    let response = IdentifiedArray(uniqueElements: MockData.filmListResponse)
    await store.receive(.onLoadEnd(response)) {
      $0.filmList = response
      $0.isLoading = false
      $0.isInitialized = true
    }
  }
}
