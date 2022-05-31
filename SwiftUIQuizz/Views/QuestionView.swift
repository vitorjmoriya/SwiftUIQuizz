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

        var body: some View {
            ZStack {
                DesignSystem.Color.byCategory(category: viewModel.category).uiColor.edgesIgnoringSafeArea(.all)
                if viewModel.answers.count == 0 {
                    renderBody(answerType: .multiple, isAnimating: $isAnimating)
                        .padding(.horizontal, DesignSystem.Padding.macroPadding)
                        .redacted(reason: .placeholder)
                } else {
                    renderBody(
                        answerType: viewModel.answerType,
                        isAnimating: $isAnimating
                    )
                    .padding(.horizontal, DesignSystem.Padding.macroPadding)
                }
            }
        }

        @ViewBuilder private func renderBody(
            answerType: Manager.API.AnswerTypes,
            isAnimating: Binding<Bool>
        ) -> some View {
            VStack(spacing: DesignSystem.Padding.microPadding) {
                viewModel.image
                Text(viewModel.title)
                    .bold()
                    .padding(.bottom, DesignSystem.Padding.macroPadding)
                Text(viewModel.question)
                    .bold()
                    .padding(.bottom, DesignSystem.Padding.macroPadding)
                switch answerType {
                case .multiple:
                    ForEach(0 ..< 4) { index in
                        MultipleChoiceButton(
                            isAnimating: $isAnimating,
                            isCorrect: viewModel.checkIfRightAnswer(
                                index: index
                            ),
                            buttonText: viewModel.answers.count == 0 ? "" : viewModel.answers[index]
                        )
                    }
                case .boolean:
                    HStack {
                        BooleanButton(isAnimating: $isAnimating,
                            isCorrect: viewModel.checkBooleanQuestion(
                                answer: "True"
                            ),
                            buttonText: viewModel.answers.count == 0 ? "" : "True"
                        )
                        Spacer()
                        BooleanButton(isAnimating: $isAnimating,
                            isCorrect: viewModel.checkBooleanQuestion(
                              answer: "False"
                            ),
                            buttonText: viewModel.answers.count == 0 ? "" : "False"
                        )
                    }
                case .any:
                    fatalError("Don't insert .any")
                }
                if !Manager.SessionManager.shared.sessionEnded() && self.isAnimating {
                    SwiftUI.Button(action: {
                        viewModel.fetchQuestion()
                        self.isAnimating = false
                    }) {
                        Text("Next Question")
                    }
                } else if Manager.SessionManager.shared.sessionEnded() && self.isAnimating {
                        NavigationLink(destination: ConclusionView(viewModel: .init()).navigationBarHidden(true)
                        .onAppear {
                            Manager.SFX.playSound(sound: .finished)
                        }
                    ) {
                        Text("Finish quiz")
                    }
                }
            }.foregroundColor(DesignSystem.Color.textColorByCategory(category: viewModel.category).uiColor)
                .padding(DesignSystem.Padding.microPadding)
        }
    }
}

extension Views.QuestionView {
    class ViewModel: ObservableObject {
        let manager = Manager.API()
        @Published var category: Manager.API.QuestionCategory = .all
        @Published var title: String = ""
        @Published var image: Image = .init("Logo")
        @Published var question: String = ""
        @Published var answerType: Manager.API.AnswerTypes = .any
        @Published var answers: [String] = []
        @Published var questionObj: Question = Question(category: .all,
                                                        type: .any,
                                                        difficulty: "error",
                                                        question: "error",
                                                        correct_answer: "error",
                                                        incorrect_answers: ["", "", ""])

        public func checkIfRightAnswer(index: Int) -> Bool {
            if answers.count == 0 {
                return false
            }
            // print(questionObj.correct_answer, answers)
            return answers[index] == questionObj.correct_answer
        }

        public func checkBooleanQuestion(answer: String) -> Bool {
            // print(answers)
            // print(questionObj.correct_answer, answers)
            return answer == questionObj.correct_answer ? true : false
        }

        public func fetchQuestion() {
            do {
                try questionObj = Manager.SessionManager.shared.currentQuestion()
                update(question: questionObj)
            } catch { print(error) }
        }

        public func update(question: Question) {
            self.questionObj = question
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
