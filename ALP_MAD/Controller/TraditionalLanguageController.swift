//
//  TraditionalLanguageController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation

class TraditionalLanguageController : ObservableObject {
    
    @Published private var traditionalLanguage: TraditionalLanguage = TraditionalLanguage(
        answer: "",
        image: "",
        description: "",
        provinceOrigin: "",
        provinceOptions: [""],
        clue: "",
        sentences: ""
    )
    
    @Published var isWrong: Bool = false
    @Published var isCorrect: Bool = false

    func wrongAnswer() {
        self.isWrong = true
    }
    
    
    func changeLanguage(language: TraditionalLanguage) {
        self.traditionalLanguage = language
    }
    
    func guessWord(word : String, remainingTime: Int) {
        if (traditionalLanguage.answer == word.uppercased()) {
            print("BENERR")
            correctAnswer(remainingTime: remainingTime)
        }
        else {
            print("HAA")
            wrongAnswer()
        }
        print(word)
        print(traditionalLanguage.answer)
        if word.uppercased() == traditionalLanguage.answer {
            print("WTF")
        }
    }
    
    func correctAnswer(remainingTime: Int) {
        self.isCorrect = true
    }
    
    func accumulatePoint() {
        
    }
    
    func getTraditionalLanguage() -> TraditionalLanguage {
        return self.traditionalLanguage
    }
    
    func navigateToAdditionalQuestionView() {
        
    }
}
