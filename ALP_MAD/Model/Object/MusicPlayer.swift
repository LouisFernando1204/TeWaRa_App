//
//  MusicPlayer.swift
//  ALP_MAD
//
//  Created by Louis Fernando on 29/05/24.
//

import AVFoundation

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?

    func startBackgroundMusic(musicTitle: String, volume: Float = 1.0) {
        if let bundle = Bundle.main.path(forResource: musicTitle, ofType: "mp3") {
            let musicURL = URL(fileURLWithPath: bundle)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: musicURL)
                audioPlayer?.numberOfLoops = -1 // Loop indefinitely
                audioPlayer?.volume = volume
                audioPlayer?.play()
            } catch {
                print("Error playing music: \(error.localizedDescription)")
            }
        }
    }

    func stopBackgroundMusic() {
        audioPlayer?.stop()
    }

    func setVolume(volume: Float) {
        audioPlayer?.volume = volume
    }
}
