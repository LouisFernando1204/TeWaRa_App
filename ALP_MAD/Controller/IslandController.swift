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
        
        print("heheh \(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.java))")
        
        for id in ModelData.shared.sumatera.traditionalDance.throwableAnswer.indices {
            ModelData.shared.sumatera.traditionalDance.throwableAnswer[id].isClicked = false
        }
        for id in ModelData.shared.sumatera.traditionalDance.availableWords.indices {
            ModelData.shared.sumatera.traditionalDance.availableWords[id].isClicked = false
        }
        
        for id in ModelData.shared.sulawesi.traditionalDance.throwableAnswer.indices {
            ModelData.shared.sulawesi.traditionalDance.throwableAnswer[id].isClicked = false
        }
        for id in ModelData.shared.sulawesi.traditionalDance.availableWords.indices {
            ModelData.shared.sulawesi.traditionalDance.availableWords[id].isClicked = false
        }
        
        for id in ModelData.shared.kalimantan.traditionalDance.throwableAnswer.indices {
            ModelData.shared.kalimantan.traditionalDance.throwableAnswer[id].isClicked = false
        }
        for id in ModelData.shared.kalimantan.traditionalDance.availableWords.indices {
            ModelData.shared.kalimantan.traditionalDance.availableWords[id].isClicked = false
        }
        
        for id in ModelData.shared.bali.traditionalDance.throwableAnswer.indices {
            ModelData.shared.bali.traditionalDance.throwableAnswer[id].isClicked = false
        }
        for id in ModelData.shared.bali.traditionalDance.availableWords.indices {
            ModelData.shared.bali.traditionalDance.availableWords[id].isClicked = false
        }
        
        for id in ModelData.shared.papua.traditionalDance.throwableAnswer.indices {
            ModelData.shared.papua.traditionalDance.throwableAnswer[id].isClicked = false
        }
        for id in ModelData.shared.papua.traditionalDance.availableWords.indices {
            ModelData.shared.papua.traditionalDance.availableWords[id].isClicked = false
        }
        
        for id in ModelData.shared.java.traditionalDance.throwableAnswer.indices {
            ModelData.shared.java.traditionalDance.throwableAnswer[id].isClicked = false
        }
        for id in ModelData.shared.java.traditionalDance.availableWords.indices {
            ModelData.shared.java.traditionalDance.availableWords[id].isClicked = false
        }
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
        if islandName == ModelData.shared.bali.islandName {
            for id in ModelData.shared.bali.userList.indices {
                if ModelData.shared.bali.userList[id].name == ModelData.shared.currentUser.name {
                    self.isThere = true
                }
            }
            if (!isThere) {
                print("add array bali")
                ModelData.shared.bali.userList.append(ModelData.shared.currentUser)
                ModelData.shared.bali.userList[3].score = 0
                print("isi bali \(ModelData.shared.bali.userList.count)")
            }
        }
        else if islandName == ModelData.shared.kalimantan.islandName {
            for id in ModelData.shared.kalimantan.userList.indices {
                if ModelData.shared.kalimantan.userList[id].name == ModelData.shared.currentUser.name {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.kalimantan.userList.append(ModelData.shared.currentUser)
                ModelData.shared.kalimantan.userList[3].score = 0
                
            }
        }
        else if islandName == ModelData.shared.sumatera.islandName {
            for id in ModelData.shared.sumatera.userList.indices {
                if ModelData.shared.sumatera.userList[id].name == ModelData.shared.currentUser.name {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.sumatera.userList.append(ModelData.shared.currentUser)
                ModelData.shared.sumatera.userList[3].score = 0
                
            }
        }
        else if islandName == ModelData.shared.sulawesi.islandName {
            for id in ModelData.shared.sulawesi.userList.indices {
                if ModelData.shared.sulawesi.userList[id].name == ModelData.shared.currentUser.name {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.sulawesi.userList.append(ModelData.shared.currentUser)
                ModelData.shared.sulawesi.userList[3].score = 0
                
            }
        }
        else if islandName == ModelData.shared.java.islandName {
            for id in ModelData.shared.java.userList.indices {
                if ModelData.shared.java.userList[id].name == ModelData.shared.currentUser.name {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.java.userList.append(ModelData.shared.currentUser)
                ModelData.shared.java.userList[3].score = 0
                
            }
        }
        else if islandName == ModelData.shared.papua.traditionalLanguage.answer {
            for id in ModelData.shared.papua.userList.indices {
                if ModelData.shared.papua.userList[id].name == ModelData.shared.currentUser.name {
                    self.isThere = true
                }
            }
            if (!isThere) {
                ModelData.shared.papua.userList.append(ModelData.shared.currentUser)
                ModelData.shared.papua.userList[3].score = 0
                
            }
        }
    }
    
    func checkTheAnswer(word: String, currentIsland: String, currentGame: String, timer: Int) {
        print("\(word) ... \(currentIsland) ... \(currentGame) ... \(timer)")
        
        if ModelData.shared.currentGame == "TraditionalDance" {
            if word == self.island.traditionalDance.provinceOrigin {
                self.newScore = timer * 10
                print("masuk 1")
                if let index = self.island.userList.firstIndex(where: { $0.name == ModelData.shared.currentUser.name }) {
                    print("masuk 2")
                    self.island.userList[index].score += self.newScore
                    ModelData.shared.currentUser.score += self.newScore
                    ModelData.shared.currentIslandObject.userList[index].score += self.newScore
                    if self.island.islandName == "Sumatera" {
                        ModelData.shared.sumatera.userList[index].score += self.newScore
                    }
                    else if self.island.islandName == "Bali" {
                        print("masuk 3")
                        ModelData.shared.bali.userList[index].score += self.newScore
                        print(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.bali)[0])
                    }
                    else if self.island.islandName == "Jawa" {
                        ModelData.shared.java.userList[index].score += self.newScore
                        
                    }
                    else if self.island.islandName == "Kalimantan" {
                        ModelData.shared.kalimantan.userList[index].score += self.newScore
                        
                    }
                    else if self.island.islandName == "Papua" {
                        ModelData.shared.papua.userList[index].score += self.newScore
                        
                    }
                    else if self.island.islandName == "Sulawesi" {
                        ModelData.shared.sulawesi.userList[index].score += self.newScore
                    }
                }
            }
        }
        else{
            print(" s ")
            print(word)
            print(self.island.traditionalLanguage.provinceOrigin)
            if word == self.island.traditionalLanguage.provinceOrigin {
                self.newScore = timer * 10
                print("masuk 1")
                if let index = self.island.userList.firstIndex(where: { $0.name == ModelData.shared.currentUser.name }) {
                    print("masuk 2")
                    self.island.userList[index].score += self.newScore
                    ModelData.shared.currentUser.score += self.newScore
                    ModelData.shared.currentIslandObject.userList[index].score += self.newScore
                    if self.island.islandName == "Sumatera" {
                        ModelData.shared.sumatera.userList[index].score += self.newScore
                    }
                    else if self.island.islandName == "Bali" {
                        print("masuk 3")
                        ModelData.shared.bali.userList[index].score += self.newScore
                        print(ModelData.shared.getCurrentUserPointByIsland(name: ModelData.shared.currentUser.name, island: ModelData.shared.bali)[0])
                    }
                    else if self.island.islandName == "Jawa" {
                        ModelData.shared.java.userList[index].score += self.newScore
                        
                    }
                    else if self.island.islandName == "Kalimantan" {
                        ModelData.shared.kalimantan.userList[index].score += self.newScore
                        
                    }
                    else if self.island.islandName == "Papua" {
                        ModelData.shared.papua.userList[index].score += self.newScore
                        
                    }
                    else if self.island.islandName == "Sulawesi" {
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
