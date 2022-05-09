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
                Text(viewModel.text)
                    .padding()
            }.task {
                do {
                    let questions = try await viewModel.manager.fetchQuestions()
                    viewModel.text = questions.first!.question
                } catch {
                    // TODO: Tratar na tela
                    // swiftlint:disable:next force_cast
                    let questionError = error as! Manager.API.QuestionError
                    switch questionError {
                    case .badURL:
                        viewModel.text = "bad URL "
                    case .badResponse:
                        viewModel.text = "DEU RESPOSTA RUIM"
                    case .noData:
                        viewModel.text = "404"
                    case .decodingError:
                        viewModel.text = "QUEBRARAM API"
                    case .invalidCategory:
                        viewModel.text = "Categoria Inválida"
                    }
                }
            }
        }
    }
}

extension Views.QuestionView {
    class ViewModel: ObservableObject {
        let manager = Manager.API()

        @Published var text: String

        init(text: String = "Lorem Ipsum") {
            self.text = text
        }
    }
}

#if DEBUG
struct QuestionView_Previews: PreviewProvider {
    static var previews: some View {
        Views.QuestionView(viewModel: .init())
    }
}
#endif
