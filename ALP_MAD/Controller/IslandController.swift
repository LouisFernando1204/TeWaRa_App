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
        
    @Published private var chooseGameByRandom : Bool
    
    @Published private var isThere: Bool = false
    
    init(island: Island) {
        self.island = island
        self.newScore = 0
        self.chooseGameByRandom = Bool.random()
    }
    
    func getNewScore() -> Int {
        return self.newScore
    }
    
    func getIsland() -> Island {
        return self.island
    }
    
    func getChosenGameByRandom() -> Bool {
        return self.chooseGameByRandom
    }
    
    func addUserToArray(islandName: String) {
        print("aaaaa \(islandName)")
        if islandName == ModelData.shared.bali.islandName {
            print("a bali")
            for id in ModelData.shared.bali.userList.indices {
                if ModelData.shared.bali.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.bali.userList[id].image == ModelData.shared.currentUser.image {
                    self.isThere = true
                }
            }
            if (!isThere) {
                print("add array bali")
                ModelData.shared.bali.userList.append(ModelData.shared.currentUser)
                print("isi bali \(ModelData.shared.bali.userList.count)")
            }
        }
        else if islandName == ModelData.shared.kalimantan.islandName {
            for id in ModelData.shared.kalimantan.userList.indices {
                if ModelData.shared.kalimantan.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.kalimantan.userList[id].image == ModelData.shared.currentUser.image {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.kalimantan.userList.append(ModelData.shared.currentUser)
            }
        }
        else if islandName == ModelData.shared.sumatera.islandName {
            for id in ModelData.shared.sumatera.userList.indices {
                if ModelData.shared.sumatera.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.sumatera.userList[id].image == ModelData.shared.currentUser.image {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.sumatera.userList.append(ModelData.shared.currentUser)
            }
        }
        else if islandName == ModelData.shared.sulawesi.islandName {
            for id in ModelData.shared.sulawesi.userList.indices {
                if ModelData.shared.sulawesi.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.sulawesi.userList[id].image == ModelData.shared.currentUser.image {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.sulawesi.userList.append(ModelData.shared.currentUser)
            }
        }
        else if islandName == ModelData.shared.java.islandName {
            for id in ModelData.shared.java.userList.indices {
                if ModelData.shared.java.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.java.userList[id].image == ModelData.shared.currentUser.image {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.java.userList.append(ModelData.shared.currentUser)
            }
        }
        else if islandName == ModelData.shared.papua.traditionalLanguage.answer {
            for id in ModelData.shared.papua.userList.indices {
                if ModelData.shared.papua.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.papua.userList[id].image == ModelData.shared.currentUser.image {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.papua.userList.append(ModelData.shared.currentUser)
            }
        }
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
