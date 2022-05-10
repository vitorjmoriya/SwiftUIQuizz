//
//  LaunchView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 09/05/22.
//

import SwiftUI
import LottieSwiftUI

extension Views {
    struct LaunchView: View {
        @State var isLoading = true

        var body: some View {
            if isLoading {
                LottieView(name: "wave", play: .constant(true))
                    .lottieLoopMode(.loop)
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                                self.isLoading = false
                            }
                        }
                    }
            } else {
                InitialView(viewModel: .init())
            }
        }
    }
}

#if DEBUG
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        Views.LaunchView()
    }
}
#endif
