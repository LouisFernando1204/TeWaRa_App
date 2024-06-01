//
//  AnswerDescriptionView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI
import AVKit

struct AnswerDescriptionView: View {
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
    @State private var navToIslandView = false
    @State private var traditionalDanceDescription: TraditionalDance? = nil
    @State private var traditionalLanguageDescription: TraditionalLanguage? = nil
    
    private var screenSize = ScreenSize()
    
    struct RoundedCorner: Shape {
        var cornerRadius: CGFloat
        var corners: UIRectCorner
        
        func path(in rect: CGRect) -> Path {
            let path = UIBezierPath(
                roundedRect: rect,
                byRoundingCorners: corners,
                cornerRadii: CGSize(width: cornerRadius, height: cornerRadius)
            )
            return Path(path.cgPath)
        }
    }
    
    var body: some View {
        
        let isIpad = ScreenSize.screenWidth > 600
        
        ScrollView {
            VStack {
                if let danceDescription = traditionalDanceDescription, let languageDescription = traditionalLanguageDescription {
                    self.setUpAnswerDescriptionView(islandController: islandController, navToIslandView: $navToIslandView, traditionalDanceDescription: danceDescription, traditionalLanguageDescription: languageDescription, isIpad: isIpad)
                }
            }
            .onAppear {
                self.traditionalDanceDescription = self.islandController.showTraditionalDanceDescription()
                self.traditionalLanguageDescription = self.islandController.showTraditionalLanguageDescription()
            }
        }
        .safeAreaInset(edge: .top) {
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .frame(height: isIpad ? ScreenSize.screenHeight/35 : ScreenSize.screenHeight/12)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, isIpad ? -40 : -70)
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
            }
        }
        .onDisappear {
            MusicPlayer.shared.stopBackgroundMusic()
        }
        .onChange(of: self.navToIslandView) { oldValue, newValue in
            if newValue {
                MusicPlayer.shared.stopBackgroundMusic()
            } else {
                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
            }
        }
    }
    
    private func setUpAnswerDescriptionView(islandController: IslandController, navToIslandView: Binding<Bool>, traditionalDanceDescription: TraditionalDance, traditionalLanguageDescription: TraditionalLanguage, isIpad: Bool) -> some View {
        VStack {
            self.navigationBar(navToIslandView: navToIslandView, isIpad: isIpad)
            if ModelData.shared.currentGame == "TraditionalDance" {
                if let videoURL = Bundle.main.url(forResource: traditionalDanceDescription.image, withExtension: "mp4") {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: isIpad ? ScreenSize.screenHeight/2.555 : ScreenSize.screenHeight/3.85)
                        .clipShape(
                            RoundedCorner(cornerRadius: 40, corners: [.bottomLeft, .bottomRight])
                        )
                        .shadow(radius: 10, y: 4)
                        .padding(.top, -8)
                        .padding(.bottom, isIpad ? ScreenSize.screenHeight/40 : ScreenSize.screenHeight/80)
                }
                self.description(description: traditionalDanceDescription.description, answer: traditionalDanceDescription.answer, provinceOrigin: traditionalDanceDescription.provinceOrigin, title: "TARI", isIpad: isIpad)
            } else {
                if let image = traditionalLanguageDescription.image {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: isIpad ? ScreenSize.screenHeight/2.2 : ScreenSize.screenHeight/4.5)
                        .clipShape(
                            RoundedCorner(cornerRadius: 40, corners: [.bottomLeft, .bottomRight])
                        )
                        .shadow(radius: 10, y: 4)
                        .padding(.top, -8)
                        .padding(.bottom, isIpad ? ScreenSize.screenHeight/40 : ScreenSize.screenHeight/80)
                }
                description(description: traditionalLanguageDescription.description, answer: traditionalLanguageDescription.answer, provinceOrigin: traditionalLanguageDescription.provinceOrigin, title: "BAHASA", isIpad: isIpad)
            }
            self.poinStatus(isIpad: isIpad)
        }
    }
    
    private func navigationBar(navToIslandView: Binding<Bool>, isIpad: Bool) -> some View {
        HStack(alignment: .center) {
            Text("                             ")
            Spacer()
            if isIpad {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            Text("Penjelasan")
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .font(isIpad ? .title2 : .headline)
            Spacer()
            Spacer()
            if isIpad {
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            Button(
                action: {
                    navToIslandView.wrappedValue = true
                },
                label: {
                    Text("Selesai")
                        .font(isIpad ? .title2 : .headline)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                }
            )
            .cornerRadius(10)
            .padding(.leading, isIpad ? ScreenSize.screenWidth/7.5 : ScreenSize.screenWidth/20)
            .fullScreenCover(isPresented: $navToIslandView, content: {
                IslandView()
            })
            Spacer()
        }
        .padding(.bottom, isIpad ? ScreenSize.screenHeight/100 : 0)
        .frame(height: isIpad ? ScreenSize.screenHeight/30 : ScreenSize.screenHeight/20)
        .background(
            LinearGradient(
                gradient: Gradient(stops: [
                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0)
                ]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
        )
    }
    
    private func description(description: String, answer: String, provinceOrigin: String, title: String, isIpad: Bool) -> some View {
        VStack {
            Rectangle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(stops: [
                            .init(color: Color("redColor(TeWaRa)"), location: 0.7),
                            .init(color: Color("darkredColor(TeWaRa)"), location: 1.0)
                        ]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .frame(width: isIpad ? ScreenSize.screenWidth/2.5 : ScreenSize.screenWidth/1.4, height: isIpad ? ScreenSize.screenHeight/17 : ScreenSize.screenHeight/12)
                .padding(.top, -8)
                .cornerRadius(32)
                .overlay(
                    Text("\(title) \(answer)")
                        .font(.system(size: isIpad ? 36 : 32, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                )
                .padding(.bottom, isIpad ? ScreenSize.screenHeight/80 : ScreenSize.screenHeight/80)
            Text("Asal: \(provinceOrigin)")
                .font(.system(size: isIpad ? 20 : 16, weight: .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .italic()
                .padding(.bottom, isIpad ? ScreenSize.screenHeight/40 : ScreenSize.screenHeight/65)
            Text(description)
                .font(.system(size: isIpad ? 24 : 20, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, isIpad ? ScreenSize.screenWidth/25 : ScreenSize.screenWidth/15)
                .padding(.bottom, isIpad ? ScreenSize.screenHeight/30 : ScreenSize.screenHeight/80)
                .lineSpacing(10)
        }
    }
    
    private func poinStatus(isIpad: Bool) -> some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(stops: [
                        .init(color: Color("redColor(TeWaRa)"), location: 0.5),
                        .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )
            .frame(width: isIpad ? ScreenSize.screenWidth/1.0855 : ScreenSize.screenWidth/1.16, height: isIpad ? ScreenSize.screenHeight/10 : ScreenSize.screenHeight/8.5)
            .cornerRadius(10)
            .overlay(
                HStack {
                    Spacer()
                    Text("Poin mu sekarang adalah \(ModelData.shared.currentUser.score)")
                        .font(.system(size: isIpad ? 25 : 20, weight: .regular))
                        .foregroundColor(.white)
                    Spacer()
                }
            )
    }
}

#Preview {
    AnswerDescriptionView()
}
