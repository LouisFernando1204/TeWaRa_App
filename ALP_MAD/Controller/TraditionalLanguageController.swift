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

    func wrongAnswer() {
        
    }
    
    func changeLanguage(language: TraditionalLanguage) {
        self.traditionalLanguage = language
    }
    
    func guessWord(word : String, remainingTime: Int) {
        if (traditionalLanguage.answer == word.uppercased()) {
            correctAnswer(remainingTime: remainingTime)
        }
        else {
            wrongAnswer()
        }
    }
    
    func correctAnswer(remainingTime: Int) {
        
    }
    
    func accumulatePoint() {
        
    }
    
    func getTraditionalLanguage() -> TraditionalLanguage {
        return self.traditionalLanguage
    }
    
    func navigateToAdditionalQuestionView() {
        
    }
}
