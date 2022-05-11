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
                            ForEach(0 ..< Manager.API.Difficulty.allCases.count) {
                                Text(Manager.API.Difficulty.allCases[$0].rawValue.capitalizingFirstLetter())
                            }
                        }

                        Picker(
                            selection: $selectedCategoryIndex,
                            label: Text("Category")
                        ) {
                            ForEach(0 ..< Manager.API.CategoryNames.allCases.count) {
                                Text(Manager.API.CategoryNames.allCases[$0].rawValue)
                            }
                        }

                        Picker(
                            selection: $selectedTypeIndex,
                            label: Text("Type")
                        ) {
                            ForEach(0 ..< Manager.API.AnswerTypes.allCases.count) {
                                Text(Manager.API.AnswerTypes.allCases[$0].rawValue)
                            }
                        }
                    }

                    NavigationLink(destination: QuestionView(viewModel: .init())) {
                        Text("I wanna play a game")
                    }
                }
            }.navigationViewStyle(StackNavigationViewStyle())
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
