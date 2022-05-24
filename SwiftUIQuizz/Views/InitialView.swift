//
//  InitialView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 09/05/22.
//

import SwiftUI

extension Views {
    struct InitialView: View {
        @ObservedObject var viewModel: ViewModel
        let questionsViewModel: Views.QuestionView.ViewModel = .init()
        @State private var selectedDifficultyIndex = 0
        @State private var selectedCategoryIndex = 0
        @State private var selectedTypeIndex = 0

        var body: some View {
            NavigationView {
                List {
                    Section("Number of questions") {
                        Stepper {
                            Text("\(viewModel.numberQuestions)")
                        } onIncrement: { viewModel.numberQuestions += 1
                        } onDecrement: { viewModel.numberQuestions -= 1 }
                    }

                    Section {
                        Picker(
                            selection: $selectedDifficultyIndex,
                            label: Text("Difficulty")
                        ) {
                            ForEach(0 ..< Manager.API.Difficulty.allCases.count, id: \.self) {
                                Text(Manager.API.Difficulty.allCases[$0].rawValue.capitalizingFirstLetter())
                            }
                        }

                        Picker(
                            selection: $selectedCategoryIndex,
                            label: Text("Category")
                        ) {
                            ForEach(0 ..< Manager.API.QuestionCategory.allCases.count, id: \.self) {
                                Text(Manager.API.QuestionCategory.allCases[$0].categoryName)
                            }
                        }

                        Picker(
                            selection: $selectedTypeIndex,
                            label: Text("Type")
                        ) {
                            ForEach(0 ..< Manager.API.AnswerTypes.allCases.count, id: \.self) {
                                Text(Manager.API.AnswerTypes.allCases[$0].rawValue.capitalizingFirstLetter())
                            }
                        }
                    }

                    NavigationLink(destination: QuestionView(viewModel: questionsViewModel)
                        .navigationBarHidden(true)
                        .task {
                        do {
                            let questions = try await Manager.API.shared.fetchQuestions(
                                category: Manager.API.QuestionCategory.allCases[selectedCategoryIndex],
                                difficulty: Manager.API.Difficulty.allCases[selectedDifficultyIndex]
                            )
                            questionsViewModel.update(question: questions.first!)
                        } catch {
                            print(error)
                        }
                    }) {
                        Text("I wanna play a game")
                    }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
                .navigationBarHidden(true)
        }
    }
}

extension Views.InitialView {
    class ViewModel: ObservableObject {
        @Published var numberQuestions: Int = 0
    }
}

#if DEBUG
struct InitialView_Previews: PreviewProvider {
    static var previews: some View {
        Views.InitialView(viewModel: .init())
    }
}
#endif
