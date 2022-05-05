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
        }

        private let urlString = "https://opentdb.com/api.php?amount=10&type=multiple"

        // MARK: Using Async/Await
        func fetchQuestions() async throws -> [Question] {
            guard let url = URL(string: urlString) else { throw QuestionError.badURL }
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
