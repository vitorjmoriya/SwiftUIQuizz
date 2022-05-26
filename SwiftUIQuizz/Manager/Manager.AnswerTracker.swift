//
//  Manager.Session.swift
//  SwiftUIQuizz
//
//  Created by Henrique Finger Zimerman on 24/05/22.
//

import Foundation

extension Manager {
    class AnswerTracker {
        public static let shared = AnswerTracker()

        var questionAmount: Int
        var correctAnswers: Int
        var wrongAnswers: Int

        private init() {
            self.questionAmount = 0
            self.correctAnswers = 0
            self.wrongAnswers = 0
        }

        func resetTracker(questionAmount: Int = 0) {
            self.questionAmount = questionAmount
            self.correctAnswers = 0
            self.wrongAnswers = 0
        }

        func addResult(answerStatus: Bool) {
            if answerStatus {
                correctAnswers += 1
            } else {
                wrongAnswers += 1
            }
        }
    }
}
