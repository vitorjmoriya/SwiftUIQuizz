//
//  ButtonView.swift
//  SwiftUIQuizz
//
//  Created by Henrique Loureiro de Faria on 10/05/22.
//

import SwiftUI
import LottieSwiftUI

extension Views {
    struct Button: View {
        @Binding var isAnimating: Bool
        let isCorrect: Bool // True -> correct answer -- False -> wrong answer
        let buttonText: String
        init(
            isAnimating: Binding<Bool>,
            isCorrect: Bool,
            buttonText: String
        ) {
            self.isCorrect = isCorrect
            self.buttonText = buttonText
            self._isAnimating = isAnimating
        }
        var body: some View {
            SwiftUI.Button(
                action: { isAnimating = true }
            ) {
                HStack {
                    Text(buttonText)
                    Spacer()
                    ZStack {
                        if isAnimating {
                            LottieView(name: isCorrect ? "correct": "wrong")
                                .lottieLoopMode(.playOnce)
                        }
                    }
                    .frame(width: 30.0, height: 30.0)
                }
                .padding()
            }
        }
    }
}
