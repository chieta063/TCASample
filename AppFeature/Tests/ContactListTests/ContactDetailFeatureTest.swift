//
//  ContactDetailFeatureTest.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/25.
//

import ComposableArchitecture
@testable import ContactList
import XCTest

@MainActor
final class ContactDetailFeatureTest: XCTestCase {
  /// 削除ボタン押下時にアラート表示イベントが発行されること
  func testDeleteButtonTapFlow() async {
    let store = TestStore(
      initialState: ContactDetailFeature.State(
        contact: .init(id: UUID(), name: "Blob Jr.")
      )
    ) {
      ContactDetailFeature()
    }
    await store.send(.deleteButtonTapped) {
      $0.destination = .alert(
        .deleteConfirmation(id: $0.contact.id)
      )
    }
  }

  /// 連絡先削除の承認時にDelegateが発行されること
  func testConfirmDeletion() async {
    let store = TestStore(
      initialState: ContactDetailFeature.State(
        contact: .init(id: UUID(), name: "Blob Jr.")
      )
    ) {
      ContactDetailFeature()
    } withDependencies: { dependency in
      dependency.dismiss = DismissEffect {}
    }
    await store.send(.destination(
      .presented(
        .alert(.confirmDeletion(id: store.state.contact.id))
      )
    ))
    await store.receive(
      .delegate(.deleteContact(id: store.state.contact.id))
    )
  }
}
