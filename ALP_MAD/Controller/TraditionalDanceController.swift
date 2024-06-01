//
//  TraditionalDanceController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation   

class TraditionalDanceController : ObservableObject {
    
    @Published private var chance : Int = 3
    @Published private var traditionalDance: TraditionalDance = TraditionalDance(
        answer: "",
        image: "",
        description: "",
        provinceOrigin: "",
        provinceOptions: [""],
        throwableAnswer: [
            Alphabet(
                alphabet: "",
                isClicked: false
            )
        ],
        availableWords: [
            Alphabet(
                alphabet: "",
                isClicked: false
            )
        ]
    )
//    @Published private var user : User
    @Published var currentGameIsWrong: Bool = false
    @Published var currentGameIsCorrect: Bool = false
    @Published private var isInit: Bool = false
    @Published var point: Int = 0
    
    func getCurrentGameIsWrong() -> Bool {
        return self.currentGameIsWrong
    }
    
    func changeDance(dance: TraditionalDance) {
        self.traditionalDance = dance
    }
    
    func getChance() -> Int {
        return self.chance
    }
    
    private func wrongAnswer() {
        self.chance -= 1
    }
    
    func guessWord(word : Alphabet, remainingTime: Int) {
        var checker: Bool = false
        for index in ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.indices {
            if index >= 0 && index < ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.count {
                if word.alphabet == ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].alphabet {
                    print("HOHOHO")
                    checker = true
                    setThrowableAnswerStatus(alphabet: word)
                    setAvailableWordsStatus(alphabet: word)
                    checkCurrentGameAlreadyDone(remainingTime: remainingTime)
                    
                }
            }
        }
        if !checker {
            wrongAnswer()
            print("EEAA")
            setAvailableWordsStatus(alphabet: word)
            checkChance()
        }
    }
    
    private func setThrowableAnswerStatus(alphabet: Alphabet) {
        for index in ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.indices {
            let whichAlphabet = ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].alphabet
            if (whichAlphabet.isEqual(alphabet.alphabet)) {
                ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].isClicked = true
                print("KIW")
            }
        }
    }
    
    private func setAvailableWordsStatus(alphabet: Alphabet) {
        for index in ModelData.shared.currentIslandObject.traditionalDance.availableWords.indices {
            let whichAlphabet = ModelData.shared.currentIslandObject.traditionalDance.availableWords[index].alphabet
            if (whichAlphabet.isEqual(alphabet.alphabet)) {
                ModelData.shared.currentIslandObject.traditionalDance.availableWords[index].isClicked = true
                print("Ke=EW")
            }
        }
    }
    
    private func checkCurrentGameAlreadyDone(remainingTime: Int) {
        var trueCounter: Int = 0
        for index in ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.indices {
            if (ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer[index].isClicked) {
                trueCounter += 1
                print("BENER")
            }
        }
        if (trueCounter == ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.count) {
            correctAnswer(remainingTime: remainingTime)
            print("BENER2")
        }
    }
    
    private func checkChance() {
        if (self.chance == 0) {
            self.currentGameIsWrong = true
        }
    }
    
    private func correctAnswer(remainingTime: Int) {
        print("BENER3")
        self.point += (remainingTime * 10)
        self.currentGameIsCorrect = true
        ModelData.shared.currentUser.score += (remainingTime * 10)
        if traditionalDance.answer == ModelData.shared.bali.traditionalDance.answer {
            for id in ModelData.shared.bali.userList.indices {
                print(ModelData.shared.bali.userList.count)
                if ModelData.shared.bali.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.bali.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.bali.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalDance.answer == ModelData.shared.kalimantan.traditionalDance.answer {
            for id in ModelData.shared.kalimantan.userList.indices {
                if ModelData.shared.kalimantan.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.kalimantan.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.kalimantan.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalDance.answer == ModelData.shared.sumatera.traditionalDance.answer {
            for id in ModelData.shared.sumatera.userList.indices {
                if ModelData.shared.sumatera.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.sumatera.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.sumatera.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalDance.answer == ModelData.shared.sulawesi.traditionalDance.answer {
            for id in ModelData.shared.sulawesi.userList.indices {
                if ModelData.shared.sulawesi.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.sulawesi.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.sulawesi.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalDance.answer == ModelData.shared.java.traditionalDance.answer {
            for id in ModelData.shared.java.userList.indices {
                if ModelData.shared.java.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.java.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.java.userList[id].score += (remainingTime * 10)
                }
            }
        }
        else if traditionalDance.answer == ModelData.shared.papua.traditionalDance.answer {
            for id in ModelData.shared.papua.userList.indices {
                if ModelData.shared.papua.userList[id].name == ModelData.shared.currentUser.name && ModelData.shared.papua.userList[id].image == ModelData.shared.currentUser.image {
                    ModelData.shared.papua.userList[id].score += (remainingTime * 10)
                }
            }
        }

    }
    
    func accumulatePoint() {
        
    }
    
    func getTraditionalDance() -> TraditionalDance {
        return self.traditionalDance
    }
    
}
