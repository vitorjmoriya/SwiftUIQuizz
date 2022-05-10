//
//  RequestToken.swift
//  SwiftUIQuizz
//
//  Created by Cesar Augusto Barros on 10/05/22.
//

import Foundation

class RequestToken {
    func getUserToken() async throws -> ResponseBody {
        guard let url = URL(
            string: "https://opentdb.com/api_token.php?command=request"
        ) else {
            fatalError("Missing URL")
        }

        let urlRequest = URLRequest(url: url)
        let (data, response) = try await URLSession.shared.data(for: urlRequest)

        guard (response as? HTTPURLResponse)?.statusCode == 200 else {fatalError("Error getting token")}

        let decodedData = try JSONDecoder().decode(ResponseBody.self, from: data)

        return decodedData
    }

    struct ResponseBody: Decodable {
        var responseCode: String
        var responseMessage: String
        var token: String
    }

}
