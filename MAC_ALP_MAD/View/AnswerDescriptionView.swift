////
////  AnswerDescriptionView.swift
////  MAC_ALP_MAD
////
////  Created by Louis Fernando on 30/05/24.
////
//
//import SwiftUI
//import AVKit
//
//struct AnswerDescriptionView: View {
//    
//    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
//    @State private var navToIslandView = false
//    @State private var traditionalDanceDescription: TraditionalDance? = nil
//    @State private var traditionalLanguageDescription: TraditionalLanguage? = nil
//    
//    var body: some View {
//                
//        ScrollView {
//            VStack {
//                if let danceDescription = traditionalDanceDescription, let languageDescription = traditionalLanguageDescription {
//                    self.setUpAnswerDescriptionView(islandController: islandController, navToIslandView: $navToIslandView, traditionalDanceDescription: danceDescription, traditionalLanguageDescription: languageDescription)
//                }
//            }
//            .onAppear {
//                self.traditionalDanceDescription = self.islandController.showTraditionalDanceDescription()
//                self.traditionalLanguageDescription = self.islandController.showTraditionalLanguageDescription()
//            }
//        }
//        .safeAreaInset(edge: .top) {
//            LinearGradient(
//                gradient: Gradient(stops: [
//                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
//                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
//                ]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//            .frame(height: 12)
//            .edgesIgnoringSafeArea(.top)
//            .padding(.bottom, -70)
//        }
//        .onAppear {
//            DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
//                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
//            }
//        }
//        .onDisappear {
//            MusicPlayer.shared.stopBackgroundMusic()
//        }
//        .onChange(of: self.navToIslandView) { oldValue, newValue in
//            if newValue {
//                MusicPlayer.shared.stopBackgroundMusic()
//            } else {
//                MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
//            }
//        }
//    }
//    
//    private func setUpAnswerDescriptionView(islandController: IslandController, navToIslandView: Binding<Bool>, traditionalDanceDescription: TraditionalDance, traditionalLanguageDescription: TraditionalLanguage) -> some View {
//        VStack {
//            self.navigationBar(navToIslandView: navToIslandView)
//            if ModelData.shared.currentGame == "TraditionalDance" {
//                if let videoURL = Bundle.main.url(forResource: traditionalDanceDescription.image, withExtension: "mp4") {
//                    VideoPlayer(player: AVPlayer(url: videoURL))
////                        .frame(height: 3.85)
////                        .shadow(radius: 10, y: 4)
////                        .padding(.top, -8)
////                        .padding(.bottom, 80)
//                }
//                else {
//                    Text("ga ada")
//                }
//                self.description(description: traditionalDanceDescription.description, answer: traditionalDanceDescription.answer, provinceOrigin: traditionalDanceDescription.provinceOrigin, title: "TARI")
//            } else {
//                if let image = traditionalLanguageDescription.image {
//                    Image(image)
//                        .resizable()
//                        .aspectRatio(contentMode: .fill)
//                        .frame(height: 4.5)
//                        .shadow(radius: 10, y: 4)
//                        .padding(.top, -8)
//                        .padding(.bottom,80)
//                }
//                description(description: traditionalLanguageDescription.description, answer: traditionalLanguageDescription.answer, provinceOrigin: traditionalLanguageDescription.provinceOrigin, title: "BAHASA")
//            }
//            self.poinStatus()
//        }
//    }
//    
//    private func navigationBar(navToIslandView: Binding<Bool>) -> some View {
//        HStack(alignment: .center) {
//            Text("                             ")
//            Spacer()
//            Text("Penjelasan")
//                .fontWeight(.semibold)
//                .foregroundColor(Color.white)
//                .font(.title2)
//            Spacer()
//            Spacer()
//            Button(
//                action: {
//                    navToIslandView.wrappedValue = true
//                },
//                label: {
//                    Text("Selesai")
//                        .font(.title2)
//                        .fontWeight(.regular)
//                        .foregroundColor(.white)
//                }
//            )
//            .cornerRadius(10)
//            .padding(.leading, 20)
//            Spacer()
//        }
//        .padding(.bottom, 100)
//        .frame(height: 20)
//        .background(
//            LinearGradient(
//                gradient: Gradient(stops: [
//                    .init(color: Color("redColor(TeWaRa)"), location: 0.5),
//                    .init(color: Color("orangeColor(TeWaRa)"), location: 1.0)
//                ]),
//                startPoint: .topLeading,
//                endPoint: .bottomTrailing
//            )
//        )
//    }
//    
//    private func description(description: String, answer: String, provinceOrigin: String, title: String) -> some View {
//        VStack {
//            Rectangle()
//                .fill(
//                    LinearGradient(
//                        gradient: Gradient(stops: [
//                            .init(color: Color("redColor(TeWaRa)"), location: 0.7),
//                            .init(color: Color("darkredColor(TeWaRa)"), location: 1.0)
//                        ]),
//                        startPoint: .topLeading,
//                        endPoint: .bottomTrailing
//                    )
//                )
//                .frame(width: 1.4, height: 12)
//                .padding(.top, -8)
//                .cornerRadius(32)
//                .overlay(
//                    Text("\(title) \(answer)")
//                        .font(.system(size: 32, weight: .bold))
//                        .foregroundColor(.white)
//                        .multilineTextAlignment(.center)
//                )
//                .padding(.bottom, 80)
//            Text("Asal: \(provinceOrigin)")
//                .font(.system(size: 16, weight: .bold))
//                .foregroundColor(.gray)
//                .multilineTextAlignment(.center)
//                .italic()
//                .padding(.bottom, 65)
//            Text(description)
//                .font(.system(size: 20, weight: .regular))
//                .foregroundColor(.black)
//                .multilineTextAlignment(.leading)
//                .padding(.horizontal,15)
//                .padding(.bottom, 80)
//                .lineSpacing(10)
//        }
//    }
//    
//    private func poinStatus() -> some View {
//        Rectangle()
//            .fill(
//                LinearGradient(
//                    gradient: Gradient(stops: [
//                        .init(color: Color("redColor(TeWaRa)"), location: 0.5),
//                        .init(color: Color("orangeColor(TeWaRa)"), location: 1.0),
//                    ]),
//                    startPoint: .topLeading,
//                    endPoint: .bottomTrailing
//                )
//            )
//            .frame(width: 1.16, height: 8.5)
//            .cornerRadius(10)
//            .overlay(
//                HStack {
//                    Spacer()
//                    Text("Poin mu sekarang adalah \(ModelData.shared.currentUser.score)")
//                        .font(.system(size: 20, weight: .regular))
//                        .foregroundColor(.white)
//                    Spacer()
//                }
//            )
//    }
//}
//
//#Preview {
//    AnswerDescriptionView()
//}
