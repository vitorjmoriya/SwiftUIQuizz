//
//  ConclusionView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 17/05/22.
//

import SwiftUI

extension Views {
    struct ConclusionView: View {
        @ObservedObject var viewModel: ViewModel
        @State var loadingProgress: Int = 0

        var body: some View {
            VStack {
                ZStack {
                    Circle()
                        .trim(from: Views.ConclusionView.CircleConstant.trimBegin,
                              to: Views.ConclusionView.CircleConstant.trimTarget)
                        .stroke(Color.red,
                                style: StrokeStyle(lineWidth: Views.ConclusionView.CircleConstant.defaultLineWidth))
                        .frame(width: Views.ConclusionView.CircleConstant.frameSize,
                               height: Views.ConclusionView.CircleConstant.frameSize)
                        .rotationEffect((Angle(degrees: Views.ConclusionView.CircleConstant.defaultAngle)))
                    Circle()
                        .trim(from: Views.ConclusionView.CircleConstant.trimBegin,
                              to: Views.ConclusionView.CircleConstant.animatedTrimTarget(target: loadingProgress))
                        .stroke(Color.blue, lineWidth: Views.ConclusionView.CircleConstant.defaultLineWidth)
                        .frame(width: Views.ConclusionView.CircleConstant.frameSize,
                               height: Views.ConclusionView.CircleConstant.frameSize)
                        .rotationEffect(Angle(degrees: Views.ConclusionView.CircleConstant.defaultAngle))
                    Text("\(viewModel.answerRate())%")
                }
                VStack(spacing: DesignSystem.Padding.microPadding) {
                    Text("Finished Quiz")
                    Text("Correct Answers: \(viewModel.correctAnswers)")
                    Text("Incorrect Answers: \(viewModel.wrongAnswers)")
                    Text("Total Questions Answers: \(viewModel.totalQuestions)")
                    NavigationLink(destination: InitialView(viewModel: .init()).navigationBarHidden(true)) {
                        Text("Play Again")
                    }
                }
            }.task {
                animateCircle()
            }
        }

        func animateCircle() {
            _ = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { timer in
                withAnimation {
                    if loadingProgress < viewModel.answerRate() {
                        loadingProgress += 1
                        print(loadingProgress)
                    } else {
                        timer.invalidate()
                        return
                    }
                }
            }
        }
    }
}

extension Views.ConclusionView {
    struct CircleConstant {
        static let frameSize: CGFloat = 200
        static let trimBegin: CGFloat = 0.0
        static let trimTarget: CGFloat = 0.5
        static let defaultLineWidth: CGFloat = 12.0
        static let defaultAngle: CGFloat = 180
        static func animatedTrimTarget(target: Int) -> Double {
            return Double(target) / 100 / 2
        }
    }

    class ViewModel: ObservableObject {
        @Published var correctAnswers: Int = Manager.AnswerTracker.shared.correctAnswers
        @Published var wrongAnswers: Int = Manager.AnswerTracker.shared.wrongAnswers
        @Published var totalQuestions: Int = Manager.AnswerTracker.shared.questionAmount

        func answerRate() -> Int {
            var rate: Double
            rate = Double(correctAnswers) / Double(totalQuestions)
            return Int(rate*100)
        }
    }
}
