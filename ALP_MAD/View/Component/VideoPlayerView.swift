//
//  VideoPlayer.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 04/06/24.
//

import SwiftUI
import AVKit

struct VideoPlayerView: View {
    
    var type: String
    @StateObject private var playerWrapper: AVPlayerWrapper
    @Binding var stopVideo: Bool
    
    init(videoURL: URL, type: String, stopVideo: Binding<Bool>? = nil) {
        _playerWrapper = StateObject(wrappedValue: AVPlayerWrapper(url: videoURL))
        self.type = type
        if let stopVideo = stopVideo {
            self._stopVideo = stopVideo
        } else {
            self._stopVideo = .constant(false)
        }
    }
    
    
    var body: some View {
        let videoPlayer = VideoPlayer(player: playerWrapper.player)
        
        return Group {
            if type == "Game" {
                videoPlayer
                    .frame(
                        width: ScreenSize.screenWidth > 600 ? ScreenSize.screenWidth / 1.3 : ScreenSize.screenWidth / 1.1,
                        height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight / 3 : ScreenSize.screenHeight / 4
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .shadow(radius: 5)
                    .padding(.bottom, ScreenSize.screenWidth > 600 ? 8 : 12)
            } else if type == "Desc" {
                videoPlayer
                    .frame(height: ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight/2.555 : ScreenSize.screenHeight/3.85)
                    .clipShape(
                        RoundedCorner(cornerRadius: 40, corners: [.bottomLeft, .bottomRight])
                    )
                    .shadow(radius: 10, y: 4)
                    .padding(.top, -8)
                    .padding(.bottom, ScreenSize.screenWidth > 600 ? ScreenSize.screenHeight/40 : ScreenSize.screenHeight/80)
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
