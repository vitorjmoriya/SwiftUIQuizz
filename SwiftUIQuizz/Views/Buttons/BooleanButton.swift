//
//  BooleanButton.swift
//  SwiftUIQuizz
//
//  Created by Henrique Loureiro de Faria on 18/05/22.
//

import SwiftUI
import LottieSwiftUI

extension Views {
    struct BooleanButton: View {
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
                ZStack {
                    Text(buttonText)
                        .frame(width: 100, height: 100)
                        .foregroundColor(Color.black)
                        .background(buttonText == "True" ? Color.green: Color.red)
                        .clipShape(Circle())
                    if isAnimating {
                        LottieView(name: isCorrect ? "correct": "wrong")
                            .lottieLoopMode(.playOnce)
                    }
                }
                .frame(width: 150, height: 150)
                .padding()
            }
        }
    }
}
