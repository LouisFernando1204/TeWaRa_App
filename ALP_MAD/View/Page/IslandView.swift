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

    var body: some View {
        
        if ScreenSize.screenWidth > 600 {
            
            VStack(spacing: 0) {
                TopNavigationBar(name: "Pulau", message: "Home")
                
                Spacer().frame(height: 70)
                
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        
                        ForEach(0..<islands.count, id:\.self) { index in
                            ZStack(alignment: .bottom) {
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(
                                        LinearGradient(
                                            gradient: Gradient(colors: [
                                                Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                                                Color(red: 118/255, green: 20/255, blue: 20/255)  // #761414
                                            ]),
                                            startPoint: .top,
                                            endPoint: .bottom
                                        )
                                    )
                                    .frame(height: 250)
                                
                                VStack {
                                    Image(islands[index].islandImage)
                                        .resizable()
                                        .frame(width: 240, height: 150)
                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                        .padding([.leading, .trailing], 10)
                                        .padding(.bottom, 20)
                                    Text(islands[index].islandName)
                                        .font(.title)
                                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                        .foregroundColor(.white)
                                        .padding(.bottom, 20)
                                }
                            }
                            .padding()
                            .onTapGesture {
                                self.selectedIsland = islands[index].islandName
                                if self.selectedIsland == "Sumatera" {
                                    if islandController.getChosenGameByRandom() {
                                        self.selectSumateraAndGetDance = true
                                    }
                                    else {
                                        self.selectSumateraAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Sulawesi" {
                                    if islandController.getChosenGameByRandom() {
                                        self.selectSulawesiAndGetDance = true
                                    }
                                    else {
                                        self.selectSulawesiAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Kalimantan" {
                                    if islandController.getChosenGameByRandom() {
                                        self.selectKalimantanAndGetDance = true
                                    }
                                    else {
                                        self.selectKalimantanAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Papua" {
                                    if islandController.getChosenGameByRandom() {
                                        self.selectPapuaAndGetDance = true
                                    }
                                    else {
                                        self.selectPapuaAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Bali" {
                                    if islandController.getChosenGameByRandom() {
                                        self.selectBaliAndGetDance = true
                                    }
                                    else {
                                        self.selectBaliAndGetLanguage = true
                                    }
                                }
                                else if self.selectedIsland == "Jawa" {
                                    if islandController.getChosenGameByRandom() {
                                        self.selectJavaAndGetDance = true
                                    }
                                    else {
                                        self.selectJavaAndGetLanguage = true
                                    }
                                }
                                
                                print(self.selectedIsland)
                                print(islandController.getChosenGameByRandom())
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
                    .padding()
                }
                
                BottomBar()
            }
        } else {
            NavigationView {
                VStack(spacing: 0) {
                    TopNavigationBar(name: "Pulau", message: "Home")
                    
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            
                            ForEach(0..<islands.count, id:\.self) { index in
                                ZStack(alignment: .center) {
                                    
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(
                                            LinearGradient(
                                                gradient: Gradient(colors: [
                                                    Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                                                    Color(red: 118/255, green: 20/255, blue: 20/255)  // #761414
                                                ]),
                                                startPoint: .top,
                                                endPoint: .bottom
                                            )
                                        )
                                        .frame(height: 180)
                                    
                                    VStack {
                                        Image(islands[index].islandImage)
                                            .resizable()
                                            .frame(width: 120, height: 100)
                                            .clipShape(RoundedRectangle(cornerRadius: 10))
                                            .padding([.leading, .trailing], 10)
                                        Spacer()
                                            .frame(height: 16)
                                        Text(islands[index].islandName)
                                            .font(.title3)
                                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                                            .foregroundColor(.white)
                                            .padding(.bottom, 10)
                                    }
                                }
                                .padding()
                                .onTapGesture {
                                    self.selectedIsland = islands[index].islandName
                                    if self.selectedIsland == "Sumatera" {
                                        if islandController.getChosenGameByRandom() {
                                            self.selectSumateraAndGetDance = true
                                        }
                                        else {
                                            self.selectSumateraAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Sulawesi" {
                                        if islandController.getChosenGameByRandom() {
                                            self.selectSulawesiAndGetDance = true
                                        }
                                        else {
                                            self.selectSulawesiAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Kalimantan" {
                                        if islandController.getChosenGameByRandom() {
                                            self.selectKalimantanAndGetDance = true
                                        }
                                        else {
                                            self.selectKalimantanAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Papua" {
                                        if islandController.getChosenGameByRandom() {
                                            self.selectPapuaAndGetDance = true
                                        }
                                        else {
                                            self.selectPapuaAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Bali" {
                                        if islandController.getChosenGameByRandom() {
                                            self.selectBaliAndGetDance = true
                                        }
                                        else {
                                            self.selectBaliAndGetLanguage = true
                                        }
                                    }
                                    else if self.selectedIsland == "Jawa" {
                                        if islandController.getChosenGameByRandom() {
                                            self.selectJavaAndGetDance = true
                                        }
                                        else {
                                            self.selectJavaAndGetLanguage = true
                                        }
                                    }
                                    
                                    print(self.selectedIsland)
                                    print(islandController.getChosenGameByRandom())
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
                        .padding()
                    }
                    
                    BottomBar()
                }
                .navigationBarHidden(true)
            }
        }
    }
}

struct BottomBar: View {
    var body: some View {
        Rectangle()
            .fill(
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 220/255, green: 38/255, blue: 38/255), // #DC2626
                        Color(red: 251/255, green: 146/255, blue: 60/255) // #FB923C
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(height: 50)
            .padding(.horizontal, -20)
            .padding(.bottom, -35)
    }
}

#Preview {
    IslandView()
}
