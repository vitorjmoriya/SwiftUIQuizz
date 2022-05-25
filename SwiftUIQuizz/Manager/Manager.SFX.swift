//
//  Manager.SFX.swift
//  SwiftUIQuizz
//
//  Created by Henrique Loureiro de Faria on 25/05/22.
//

import Foundation
import AVFoundation

extension Manager {
    struct SFX {
        public static var shared = Manager.SFX()
        var audioPlayer: AVAudioPlayer!
        static func playSound(sound: Sound) {
            if let url = Bundle.main.url(forResource: sound.soundFile, withExtension: "wav") {
                do {
                    shared.audioPlayer = try AVAudioPlayer(contentsOf: url)
                    shared.audioPlayer.play()
                } catch {
                    print(error)
                }
            }

        }
        enum Sound {
            case correct
            case wrong
            case finished
            var soundFile: String {
                switch self {
                case .correct:
                    return "correct"
                case .wrong:
                    return "wrong"
                case .finished:
                    return "finished"
                }
            }
        }
    }
}
