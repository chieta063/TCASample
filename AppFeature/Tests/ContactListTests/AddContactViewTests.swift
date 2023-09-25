//
//  AddContactViewTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/28.
//

@testable import ContactList
import SnapshotTesting
import SwiftUI
import XCTest

@MainActor
final class AddContactViewTests: XCTestCase {
  override class func setUp() {
    isRecording = false
  }

  func testSnapshotDefault() {
    let view = AddContactView_Previews.previews
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotSetName() {
    let view = AddContactView_Previews.previews as! AddContactView
    view.store.send(.setName("Blob Jr."))
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
}
