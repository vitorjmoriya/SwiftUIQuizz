//
//  SwiftUIQuizzApp.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 04/05/22.
//

import SwiftUI

@main
struct SwiftUIQuizzApp: App {
    var body: some Scene {
        WindowGroup {
            Views.LaunchView()
                .font(Font.custom("Quicksand", size: 18))
        }
    }
}
