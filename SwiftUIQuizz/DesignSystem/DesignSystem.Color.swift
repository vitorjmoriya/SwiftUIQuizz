//
//  DesignSystem.Color.swift
//  SwiftUIQuizz
//
//  Created by Vitor Jundi Moriya on 23/05/22.
//
import SwiftUI

extension DesignSystem {
    struct Color {
        public let uiColor: SwiftUI.Color

        public var color: Color {
            Color(uiColor: uiColor)
        }
    }
}

extension DesignSystem.Color {
    enum System {
        static let basicColor = DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
    }
}
