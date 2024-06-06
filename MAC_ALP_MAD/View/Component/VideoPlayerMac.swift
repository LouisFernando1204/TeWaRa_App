//
//  VideoPlayer.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 04/06/24.
//

import SwiftUI
import AVKit

struct VideoPlayerMac: View {
    
    var type: String
    let showAlert: Bool = true
    var screenSize : CGSize
    @StateObject private var playerWrapper: AVPlayerWrapper
    @Binding var stopVideo: Bool

    init(videoURL: URL, type: String, ScreenSize: CGSize, stopVideo: Binding<Bool>? = nil) {
        _playerWrapper = StateObject(wrappedValue: AVPlayerWrapper(url: videoURL))
        self.type = type
        self.screenSize = ScreenSize
        if let stopVideo = stopVideo {
            self._stopVideo = stopVideo
        } else {
            self._stopVideo = .constant(false)
        }
    }
    
    //    init(videoURL: URL) {
    //        self.player = AVPlayer(url: videoURL)
    //    }
    
    var body: some View {
        return Group {
            if type == "Game" {
                VideoPlayer(player: playerWrapper.player)
                    .frame(width: screenSize.width/2.4, height: screenSize.width/3.4)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                    .shadow(radius:5)
                    .padding(.bottom, 10)
                    .onAppear {
                        playerWrapper.play()
                    }
                    .onDisappear {
                        playerWrapper.pause()
                    }
            }
            else if type == "Desc" {
                VideoPlayer(player: playerWrapper.player)
                    .frame(width: screenSize.width/2.5, height: screenSize.height/2.78)
                    .cornerRadius(10)
                    .shadow(radius: 10, y: 4)
                    .onAppear {
                        playerWrapper.play()
                    }
                    .onDisappear {
                        playerWrapper.pause()
                    }
            }
        }
        .onAppear {
            print("appear", stopVideo)
            playerWrapper.play()
        }
        .onDisappear {
            print("tidak appear", stopVideo)
            playerWrapper.pause()
        }
        .onChange(of: stopVideo) { oldValue, newValue in
            print("change", stopVideo)
            if newValue {
                playerWrapper.pause()
            } else {
                playerWrapper.play()
            }
        }
    }
}


class AVPlayerWrapper: ObservableObject {
    let player: AVPlayer
    
    init(url: URL) {
        self.player = AVPlayer(url: url)
    }
    
    func play() {
        player.play()
    }
    
    func pause() {
        player.pause()
    }
}
