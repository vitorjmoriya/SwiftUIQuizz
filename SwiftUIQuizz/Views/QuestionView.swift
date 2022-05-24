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
                DesignSystem.Color.byCategory(category: viewModel.category).uiColor.edgesIgnoringSafeArea(.all)
                if viewModel.answers.count == 0 {
                    renderBody(answerType: .multi, isAnimating: $isAnimating)
                        .padding()
                        .redacted(reason: .placeholder)
                } else {
                    renderBody(
                        answerType: viewModel.answerType ==
                                        Manager.API.AnswerTypes.multi.rawValue ? .multi : .rightWrong,
                        isAnimating: $isAnimating
                    )
                    .padding()
                }
            }
        }

        @ViewBuilder private func renderBody(
            answerType: Manager.API.AnswerTypes,
            isAnimating: Binding<Bool>
        ) -> some View {
            VStack {
                Text(viewModel.title)
                viewModel.image
                Text(viewModel.question)
                switch answerType {
                case .multi:
                    ForEach(0 ..< 4) { index in
                        MultipleChoiceButton(
                            isAnimating: $isAnimating,
                            isCorrect: viewModel.checkIfRightAnswer(
                                questionNumber: currentQuestion,
                                index: index
                            ),
                            buttonText: viewModel.answers.count == 0 ? "" : viewModel.answers[index]
                        )
                    }
                case .rightWrong:
                        HStack {
                            BooleanButton(isAnimating: $isAnimating,
                                isCorrect: viewModel.checkBooleanQuestion(
                                    answer: "True",
                                    questionNumber: currentQuestion
                                ),
                                buttonText: viewModel.answers.count == 0 ? "" : "True"
                            )
                            Spacer()

                            BooleanButton(isAnimating: $isAnimating,
                                isCorrect: viewModel.checkBooleanQuestion(
                                  answer: "False",
                                  questionNumber: currentQuestion
                                ),
                                buttonText: viewModel.answers.count == 0 ? "" : "False"
                            )
                        }
                case .any:
                    fatalError("Don't insert .any")
                }
                if currentQuestion < Manager.API.shared.questions.count - 1 {
                    SwiftUI.Button(action: { currentQuestion += 1 }) {
                        Text("Next Question")
                    }
                } else {
                    NavigationLink(destination: ConclusionView().navigationBarHidden(true)) {
                        Text("Finish quiz")
                    }
                }
            }.foregroundColor(DesignSystem.Color.textColorByCategory(category: viewModel.category).uiColor)
        }
    }
}

extension Views.QuestionView {
    class ViewModel: ObservableObject {
        let manager = Manager.API()
        @Published var category: Manager.API.QuestionCategory = .all
        @Published var title: String = ""
        @Published var image: Image = .init(systemName: "exclamationmark.circle.fill")
        @Published var question: String = ""
        @Published var answerType: String = ""
        @Published var answers: [String] = []

        public func checkIfRightAnswer(questionNumber: Int, index: Int) -> Bool {
            if answers.count == 0 {
                return false
            }
            return answers[index] == Manager.API.shared.questions[questionNumber].correct_answer
        }

        public func checkBooleanQuestion(answer: String, questionNumber: Int) -> Bool {
            return answer == Manager.API.shared.questions[questionNumber].correct_answer ? true : false
        }

        public func update(question: Question) {
            self.title = question.category.categoryName
            self.image = Image(question.category.categoryName)
            self.question = question.question
            self.answerType = question.type
            self.answers.removeAll()
            self.answers.append(question.correct_answer)
            question.incorrect_answers.forEach {
                self.answers.append($0)
            }
            self.category = question.category
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
