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
        ScrollView {
            VStack {
                if let danceDescription = traditionalDanceDescription, let languageDescription = traditionalLanguageDescription {
                    self.setUpAnswerDescriptionView(islandController: islandController, navToIslandView: $navToIslandView, traditionalDanceDescription: danceDescription, traditionalLanguageDescription: languageDescription)
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
            .frame(height: 70)
            .edgesIgnoringSafeArea(.top)
            .padding(.bottom, -70)
        }
    }
    
    private func setUpAnswerDescriptionView(islandController: IslandController, navToIslandView: Binding<Bool>, traditionalDanceDescription: TraditionalDance, traditionalLanguageDescription: TraditionalLanguage) -> some View {
        VStack {
            self.navigationBar(navToIslandView: navToIslandView)
            if ModelData.shared.currentGame == "TraditionalDance" {
                if let videoURL = Bundle.main.url(forResource: traditionalDanceDescription.image, withExtension: "MOV") {
                    VideoPlayer(player: AVPlayer(url: videoURL))
                        .frame(height: 221)
                        .clipShape(
                            RoundedCorner(cornerRadius: 40, corners: [.bottomLeft, .bottomRight])
                        )
                        .padding(.top, -8)
                        .padding(.bottom, 7)
                }
                self.description(description: traditionalDanceDescription.description, answer: traditionalDanceDescription.answer, provinceOrigin: traditionalDanceDescription.provinceOrigin, title: "TARI")
            } else {
                if let image = traditionalLanguageDescription.image {
                    Image(image)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(
                            RoundedCorner(cornerRadius: 40, corners: [.bottomLeft, .bottomRight])
                        )
                        .padding(.top, -8)
                        .padding(.bottom, 7)
                }
                description(description: traditionalLanguageDescription.description, answer: traditionalLanguageDescription.answer, provinceOrigin: traditionalLanguageDescription.provinceOrigin, title: "BAHASA")
            }
            self.poinStatus()
        }
    }
    
    private func navigationBar(navToIslandView: Binding<Bool>) -> some View {
        HStack(alignment: .center) {
            Text("                             ")
            Spacer()
            Text("Penjelasan")
                .fontWeight(.semibold)
                .foregroundColor(Color.white)
                .font(.headline)
            Spacer()
            Spacer()
            Button(
                action: {
                    navToIslandView.wrappedValue = true
                },
                label: {
                    Text("Selesai")
                        .font(.headline)
                        .fontWeight(.regular)
                        .foregroundColor(.white)
                }
            )
            .cornerRadius(10)
            .padding(.leading, 20)
            .fullScreenCover(isPresented: navToIslandView, content: {
                IslandView()
            })
            Spacer()
        }
        .frame(height: 40)
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
                .frame(width: 270, height: 70)
                .padding(.top, -8)
                .cornerRadius(32)
                .overlay(
                    Text("\(title) \(answer)")
                        .font(.system(size: 32, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                )
                .padding(.bottom, 10)
            Text("Asal: \(provinceOrigin)")
                .font(.system(size: 16, weight: .bold))
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .italic()
                .padding(.bottom, 10)
            Text(description)
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(.black)
                .multilineTextAlignment(.leading)
                .padding(.horizontal, 20)
                .padding(.bottom, 10)
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
            .frame(width: 340, height: 100)
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
