//
//  Manager.SessionManager.swift
//  SwiftUIQuizz
//
//  Created by Henrique Finger Zimerman on 26/05/22.
//

import Foundation

extension Manager {
    class SessionManager {
        public static let shared = SessionManager()
        private var questionArray: [Question] = []
        private var questionIndex: Int = 0

        var correctAnswers: Int = 0
        var wrongAnswers: Int = 0
        var questionAmount: Int = 0

        enum Errors: Error {
            case sessionEnded
        }

        private init() {
        }

        func startSession(
            category: Manager.API.QuestionCategory,
            difficulty: Manager.API.Difficulty,
            answerType: Manager.API.AnswerTypes,
            amount: Int = 10
        ) async throws -> Bool {
            questionIndex = 0
            correctAnswers = 0
            wrongAnswers = 0
            questionArray = try await Manager.API.shared.fetchQuestions(category: category,
                                                                        difficulty: difficulty,
                                                                        answerType: answerType,
                                                                        amount: amount)
            questionAmount = amount
            return true
        }

        func sessionEnded() -> Bool {
            return questionIndex >= questionArray.count
        }

        func currentQuestion() throws -> Question {
            guard !sessionEnded()
            else {
                throw Errors.sessionEnded
            }
            return questionArray[questionIndex]
        }

        func addResult(answerStatus: Bool) throws {
            guard !sessionEnded()
            else {
                throw Errors.sessionEnded
            }
            if answerStatus {
                correctAnswers += 1
            } else {
                wrongAnswers += 1
            }
            Manager.QuestionStash.shared.addQuestion(question: questionArray[questionIndex].question)
            questionIndex += 1
        }
    }
}
