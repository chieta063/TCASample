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
final class StarwarsDictionaryViewTests: XCTestCase {
  override class func setUp() {
    isRecording = false
  }

  func testSnapshotLoading() {
    let view = StarwarsDictionaryView_Previews.previews as! StarwarsDictionaryView
    view.store.send(.onAppear)
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotDataLoaded() {
    let view = StarwarsDictionaryView_Previews.previews as! StarwarsDictionaryView
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotEmpty() {
    let view = StarwarsDictionaryView(store: Store(initialState: StarwarsDictionaryFeature.State(), reducer: {
      StarwarsDictionaryFeature()
    }))
    view.store.send(.onLoadEnd([]))
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
}
