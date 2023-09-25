//
//  CounterViewTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/25.
//

import ComposableArchitecture
@testable import Counter
@testable import SnapshotTesting
import SwiftUI
import XCTest

@MainActor
final class CounterViewTests: XCTestCase {
  override class func setUp() {
    isRecording = false
  }

  func testSnapshotDefault() {
    let view = CounterView_Previews.previews as! CounterView

    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotLoading() {
    let view = CounterView_Previews.previews as! CounterView
    view.store.send(.factButtonTapped)

    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotFactLoaded() {
    let view = CounterView_Previews.previews as! CounterView
    view.store.send(.factResponse("0 is the atomic number of the theoretical element tetraneutron."))

    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
}
