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

// swiftlint:disable:all cyclomatic_complexity
extension DesignSystem.Color {
    static func byCategory(categoryName: Manager.API.CategoryNames) -> DesignSystem.Color {
        switch categoryName {
        case .generalKnowledge:
            return DesignSystem.Color(uiColor: .blue)
        case .entertainmentBooks:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentFilms:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentMusic:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentMusicalsAndTheatres:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentTelevision:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentVideoGames:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentBoardGames:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .scienceAndNature:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .scienceComputers:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .scienceMathematics:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .mythology:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .sports:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .geography:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .history:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .politics:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .art:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .celebrities:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .animals:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .vehicles:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentComics:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .scienceGadgets:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentAnimeAndMaga:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .entertainmentCartoonAndAnimations:
            return DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
        case .all:
            return DesignSystem.Color(uiColor: .red)
        }
    }
}

extension DesignSystem.Color {
    enum System {
        static let basicColor = DesignSystem.Color(uiColor: .init(red: 132/255, green: 196/255, blue: 164/255))
    }
}
