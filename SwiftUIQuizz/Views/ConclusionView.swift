//
//  ConclusionView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 17/05/22.
//

import SwiftUI

extension Views {
    struct ConclusionView: View {
        var body: some View {
            Text("Finished Quiz")
            Text("Correct Answers: \(Manager.AnswerTracker.shared.correctAnswers)")
            Text("Incorrect Answers: \(Manager.AnswerTracker.shared.wrongAnswers)")
            Text("Total Questions Answers: \(Manager.AnswerTracker.shared.questionAmount)")
            NavigationLink(destination: InitialView(viewModel: .init()).navigationBarHidden(true)) {
                Text("Play Again")
            }
        }
    }
}
