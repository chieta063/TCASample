//
//  FilmDetailViewTests.swift
//  StarwarsDictionaryTests
//
//  Created by 阿部紘明 on 2023/08/29.
//

import XCTest
@testable import MovieList
import SnapshotTesting
import SwiftUI

@MainActor
final class FilmDetailViewTests: XCTestCase {
  override class func setUp() {
    isRecording = false
  }
  
  func testSnapshotLoading() {
    let view = FilmDetailView_Previews.previews as! FilmDetailView
    view.store.send(.onAppear(UUID().uuidString))
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
  
  func testSnapshotExistData() {
    let view = FilmDetailView_Previews.previews as! FilmDetailView
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
  
  func testSnapshotLoadDataFailure() {
    let view = FilmDetailView_Previews.previews as! FilmDetailView
    view.store.send(.loadFilmFailure(.filmNotFound))
    assertSnapshot(
      matching: UIHostingController(rootView: view),
      as: .image(on: .iPhone13Pro),
      named: "Default"
    )
  }
}
