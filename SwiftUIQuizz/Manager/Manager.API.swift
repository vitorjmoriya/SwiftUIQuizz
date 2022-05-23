//
//  Manager.API.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 05/05/22.
//

import Foundation
import SwiftUI

extension Manager {
    struct API {
        public static var shared = Manager.API()
        var questions: [Question] = []

        enum QuestionError: Error {
            case badURL
            case badResponse
            case noData
            case decodingError
            case invalidCategory
        }

        enum Difficulty: String, CaseIterable {
            case any
            case easy
            case medium
            case hard
        }

        enum CategoryNames: String, CaseIterable {
            case all = "All"
            case generalKnowledge = "General Knowledge"
            case entertainmentBooks = "Entertainment: Books"
            case entertainmentFilms = "Entertainment: Films"
            case entertainmentMusic = "Entertainment: Music"
            case entertainmentMusicalsAndTheatres = "Entertainment: Musicals & Theatres"
            case entertainmentTelevision = "Entertainment: Television"
            case entertainmentVideoGames = "Entertainment: Video Games"
            case entertainmentBoardGames = "Entertainment: Board Games"
            case scienceAndNature = "Science & Nature"
            case scienceComputers = "Science: Computers"
            case scienceMathematics = "Science: Mathematics"
            case mythology = "Mythology"
            case sports = "Sports"
            case geography = "Geography"
            case history = "History"
            case politics = "Politics"
            case art = "Art"
            case celebrities = "Celebrities"
            case animals = "Animals"
            case vehicles = "Vehicles"
            case entertainmentComics = "Entertainment: Comics"
            case scienceGadgets = "Science: Gadgets"
            case entertainmentAnimeAndMaga = "Entertainment: Japanese Anime & Manga"
            case entertainmentCartoonAndAnimations = "Entertainment: Cartoon & Animations"
        }

        enum AnswerTypes: String, CaseIterable {
            case any = "Both"
            case multi = "multiple"
            case rightWrong = "boolean"
        }

        private let categoryIDs: [CategoryNames: Int] = [
            .generalKnowledge: 9,
            .entertainmentBooks: 10,
            .entertainmentFilms: 11,
            .entertainmentMusic: 12,
            .entertainmentMusicalsAndTheatres: 13,
            .entertainmentTelevision: 14,
            .entertainmentVideoGames: 15,
            .entertainmentBoardGames: 16,
            .scienceAndNature: 17,
            .scienceComputers: 18,
            .scienceMathematics: 19,
            .mythology: 20,
            .sports: 21,
            .geography: 22,
            .history: 23,
            .politics: 24,
            .art: 25,
            .celebrities: 26,
            .animals: 27,
            .vehicles: 28,
            .entertainmentComics: 29,
            .scienceGadgets: 30,
            .entertainmentAnimeAndMaga: 31,
            .entertainmentCartoonAndAnimations: 32
        ]

        func queryBuilder(category: CategoryNames, difficulty: Difficulty, amount: Int = 10) throws -> URL {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "opentdb.com"
            components.path = "/api.php"

            var queryItems: [URLQueryItem] = [
                URLQueryItem(name: "amount", value: String(amount) ),
            ]

            if category != .all {
                guard let catID = categoryIDs[category] else { throw QuestionError.invalidCategory }
                queryItems.append(URLQueryItem(name: "category", value: String(catID)))
            }

            if difficulty != .any {
                queryItems.append(URLQueryItem(name: "difficulty", value: difficulty.rawValue as String))
            }

            components.queryItems = queryItems
            guard let url = components.url else { throw QuestionError.badURL }
            return url
        }

        mutating func fetchQuestions(category: CategoryNames,
                                     difficulty: Difficulty,
                                     amount: Int = 10) async throws -> [Question] {
            let url = try queryBuilder(category: category, difficulty: difficulty, amount: amount)
            let session = URLSession(configuration: .ephemeral)
            let (data, response) = try await(session.data(from: url))
            guard let response = response as? HTTPURLResponse else { throw QuestionError.badResponse }
            guard response.statusCode == 200 else { throw QuestionError.badResponse }
            let result = try JSONDecoder().decode(Response.self, from: data)
            let questions = Manager.API.parseResponse(questions: result.results)
            self.questions = questions
            return questions
        }

        static func parseResponse(questions: [Manager.API.Question]) -> [Manager.API.Question] {
            return questions.map { question in
                return Manager.API.Question(
                    category: question.category.html2String,
                    type: question.type,
                    difficulty: question.difficulty,
                    question: question.question.html2String,
                    correct_answer: question.correct_answer.html2String,
                    incorrect_answers: question.incorrect_answers.map { answer in
                        return answer.html2String
                    }
                )
            }
        }
    }
}

// swiftlint:disable:all identifier_name
extension Manager.API {
    struct Response: Codable {
        let response_code: Int
        let results: [Question]
    }

    struct Question: Codable {
        let category: String
        let type: String
        let difficulty: String
        let question: String
        let correct_answer: String
        let incorrect_answers: [String]
    }
}
