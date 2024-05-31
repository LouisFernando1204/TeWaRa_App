//
//  IslandController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation

class IslandController : ObservableObject {
    
    @Published private var island : Island
    
    @Published private var newScore : Int
    
    init(island: Island) {
        self.island = island
        self.newScore = 0
    }
    
    func getNewScore() -> Int {
        return self.newScore
    }
    
    func getIsland() -> Island {
        return self.island
    }
    
    func navigateToPlaySumateraGame() {
        
    }
    
    func navigateToPlayKalimantanGame() {
        
    }
    
    func navigateToPlayPapuaGame() {
        
    }
    
    func navigateToPlaySulawesiGame() {
        
    }
    
    func navigateToPlayBaliGame() {
        
    }
    
    func navigateToPlayJavaGame() {
        
    }
    
    func checkTheAnswer(word: String, currentIsland: String, currentGame: String, timer: Int) {
        if currentGame == "TraditionalDance" {
            if word == self.island.traditionalDance.provinceOrigin {
                self.newScore = timer * 20
                if let index = self.island.userList.firstIndex(where: { $0.name == ModelData.shared.currentUser.name }) {
                    self.island.userList[index].score += self.newScore
                    ModelData.shared.currentUser.score += self.newScore
                    ModelData.shared.currentIslandObject.userList[index].score += self.newScore
                    if currentIsland == "Sumatera" {
                        ModelData.shared.sumatera.userList[index].score += self.newScore
                    }
                    else if currentIsland == "Bali" {
                        ModelData.shared.bali.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Java" {
                        ModelData.shared.java.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Kalimantan" {
                        ModelData.shared.kalimantan.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Papua" {
                        ModelData.shared.papua.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Sulawesi" {
                        ModelData.shared.sulawesi.userList[index].score += self.newScore
                    }
                }
            }
        }
        else{
            if word == self.island.traditionalLanguage.provinceOrigin {
                self.newScore = timer * 10
                if let index = self.island.userList.firstIndex(where: { $0.name == ModelData.shared.currentUser.name }) {
                    self.island.userList[index].score += self.newScore
                    ModelData.shared.currentUser.score += self.newScore
                    ModelData.shared.currentIslandObject.userList[index].score += self.newScore
                    if currentIsland == "Sumatera" {
                        ModelData.shared.sumatera.userList[index].score += self.newScore
                    }
                    else if currentIsland == "Bali" {
                        ModelData.shared.bali.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Java" {
                        ModelData.shared.java.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Kalimantan" {
                        ModelData.shared.kalimantan.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Papua" {
                        ModelData.shared.papua.userList[index].score += self.newScore
                        
                    }
                    else if currentIsland == "Sulawesi" {
                        ModelData.shared.sulawesi.userList[index].score += self.newScore
                    }
                }
            }
        }
    }
    
    func showTraditionalDanceDescription() -> TraditionalDance {
        return self.island.traditionalDance
    }
    
    func showTraditionalLanguageDescription() -> TraditionalLanguage {
        return self.island.traditionalLanguage
    }
}
