//
//  IslandView.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import SwiftUI

struct IslandView: View {
    private let islands: [Island] = [
        ModelData.shared.sumatera,
        ModelData.shared.java,
        ModelData.shared.kalimantan,
        ModelData.shared.papua,
        ModelData.shared.sulawesi,
        ModelData.shared.bali
    ]
    
    @State private var selectedIsland: String = ""
    
    @State private var showAlert: Bool = false
    
    @StateObject private var islandController = IslandController(island: ModelData.shared.sumatera)
    
    private let columns: [GridItem] = Array(repeating: .init(.flexible()), count: 2)
    
    //    @State var alreadySelected: Bool = false
    @State var selectSumateraAndGetDance: Bool = false
    @State var selectSumateraAndGetLanguage: Bool = false
    @State var selectKalimantanAndGetDance: Bool = false
    @State var selectKalimantanAndGetLanguage: Bool = false
    @State var selectBaliAndGetDance: Bool = false
    @State var selectBaliAndGetLanguage: Bool = false
    @State var selectSulawesiAndGetDance: Bool = false
    @State var selectSulawesiAndGetLanguage: Bool = false
    @State var selectPapuaAndGetDance: Bool = false
    @State var selectPapuaAndGetLanguage: Bool = false
    @State var selectJavaAndGetDance: Bool = false
    @State var selectJavaAndGetLanguage: Bool = false
    
    init() {
        self.selectedIsland = ""
        self.selectSumateraAndGetDance = false
        self.selectSumateraAndGetLanguage = false
        self.selectKalimantanAndGetDance = false
        self.selectKalimantanAndGetLanguage = false
        self.selectBaliAndGetDance = false
        self.selectBaliAndGetLanguage = false
        self.selectSulawesiAndGetDance = false
        self.selectSulawesiAndGetLanguage = false
        self.selectPapuaAndGetDance = false
        self.selectPapuaAndGetLanguage = false
        self.selectJavaAndGetDance = false
        self.selectJavaAndGetLanguage = false
    }
    
    var body: some View {
        
        if ScreenSize.screenWidth > 600 {
            
            VStack(spacing: 0) {
                TopNavigationBar(name: "Pulau", message: "Beranda")
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 5) {
                        
                        ForEach(0..<islands.count, id:\.self) { index in
                            
                            Button(action: {
                                islandController.addUserToArray(islandName: islands[index].islandName)
                                self.selectedIsland = islands[index].islandName
                                self.showAlert = true
                                if self.selectedIsland == "Sumatera" {
                                    ModelData.shared.currentIslandObject = ModelData.shared.sumatera
                                    if islandController.getChosenGameByRandom() {
                                        self.selectSumateraAndGetDance = true
                                        
                                    }
                                    else {
                                        self.selectSumateraAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Sulawesi" {
                                    ModelData.shared.currentIslandObject = ModelData.shared.sulawesi
                                    if islandController.getChosenGameByRandom() {
                                        self.selectSulawesiAndGetDance = true
                                    }
                                    else {
                                        self.selectSulawesiAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Kalimantan" {
                                    ModelData.shared.currentIslandObject = ModelData.shared.kalimantan
                                    if islandController.getChosenGameByRandom() {
                                        self.selectKalimantanAndGetDance = true
                                    }
                                    else {
                                        self.selectKalimantanAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Papua" {
                                    ModelData.shared.currentIslandObject = ModelData.shared.papua
                                    if islandController.getChosenGameByRandom() {
                                        self.selectPapuaAndGetDance = true
                                    }
                                    else {
                                        self.selectPapuaAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Bali" {
                                    ModelData.shared.currentIslandObject = ModelData.shared.bali
                                    if islandController.getChosenGameByRandom() {
                                        self.selectBaliAndGetDance = true
                                    }
                                    else {
                                        self.selectBaliAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Jawa" {
                                    ModelData.shared.currentIslandObject = ModelData.shared.java
                                    if islandController.getChosenGameByRandom() {
                                        self.selectJavaAndGetDance = true
                                    }
                                    else {
                                        self.selectJavaAndGetLanguage = true
                                    }
                                }
                            }) {
                                ZStack(alignment: .bottom) {
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("darkredColor(TeWaRa)")]),
                                                startPoint: .topLeading,
                                                endPoint: .bottomTrailing
                                            )
                                        )
                                        .frame(width: 370, height: 303)
                                    
                                    VStack {
                                        Image(islands[index].islandImage)
                                            .resizable()
                                            .frame(width: 370, height: 210)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .padding(.bottom, 20)
                                        Text(islands[index].islandName)
                                            .font(.title)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 30)
                                    }
                                    
                                }
                                .onAppear {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 3)
                                    }
                                }
                                .onDisappear {
                                    MusicPlayer.shared.stopBackgroundMusic()
                                }
                                .onChange(of: self.showAlert) { oldValue, newValue in
                                    if newValue {
                                        MusicPlayer.shared.stopBackgroundMusic()
                                    } else {
                                        MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
                                    }
                                }
                                .padding()
                                .fullScreenCover(isPresented: $selectSumateraAndGetDance) {
                                    TraditionalDanceView(selectedIsland: ModelData.shared.sumatera)
                                }
                                .fullScreenCover(isPresented: $selectSumateraAndGetLanguage) {
                                    TraditionalLanguageView(selectedIsland: ModelData.shared.sumatera)
                                }
                                
                                .fullScreenCover(isPresented: $selectKalimantanAndGetDance) {
                                    TraditionalDanceView(selectedIsland: ModelData.shared.kalimantan)
                                }
                                .fullScreenCover(isPresented: $selectKalimantanAndGetLanguage) {
                                    TraditionalLanguageView(selectedIsland: ModelData.shared.kalimantan)
                                }
                                
                                .fullScreenCover(isPresented: $selectPapuaAndGetDance) {
                                    TraditionalDanceView(selectedIsland: ModelData.shared.papua)
                                }
                                .fullScreenCover(isPresented: $selectPapuaAndGetLanguage) {
                                    TraditionalLanguageView(selectedIsland: ModelData.shared.papua)
                                }
                                
                                .fullScreenCover(isPresented: $selectBaliAndGetDance) {
                                    TraditionalDanceView(selectedIsland: ModelData.shared.bali)
                                }
                                .fullScreenCover(isPresented: $selectBaliAndGetLanguage) {
                                    TraditionalLanguageView(selectedIsland: ModelData.shared.bali)
                                }
                                
                                .fullScreenCover(isPresented: $selectJavaAndGetDance) {
                                    TraditionalDanceView(selectedIsland: ModelData.shared.java)
                                }
                                .fullScreenCover(isPresented: $selectJavaAndGetLanguage) {
                                    TraditionalLanguageView(selectedIsland: ModelData.shared.java)
                                }
                                
                                .fullScreenCover(isPresented: $selectSulawesiAndGetDance) {
                                    TraditionalDanceView(selectedIsland: ModelData.shared.sulawesi)
                                }
                                .fullScreenCover(isPresented: $selectSulawesiAndGetLanguage) {
                                    TraditionalLanguageView(selectedIsland: ModelData.shared.sulawesi)
                                }
                            }
                            
                        }
                    }
                }
                .padding()
            }
        } else {
            NavigationView {
                VStack(spacing: 0) {
                    TopNavigationBar(name: "Pulau", message: "Beranda")
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            ForEach(0..<islands.count, id:\.self) { index in
                                
                                Button(action: {
                                    islandController.addUserToArray(islandName: islands[index].islandName)
                                    self.selectedIsland = islands[index].islandName
                                    self.showAlert = true
                                    if self.selectedIsland == "Sumatera" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.sumatera
                                        if islandController.getChosenGameByRandom() {
                                            self.selectSumateraAndGetDance = true
                                            
                                        }
                                        else {
                                            self.selectSumateraAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Sulawesi" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.sulawesi
                                        if islandController.getChosenGameByRandom() {
                                            self.selectSulawesiAndGetDance = true
                                        }
                                        else {
                                            self.selectSulawesiAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Kalimantan" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.kalimantan
                                        if islandController.getChosenGameByRandom() {
                                            self.selectKalimantanAndGetDance = true
                                        }
                                        else {
                                            self.selectKalimantanAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Papua" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.papua
                                        if islandController.getChosenGameByRandom() {
                                            self.selectPapuaAndGetDance = true
                                        }
                                        else {
                                            self.selectPapuaAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Bali" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.bali
                                        if islandController.getChosenGameByRandom() {
                                            self.selectBaliAndGetDance = true
                                        }
                                        else {
                                            self.selectBaliAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Jawa" {
                                        ModelData.shared.currentIslandObject = ModelData.shared.java
                                        if islandController.getChosenGameByRandom() {
                                            self.selectJavaAndGetDance = true
                                        }
                                        else {
                                            self.selectJavaAndGetLanguage = true
                                        }
                                    }
                                }) {
                                    ZStack(alignment: .center) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .fill(
                                                LinearGradient(
                                                    gradient: Gradient(colors: [Color("redColor(TeWaRa)"), Color("darkredColor(TeWaRa)")]),
                                                    startPoint: .topLeading,
                                                    endPoint: .bottomTrailing
                                                )
                                            )
                                            .frame(width: 160, height: 180)
                                        VStack {
                                            Image(islands[index].islandImage)
                                                .resizable()
                                                .frame(width: 160, height: 130)
                                                .clipShape(RoundedRectangle(cornerRadius: 10))
                                            Spacer()
                                                .frame(height: 16)
                                            Text(islands[index].islandName)
                                                .font(.title3)
                                                .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                                .foregroundColor(.white)
                                                .padding(.bottom, 20)
                                        }
                                    }
                                    .onAppear {
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0) {
                                            MusicPlayer.shared.startBackgroundMusic(musicTitle: "mainMusic", volume: 3)
                                        }
                                    }
                                    .onDisappear {
                                        MusicPlayer.shared.stopBackgroundMusic()
                                    }
                                    .onChange(of: self.showAlert) { oldValue, newValue in
                                        if newValue {
                                            MusicPlayer.shared.stopBackgroundMusic()
                                        } else {
                                            MusicPlayer.shared.startBackgroundMusic(musicTitle: "quizMusic", volume: 1)
                                        }
                                    }
                                    .fullScreenCover(isPresented: $selectSumateraAndGetDance) {
                                        TraditionalDanceView(selectedIsland: ModelData.shared.sumatera)
                                    }
                                    .fullScreenCover(isPresented: $selectSumateraAndGetLanguage) {
                                        TraditionalLanguageView(selectedIsland: ModelData.shared.sumatera)
                                    }
                                    
                                    .fullScreenCover(isPresented: $selectKalimantanAndGetDance) {
                                        TraditionalDanceView(selectedIsland: ModelData.shared.kalimantan)
                                    }
                                    .fullScreenCover(isPresented: $selectKalimantanAndGetLanguage) {
                                        TraditionalLanguageView(selectedIsland: ModelData.shared.kalimantan)
                                    }
                                    
                                    .fullScreenCover(isPresented: $selectPapuaAndGetDance) {
                                        TraditionalDanceView(selectedIsland: ModelData.shared.papua)
                                    }
                                    .fullScreenCover(isPresented: $selectPapuaAndGetLanguage) {
                                        TraditionalLanguageView(selectedIsland: ModelData.shared.papua)
                                    }
                                    
                                    .fullScreenCover(isPresented: $selectBaliAndGetDance) {
                                        TraditionalDanceView(selectedIsland: ModelData.shared.bali)
                                    }
                                    .fullScreenCover(isPresented: $selectBaliAndGetLanguage) {
                                        TraditionalLanguageView(selectedIsland: ModelData.shared.bali)
                                    }
                                    
                                    .fullScreenCover(isPresented: $selectJavaAndGetDance) {
                                        TraditionalDanceView(selectedIsland: ModelData.shared.java)
                                    }
                                    .fullScreenCover(isPresented: $selectJavaAndGetLanguage) {
                                        TraditionalLanguageView(selectedIsland: ModelData.shared.java)
                                    }
                                    
                                    .fullScreenCover(isPresented: $selectSulawesiAndGetDance) {
                                        TraditionalDanceView(selectedIsland: ModelData.shared.sulawesi)
                                    }
                                    .fullScreenCover(isPresented: $selectSulawesiAndGetLanguage) {
                                        TraditionalLanguageView(selectedIsland: ModelData.shared.sulawesi)
                                    }
                                }
                            }
                        }
                    }
                    .padding(20)
                    .padding(.top, ScreenSize.screenHeight/50)
                }
                .navigationBarHidden(true)
            }
        }
    }
}

#Preview {
    IslandView()
}
