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
    @Published private var currentGameIsWrong: Bool = false
    @Published private var isInit: Bool = false
    
    
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
            }
        }
        if (trueCounter == ModelData.shared.currentIslandObject.traditionalDance.throwableAnswer.count) {
            correctAnswer(remainingTime: remainingTime)
        }
    }
    
    private func checkChance() {
        if (self.chance == 0) {
            self.currentGameIsWrong = true
        }
    }
    
    private func correctAnswer(remainingTime: Int) {
        
    }
    
    func accumulatePoint() {
        
    }
    
    func getTraditionalDance() -> TraditionalDance {
        return self.traditionalDance
    }
    
    func navigateToAdditionalQuestionView() {
        
    }
    
}
