//
//  AnswerDescriptionView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//
import SwiftUI
import AVKit

struct AnswerDescriptionView: View {
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
    @State private var navToIslandView = false
    @State private var traditionalDanceDescription: TraditionalDance? = nil
    @State private var traditionalLanguageDescription: TraditionalLanguage? = nil
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        if let danceDescription = traditionalDanceDescription, let languageDescription = traditionalLanguageDescription {
                            setUpAnswerDescriptionView(screenSize: geometry.size, islandController: islandController, navToIslandView: $navToIslandView, traditionalDanceDescription: danceDescription, traditionalLanguageDescription: languageDescription)
                        }
                    }
                    .onAppear {
                        traditionalDanceDescription = islandController.showTraditionalDanceDescription()
                        traditionalLanguageDescription = islandController.showTraditionalLanguageDescription()
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
                    .frame(height: 12)
                    .edgesIgnoringSafeArea(.top)
                    .padding(.bottom, -70)
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
                    }
                }
                .onDisappear {
                    MusicPlayer.shared.stopBackgroundMusic()
                }
                .onChange(of: navToIslandView) { oldValue, newValue in
                    if newValue {
                        MusicPlayer.shared.stopBackgroundMusic()
                    } else {
                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
                    }
                }
                .navigationDestination(isPresented: $navToIslandView) {
                    IslandView()
                }
            }
        }
    }
    
    private func setUpAnswerDescriptionView(screenSize: CGSize, islandController: IslandController, navToIslandView: Binding<Bool>, traditionalDanceDescription: TraditionalDance, traditionalLanguageDescription: TraditionalLanguage) -> some View {
        VStack {
            navigationBar(navToIslandView: navToIslandView)
            if ModelData.shared.currentGame == "TraditionalDance" {
                if let videoURL = Bundle.main.url(forResource: traditionalDanceDescription.image, withExtension: "mp4") {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(width: screenSize.width, height: screenSize.height * 0.3)
                        .shadow(radius: 10, y: 4)
                        .padding(.top, -8)
                        .padding(.bottom, 20)
                } else {
                    Text("Video tidak ditemukan.")
                        .foregroundColor(.red)
                        .padding()
                }
                description(description: traditionalDanceDescription.description, answer: traditionalDanceDescription.answer, provinceOrigin: traditionalDanceDescription.provinceOrigin, title: "TARI")
            } else {
                if let image = traditionalLanguageDescription.image {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: screenSize.width, height: screenSize.height * 0.3)
                        .shadow(radius: 10, y: 4)
                        .padding(.top, -8)
                        .padding(.bottom, 20)
                }
                description(description: traditionalLanguageDescription.description, answer: traditionalLanguageDescription.answer, provinceOrigin: traditionalLanguageDescription.provinceOrigin, title: "BAHASA")
            }
            poinStatus()
        }
    }
    
    private func navigationBar(navToIslandView: Binding<Bool>) -> some View {
        HStack(alignment: .center) {
            Spacer()
            Text("Penjelasan")
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .font(.title2)
            Spacer()
            Button(
                action: {
                    navToIslandView.wrappedValue = true
                },
                label: {
                    Text("Selesai")
                        .font(.title2)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                }
            )
            .cornerRadius(10)
            .padding(.leading, 20)
        }
        .padding(.bottom, 10)
        .frame(height: 50)
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
    
    private func description(description: String, answer: String, provinceOrigin: String, title: String) -> some View {
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
                .frame(height: 50)
                .padding(.top, -8)
                .cornerRadius(32)
                .overlay(
                    Text("\(title) \(answer)")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                )
                .padding(.bottom, 20)
            Text("Asal: \(provinceOrigin)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .italic()
                .padding(.bottom, 20)
            Text(description)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 15)
                .padding(.bottom, 20)
                .lineSpacing(10)
        }
    }
    
    private func poinStatus() -> some View {
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
            .frame(height: 100)
            .cornerRadius(10)
            .overlay(
                HStack {
                    Spacer()
                    Text("Poin mu sekarang adalah \(ModelData.shared.currentUser.score)")
                        .font(.system(size: 20, weight: .regular))
                        .foregroundColor(.white)
                    Spacer()
                }
            )
    }
}

#Preview {
    AnswerDescriptionView()
}
