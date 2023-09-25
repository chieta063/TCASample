//
//  ContactListViewTest.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/28.
//

import ComposableArchitecture
@testable import ContactList
import SnapshotTesting
import SwiftUI
import XCTest

@MainActor
final class ContactListViewTest: XCTestCase {
  override class func setUp() {
    isRecording = false
  }

  func testSnapshotEmpty() {
    let view = ContactListView_Preview.previews

    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }

  func testSnapshotExistData() {
    let view = ContactListView_Preview.previews as! ContactListView

    view.store.send(.addButtonTapped)

    view.store.send(
      .destination(
        .presented(
          .addContact(
            .delegate(
              .saveContact(.init(id: UUID(), name: "Blob Jr."))
            )
          )
        )
      )
    )

    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
}
