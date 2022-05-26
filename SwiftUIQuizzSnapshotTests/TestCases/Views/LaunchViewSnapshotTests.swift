//
//  LaunchViewSnapshotTests.swift
//  SwiftUIQuizzSnapshotTests
//
//  Created by Vitor Jundi Moriya on 26/05/22.
//

import SnapshotTesting
import XCTest
import SwiftUI

@testable import SwiftUIQuizz
class LaunchViewSnapshotTests: XCTestCase {
  func testLaunchIcon() {
      let controller = UIHostingController(rootView: Views.LaunchView(isLoading: true))
      assertSnapshot(matching: controller, as: .image(on: .iPhoneXsMax), record: false)
  }
}
