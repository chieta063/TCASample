//
//  FilmDetailFeatureTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/23.
//

import ComposableArchitecture
@testable import MovieList
import XCTest

@MainActor
final class FilmDetailFeatureTests: XCTestCase {
  /// 画面表示時の読み込みが正常に処理されること
  func testInitialLoadFLow() async {
    let store = TestStore(
      initialState: FilmDetailFeature.State(
        filmId: "cGVvcGxlOjE="
      )
    ) {
      FilmDetailFeature()
    }
    await store.send(.onAppear("cGVvcGxlOjE=")) {
      $0.isLoading = true
    }
    let response = MockData.filmDetailResponse
    await store.receive(.onFilmLoaded(response)) {
      $0.film = response
      $0.isLoading = false
    }
  }

  /// 読み込み失敗時の表示エラーが発行されること
  func testInitialLoadError() async {
    let store = TestStore(
      initialState: FilmDetailFeature.State(
        filmId: "cGVvcGxlOjE="
      )
    ) {
      FilmDetailFeature()
    }
    await store.send(.loadFilmFailure(.filmNotFound)) {
      $0.isLoading = false
      $0.displayError = .filmNotFound
    }
  }
}
