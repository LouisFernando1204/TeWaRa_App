//
//  AnswerDescriptionView.swift
//  MAC_ALP_MAD
//
//  Created by Louis Fernando on 30/05/24.
//
import SwiftUI
import AVKit

struct AnswerDescriptionViewMac: View {
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.currentIslandObject)
    @State private var navToIslandView = false
    @State private var traditionalDanceDescription: TraditionalDance? = nil
    @State private var traditionalLanguageDescription: TraditionalLanguage? = nil
    
    var body: some View {
        NavigationStack() {
            GeometryReader { geometry in
                ScrollView {
                    VStack(){
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
                .navigationDestination(isPresented: $navToIslandView) {
                    IslandViewMac()
                }
            }
        }
    }
    
    private func setUpAnswerDescriptionView(screenSize: CGSize, islandController: IslandController, navToIslandView: Binding<Bool>, traditionalDanceDescription: TraditionalDance, traditionalLanguageDescription: TraditionalLanguage) -> some View {
        VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/){
            navigationBar(navToIslandView: navToIslandView, screenSize: screenSize)
            VStack{
                HStack (spacing: screenSize.width/40){
                    if ModelData.shared.currentGame == "TraditionalDance" {
                        if let videoURL = Bundle.main.url(forResource: traditionalDanceDescription.image, withExtension: "mp4") {
                            VideoPlayerMac(videoURL: videoURL, type: "Desc", ScreenSize: screenSize, stopVideo: $navToIslandView)
                            
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
                                .frame(width: screenSize.width/2.5, height: screenSize.height/2.78)
                                .cornerRadius(10)
                                .shadow(radius: 10, y: 4)
                        }
                        description(description: traditionalLanguageDescription.description, answer: traditionalLanguageDescription.answer, provinceOrigin: traditionalLanguageDescription.provinceOrigin, title: "BAHASA", screenSize: screenSize)
                    }
                }
                .padding(.horizontal, screenSize.width/23.95)
                .padding(.bottom, screenSize.height/20)
                poinStatus(screenSize: screenSize)
            }
            .padding(.vertical, screenSize.height/12)
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
    VStack(alignment: .leading) {
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
                    .multilineTextAlignment(.leading)
            )
            .padding(.bottom, screenSize.height/80)
        Text("Asal: \(provinceOrigin)")
            .font(.title2)
            .fontWeight(.bold)
            .foregroundColor(.gray)
            .multilineTextAlignment(.leading)
            .italic()
            .padding(.bottom, screenSize.height/60)
        Text(description)
            .font(.title)
            .fontWeight(.regular)
            .foregroundColor(.black)
            .multilineTextAlignment(.leading)
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
}

#Preview {
    AnswerDescriptionViewMac()
}
