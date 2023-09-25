//
//  ContactsFeatureTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部 紘明 on 2023/07/26.
//

import ComposableArchitecture
import XCTest
@testable import ContactList

@MainActor
final class ContactsFeatureTests: XCTestCase {
  // 連絡先追加のユースケースのテスト
  func testAddFlow() async {
    let store = TestStore(initialState: ContactsFeature.State()) {
      ContactsFeature()
    } withDependencies: { dependencies in
      dependencies.uuid = .incrementing
    }
    await store.send(.addButtonTapped) {
      $0.destination = .addContact(
        AddContactFeature.State(
          contact: Contact(id: UUID(0), name: "")
        )
      )
    }
    await store.send(.destination(.presented(.addContact(.setName("Blob Jr."))))) {
      $0.$destination[
        case: /ContactsFeature.Destination.State.addContact
      ]?.contact.name = "Blob Jr."
    }
    await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
    await store.receive(
      .destination(
        .presented(.addContact(.delegate(
          .saveContact(Contact(id: UUID(0), name: "Blob Jr."))))
        )
      )
    ) {
      $0.contacts = [
        Contact(id: UUID(0), name: "Blob Jr.")
      ]
    }
    await store.receive(.destination(.dismiss)) {
      $0.destination = nil
    }
  }
  
  // 状態の変化を考慮しない非網羅的なテスト
  func testAddFlow_NonExhaustive() async {
    let store = TestStore(initialState: ContactsFeature.State()) {
      ContactsFeature()
    } withDependencies: { dependencies in
      dependencies.uuid = .incrementing
    }
    store.exhaustivity = .off
    
    await store.send(.addButtonTapped)
    await store.send(.destination(.presented(.addContact(.setName("Blob Jr.")))))
    await store.send(.destination(.presented(.addContact(.saveButtonTapped))))
    await store.skipReceivedActions()
    store.assert { state in
      state.contacts = [Contact(id: UUID(00000000-0000-0000-0000-000000000000), name: "Blob Jr.")]
      state.destination = nil
    }
  }
  
//  // 連絡先の削除テスト
//  func testDeleteContact() async {
//    let store = TestStore(
//      initialState: ContactsFeature.State(
//        contacts: [
//          Contact(id: UUID(0), name: "Blob"),
//          Contact(id: UUID(1), name: "Blob Jr."),
//        ]
//      )
//    ) {
//      ContactsFeature()
//    }
//
//    await store.send(.deleteButtonTapped(id: UUID(1))) {
//      $0.destination = .alert(.deleteConfirmation(id: UUID(1)))
//    }
//    await store.send(.destination(.presented(.alert(.confirmDeletion(id: UUID(1)))))) {
//      $0.contacts.remove(id: UUID(1))
//      $0.destination = nil
//    }
//  }
}

