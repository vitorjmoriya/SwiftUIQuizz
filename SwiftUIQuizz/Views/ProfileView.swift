//
//  ProfileView.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 11/05/22.
//

import SwiftUI

extension Views {
    struct ProfileView: View {

        let viewModel: ViewModel

        var body: some View {
            VStack {
                Constant.profileImage
                    .resizable()
                    .frame(width: Constant.profileSize, height: Constant.profileSize, alignment: .center)
                Text(Constant.profileName)
                List {
                    Section(Constant.headerSection) {
                        ForEach(viewModel.statsList) { statsList in
                            HStack {
                                Text(statsList.rowTitle)
                                Spacer()
                                Text(statsList.rowData)
                            }
                        }
                    }
                }
            }
        }
    }
}

extension Views.ProfileView {
    struct Constant {
        static let profileImage: Image = .init(systemName: "person.circle.fill")
        static let profileSize: CGFloat = 200
        static let profileName: String = "Jorge da Fonseca"
        static let headerSection: String = "Stats"
    }

    class ViewModel: ObservableObject {
        struct Stats: Identifiable {
            var id = UUID()
            var rowTitle: String
            var rowData: String
        }

        @Published var statsList: [Stats] = [
            Stats(rowTitle: "Answers", rowData: "3654"),
            Stats(rowTitle: "Rights", rowData: "2865"),
            Stats(rowTitle: "Wrongs", rowData: "789"),
            Stats(rowTitle: "Accuracy", rowData: "78%")
        ]
    }
}

#if DEBUG
struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Views.ProfileView(viewModel: .init())
    }
}
#endif
