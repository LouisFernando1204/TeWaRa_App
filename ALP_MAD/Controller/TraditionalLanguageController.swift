//
//  TraditionalLanguageController.swift
//  ALP_MAD
//
//  Created by MacBook Pro on 12/05/24.
//

import Foundation
import UIKit

class TraditionalLanguageController : ObservableObject {
    
    @Published private var traditionalLanguage : TraditionalLanguage
    @Published private var user : User
    
    init(traditionalLanguage: TraditionalLanguage, user: User) {
        self.traditionalLanguage = traditionalLanguage
        self.user = user
    }
    
    func getUser() -> User {
        return self.user
    }
    
    func wrongAnswer() {
        
    }
    
    func guessWord(word : String) {
        
    }
    
    func correctAnswer() {
        
    }
    
    func accumulatePoint() {
        
    }
    
    func getTraditionalLanguage() -> TraditionalLanguage {
        return self.traditionalLanguage
    }
    
    func navigateToAdditionalQuestionView() {
        
    }
}
