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
                ZStack {
                    DesignSystem.Color.System.launchColor.color.uiColor.edgesIgnoringSafeArea(.all)
                    VStack {
                        Constants.logoImage
                            .resizable()
                            .frame(width: Constants.logoImageSize, height: Constants.logoImageSize, alignment: .center)
                        Text(Constants.logoName)
                            .font(.system(size: Constants.fontSize))
                            .foregroundColor(DesignSystem.Color.System.logoFontColor.color.uiColor)
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                            withAnimation {
                            self.isLoading = false
                            }
                        }
                    }
                }
            } else {
                TabView {
                    Views.InitialView(viewModel: .init())
                        .tabItem {
                            Label("Quiz", systemImage: "list.dash")
                        }
                    Views.ProfileView(viewModel: .init())
                        .tabItem {
                            Label("Profile", systemImage: "person.circle.fill")
                        }
                }
            }
        }
    }
}

extension Views.LaunchView {
    struct Constants {
        static let logoImage: Image = .init("Logo")
        static let logoImageSize: CGFloat = 300
        static let logoName: String = "SwitUI Quiz"
        static let fontSize: CGFloat = 40
    }
}

#if DEBUG
struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        Views.LaunchView()
    }
}
#endif
