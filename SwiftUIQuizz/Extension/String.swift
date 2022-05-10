//
//  String.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 10/05/22.
//

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
