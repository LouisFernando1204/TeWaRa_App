//
//  TraditionalDanceController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation   

class TraditionalDanceController : ObservableObject {
    
    @Published private var chance : Int
    @Published private var traditionalDance : TraditionalDance
//    @Published private var user : User
    @Published private var currentGameIsWrong: Bool = false
    
    init(traditionalDance: TraditionalDance) {
        self.traditionalDance = traditionalDance
        self.chance = 3
//        self.user = user
    }
    
    func getCurrentGameIsWrong() -> Bool {
        return self.currentGameIsWrong
    }
    
//    func getUser() -> User {
//        return self.user
//    }
    
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
        for index in traditionalDance.throwableAnswer.indices {
            if index >= 0 && index < traditionalDance.throwableAnswer.count {
                if word.alphabet == traditionalDance.throwableAnswer[index].alphabet {
                    checker = true
                    setThrowableAnswerStatus(alphabet: word)
                    setAvailableWordsStatus(alphabet: word)
                    checkCurrentGameAlreadyDone(remainingTime: remainingTime)
                    
                }
            }
        }
        if !checker {
            wrongAnswer()
            setAvailableWordsStatus(alphabet: word)
            checkChance()
        }
    }
    
    private func setThrowableAnswerStatus(alphabet: Alphabet) {
        for index in traditionalDance.throwableAnswer.indices {
            let whichAlphabet = traditionalDance.throwableAnswer[index].alphabet
            if (whichAlphabet.isEqual(alphabet.alphabet)) {
                traditionalDance.throwableAnswer[index].isClicked = true
            }
        }
    }
    
    private func setAvailableWordsStatus(alphabet: Alphabet) {
        for index in traditionalDance.availableWords.indices {
            let whichAlphabet = traditionalDance.availableWords[index].alphabet
            if (whichAlphabet.isEqual(alphabet.alphabet)) {
                traditionalDance.availableWords[index].isClicked = true
            }
        }
    }
    
    private func checkCurrentGameAlreadyDone(remainingTime: Int) {
        var trueCounter: Int = 0
        for index in traditionalDance.throwableAnswer.indices {
            if (traditionalDance.throwableAnswer[index].isClicked) {
                trueCounter += 1
            }
        }
        if (trueCounter == traditionalDance.throwableAnswer.count) {
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
