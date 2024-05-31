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
                .background(Color.white)
                .onAppear {
                    //                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                    //                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
                    //                    }
                    MusicPlayer.shared.stopBackgroundMusic()
                }
                .onDisappear {
                    MusicPlayer.shared.stopBackgroundMusic()
                }
                .onChange(of: navToIslandView) { oldValue, newValue in
                    if newValue {
                        MusicPlayer.shared.stopBackgroundMusic()
                    } else {
                        //                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
                        MusicPlayer.shared.stopBackgroundMusic()
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
            navigationBar(navToIslandView: navToIslandView, screenSize: screenSize)
            HStack{
                if ModelData.shared.currentGame == "TraditionalDance" {
                    if let videoURL = Bundle.main.url(forResource: traditionalDanceDescription.image, withExtension: "mp4") {
                        VideoPlayer(player: AVPlayer(url: videoURL))
                            .frame(width: screenSize.width/3, height: screenSize.height/3.3)
                            .shadow(radius: 10, y: 4)
                    } else {
                        Text("Video tidak ditemukan.")
                            .foregroundColor(.red)
                            .padding()
                    }
                    description(description: traditionalDanceDescription.description, answer: traditionalDanceDescription.answer, provinceOrigin: traditionalDanceDescription.provinceOrigin, title: "TARI", screenSize: screenSize)
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
                    description(description: traditionalLanguageDescription.description, answer: traditionalLanguageDescription.answer, provinceOrigin: traditionalLanguageDescription.provinceOrigin, title: "BAHASA", screenSize: screenSize)
                }
            }
            .padding(.horizontal, screenSize.width/20)
            poinStatus(screenSize: screenSize)
        }
    }
}

private func navigationBar(navToIslandView: Binding<Bool>, screenSize: CGSize) -> some View {
    HStack(alignment: .center) {
        Text("Penjelasan")
            .fontWeight(.semibold)
            .foregroundColor(Color.white)
            .font(.title)
            .padding(.leading, screenSize.width/2.15)
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
        .padding(.trailing, screenSize.width/25)
        .buttonStyle(PlainButtonStyle())
        .cornerRadius(10)
    }
    .frame(height: screenSize.height/10)
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
    .padding(.bottom, screenSize.height/20)
}

private func description(description: String, answer: String, provinceOrigin: String, title: String, screenSize: CGSize) -> some View {
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
            .frame(width: screenSize.width/7, height: screenSize.height/20)
            .cornerRadius(32)
            .overlay(
                Text("\(title) \(answer)")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
            )
            .padding(.bottom, screenSize.height/80)
        Text("Asal: \(provinceOrigin)")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .multilineTextAlignment(.center)
            .italic()
            .padding(.bottom, screenSize.height/60)
        Text(description)
            .font(.title)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
            .padding(.horizontal, screenSize.width/26)
            .padding(.bottom, screenSize.height/50)
            .lineSpacing(10)
    }
}

private func poinStatus(screenSize: CGSize) -> some View {
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
        .frame(width: screenSize.width/1.1, height: screenSize.height/5)
        .cornerRadius(10)
        .overlay(
            HStack {
                Spacer()
                Text("Poin mu sekarang adalah \(ModelData.shared.currentUser.score)")
                    .font(.title)
                    .fontWeight(.regular)
                    .foregroundColor(.white)
                Spacer()
            }
        )
        .padding(.bottom, screenSize.height/7)
}


#Preview {
    AnswerDescriptionView()
}
