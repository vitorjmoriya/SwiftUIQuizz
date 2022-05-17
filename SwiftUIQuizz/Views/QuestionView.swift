//
//  QuestionView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 04/05/22.
//

import SwiftUI
import LottieSwiftUI

extension Views {
    struct QuestionView: View {
        @ObservedObject var viewModel: ViewModel
        @State var isAnimating: Bool = false
        @State var currentQuestion: Int = 0 {
            didSet {
                viewModel.update(question: Manager.API.shared.questions[currentQuestion])
                isAnimating = false
            }
        }

        var body: some View {
            ZStack {
                Color(red: 132/255, green: 196/255, blue: 164/255).edgesIgnoringSafeArea(.all)
                if viewModel.answers.count == 0 {
                    VStack {
                        Text(viewModel.title)
                        viewModel.image
                        Text(viewModel.question)
                        ForEach(0 ..< 3) { _ in Button(isAnimating: $isAnimating, isCorrect: false, buttonText: "") }
                    }
                    .redacted(reason: .placeholder)
                } else {
                    VStack {
                        Text(viewModel.title)
                        viewModel.image
                        Text(viewModel.question)
                        ForEach(viewModel.answers.indices) { index in
                            Button(isAnimating: $isAnimating,
                                   isCorrect: viewModel.checkIfRightAnswer(
                                        questionNumber: currentQuestion,
                                        index: index
                                   ),
                                   buttonText: viewModel.answers[index]
                            )
                        }
                        SwiftUI.Button(action: { currentQuestion += 1 }) {
                            Text("Next Question")
                        }
                    }
                    .padding()
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
        @Published var answers: [String] = []

        public func checkIfRightAnswer(questionNumber: Int, index: Int) -> Bool {
            return answers[index] == Manager.API.shared.questions[questionNumber].correct_answer
        }

        public func update(question: Manager.API.Question) {
            self.title = question.category
            self.question = question.question
            self.answers.removeAll()
            self.answers.append(question.correct_answer)
            question.incorrect_answers.forEach {
                self.answers.append($0)
            }
            self.answers.shuffle()
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
