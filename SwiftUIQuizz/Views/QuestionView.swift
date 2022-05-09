//
//  QuestionView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 04/05/22.
//

import SwiftUI

extension Views {
    struct QuestionView: View {
        @ObservedObject var viewModel: ViewModel

        var body: some View {
            VStack {
                Text(viewModel.title)
                viewModel.image
                Text(viewModel.question)
                Text(viewModel.answer1)
                Text(viewModel.answer2)
                Text(viewModel.answer3)
                Text(viewModel.answer4)

            }.task {
                do {
                    let questions = try await viewModel.manager.fetchQuestions()
                    viewModel.title = questions[0].category
                    viewModel.question = questions[0].question
                    viewModel.answer1 = questions[0].correct_answer
                    viewModel.answer2 = questions[0].incorrect_answers[0]
                    viewModel.answer3 = questions[0].incorrect_answers[1]
                    viewModel.answer4 = questions[0].incorrect_answers[2]
                } catch {
                    // TODO: Tratar na tela
                    // swiftlint:disable:next force_cast
                    let questionError = error as! Manager.API.QuestionError
                    switch questionError {
                    case .badURL:
                        viewModel.title = "bad URL "
                    case .badResponse:
                        viewModel.title = "DEU RESPOSTA RUIM"
                    case .noData:
                        viewModel.title = "404"
                    case .decodingError:
                        viewModel.title = "QUEBRARAM API"
                    }
                }
            }
        }
    }
}

extension Views.QuestionView {
    class ViewModel: ObservableObject {
        let manager = Manager.API()

        @Published var title: String = ""
        @Published var image: Image = .init(systemName: "paperplane.fill")
        @Published var question: String = ""
        @Published var answer1: String = ""
        @Published var answer2: String = ""
        @Published var answer3: String = ""
        @Published var answer4: String = ""
    }
}

#if DEBUG
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Views.QuestionView(viewModel: .init())
    }
}
#endif
