//
//  Manager.Question.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 05/05/22.
//

import Foundation

extension Manager {
    struct API {
        enum QuestionError: Error {
            case badURL
            case badResponse
            case noData
            case decodingError
            case invalidCategory
        }

        enum Difficulty: String {
            case easy
            case medium
            case hard
            case any
        }

        enum CategoryNames: String {
            case generalKnowledge = "General Knowledge"
            case entertainmentBooks = "Entertainment: Books"
            case entertainmentFilms = "Entertainment: Films"
            case entertainmentMusic = "Entertainment: Music"
        }

        private let categoryIDs: [CategoryNames: Int] = [
            .generalKnowledge: 9,
            .entertainmentBooks: 10,
            .entertainmentFilms: 11,
            .entertainmentMusic: 12
        ]

        func queryBuilder(category: CategoryNames, difficulty: Difficulty, amount: Int = 10) throws -> URL {
            guard let catID = categoryIDs[category] else {throw QuestionError.invalidCategory}
            var components = URLComponents()
            components.scheme = "https"
            components.host = "opentdb.com"
            components.path = "/api.php"
            var queryItems: [URLQueryItem] = [
                URLQueryItem(name: "amount", value: String(amount) ),
                URLQueryItem(name: "category", value: String(catID) ),
                URLQueryItem(name: "type", value: "multiple")
            ]
            if difficulty != .any {
                queryItems.append( URLQueryItem(name: "difficulty", value: difficulty.rawValue as String) )
            }

            components.queryItems = queryItems

            guard let url = components.url else { throw QuestionError.badURL }
            return url
        }

        // MARK: Using Async/Await
        func fetchQuestions() async throws -> [Question] {
            let url = try queryBuilder(category: .generalKnowledge, difficulty: .medium, amount: 10)

            let session = URLSession(configuration: .ephemeral)
            let (data, response) = try await(session.data(from: url))
            guard let response = response as? HTTPURLResponse else { throw QuestionError.badResponse }
            guard response.statusCode == 200 else { throw QuestionError.badResponse }
            let result = try JSONDecoder().decode(Response.self, from: data)
            return result.results
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
