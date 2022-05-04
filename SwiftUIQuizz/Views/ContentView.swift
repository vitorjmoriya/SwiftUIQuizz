//
//  ContentView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 04/05/22.
//

import SwiftUI

extension Views {
    struct ContentView: View {
        @ObservedObject var viewModel: ViewModel

        var body: some View {
            VStack {
                Text(viewModel.text)
                    .padding()
                Button(
                    action: { viewModel.isClicked = true }
                ) {
                    Text("Clique aqui")
                        .padding()
                }
                if viewModel.isClicked {
                    Text("fui clicado")
                        .padding()
                }
            }
        }
    }
}

extension Views.ContentView {
    class ViewModel: ObservableObject {
        @Published var isClicked: Bool = false
        @Published var text: String

        init(text: String = "Lorem Ipsum") {
            self.text = text
        }
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Views.ContentView(viewModel: .init())
    }
}
#endif
