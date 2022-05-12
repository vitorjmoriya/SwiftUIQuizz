//
//  Manager.StoredQuestions.swift
//  SwiftUIQuizz
//
//  Created by Henrique Finger Zimerman on 12/05/22.
//

import Foundation

extension Manager {

    class QuestionStash {

        static let shared = QuestionStash()

        let fileName = "questionStash"

        private var questionMap: [String: Bool]

        private init() {
            questionMap = [:]
            guard Manager.SaveSystem.fileExists(fileName: fileName) else { return }
            do {
                questionMap = try Manager.SaveSystem.readObject(fileName: fileName)
            } catch {
                self.handleFileError(error: error)
            }
        }

        private func saveStash() {
            do {
                try Manager.SaveSystem.saveObject(object: questionMap, fileName: fileName)
            } catch {
                self.handleFileError(error: error)
            }
        }

        private func handleFileError(error: Error) {
            print(error)
        }

        func addQuestion(question: String) {
            questionMap[question] = true
            self.saveStash()
        }

        func removeQuestion(question: String) {
            questionMap[question] = false
            self.saveStash()
        }

        func checkQuestion(question: String) -> Bool {
            guard let status = questionMap[question] else { return false }
            return status
        }
    }
}
