//
//  StarwarsDictionaryFeatureTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/23.
//

import XCTest
import ComposableArchitecture
@testable import MovieList
import MovieListSchema
import MovieListMock

@MainActor
final class StarwarsDictionaryFeatureTests: XCTestCase {
  /// 画面表示時の読み込みが正常に処理されること
  func testInitialLoadFlow() async {
    let store = TestStore(
      initialState: StarwarsDictionaryFeature.State()
    ) {
      StarwarsDictionaryFeature()
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
