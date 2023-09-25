//
//  ContactDetailViewTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/28.
//

import SnapshotTesting
@testable import ContactList
import SwiftUI
import XCTest

final class ContactDetailViewTests: XCTestCase {
  override class func setUp() {
    isRecording = false
  }
  
  func testSnapshotDefault() {
    let view = ContactDetailView_Previews.previews
    
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
}
