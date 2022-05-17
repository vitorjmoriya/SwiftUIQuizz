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
            
            NavigationLink(destination: InitialView(viewModel: .init()).navigationBarHidden(true)) {
                Text("Play Again")
            }
        }
    }
}
