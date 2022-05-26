//
//  Manager.QuestionStash.swift
//  SwiftUIQuizz
//
//  Created by Henrique Finger Zimerman on 26/05/22.
//

import Foundation

extension Manager {
    class QuestionStash: Decodable, Encodable {
        public static var shared = QuestionStash.loadFromStorage()
        private static let fileName = "stash"
        private static let limit = 5000

        private var questionDict: [String:Bool]
        private var questionArray: [String]

        private static func loadFromStorage() -> QuestionStash {
            guard let answer: QuestionStash = try? SaveSystem.readObject(fileName: QuestionStash.fileName)
            else {
               return QuestionStash()
            }
            return answer
        }

        private init() {
            questionDict = [:]
            questionArray = []
        }

        private func saveToStorage(){
            do {
                try SaveSystem.saveObject(object: self, fileName: QuestionStash.fileName)
            } catch {
                print(error)
            }
        }

        public func isRepeatedQuestion(question: String) -> Bool {
            if questionDict[question] == nil {
                return false
            }
            return true
        }

        public func addQuestion(question: String, answerStatus: Bool = true) {
            guard questionDict[question] == nil else {return}
            questionDict[question] = answerStatus
            questionArray.append(question)
            if questionArray.count > QuestionStash.limit {
                questionDict.removeValue(forKey: questionArray[0])
                _ = questionArray.remove(at: 0)
            }
            saveToStorage()
        }
    }
}
