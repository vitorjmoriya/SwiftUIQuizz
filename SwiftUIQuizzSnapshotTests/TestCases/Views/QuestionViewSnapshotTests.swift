//
//  QuestionViewSnapshotTests.swift
//  SwiftUIQuizzSnapshotTests
//
//  Created by Vitor Jundi Moriya on 26/05/22.
//

import SnapshotTesting
import XCTest
import SwiftUI

@testable import SwiftUIQuizz
class QuestionViewSnapshotTests: XCTestCase {
  func testQuestionViewMultiple() {
      let question = Question(
        category: .scienceMathematics,
        type: .multiple,
        difficulty: "easy",
        question: "1 + 1 = ?",
        correct_answer: "2",
        incorrect_answers: ["1", "3", "4"]
      )
      Manager.API.shared.questions.append(question)
      let view = Views.QuestionView.init(viewModel: .init())
      view.viewModel.update(question: question, canShuffle: false)
      view.isAnimating = false
      let controller = UIHostingController(rootView: view)
      assertSnapshot(matching: controller, as: .image(on: .iPhoneXsMax), record: false)
  }
}
