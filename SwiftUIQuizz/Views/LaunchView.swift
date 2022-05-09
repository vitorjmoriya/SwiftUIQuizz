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
        @State var playLottie = true

        var body: some View {
            LottieView(name: "wave", play: $playLottie)
                .lottieLoopMode(.loop)
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
