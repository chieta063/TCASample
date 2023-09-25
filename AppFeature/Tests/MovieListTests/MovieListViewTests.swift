//
//  StarwarsDictionaryViewTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/29.
//

import ComposableArchitecture
@testable import MovieList
import SnapshotTesting
import SwiftUI
import XCTest

@MainActor
final class MovieListViewTests: XCTestCase {
  override class func setUp() {
    isRecording = false
  }

  func testSnapshotLoading() {
    let view = MovieListView_Previews.previews as! MovieListView
    view.store.send(.onAppear)
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotDataLoaded() {
    let view = MovieListView_Previews.previews as! MovieListView
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotEmpty() {
    let view = MovieListView(store: Store(initialState: MovieListFeature.State(), reducer: {
      MovieListFeature()
    }))
    view.store.send(.onLoadEnd([]))
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
}
